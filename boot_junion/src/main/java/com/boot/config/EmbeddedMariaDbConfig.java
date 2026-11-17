package com.boot.config;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.nio.file.Files;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.util.FileSystemUtils;

import ch.vorburger.exec.ManagedProcessException;
import ch.vorburger.mariadb4j.DB;
import ch.vorburger.mariadb4j.DBConfigurationBuilder;

/**
 * 내장 MariaDB 설정.
 *
 * 앱을 실행하면 MariaDB가 함께 기동되므로 별도의 DB 설치 없이 실행할 수 있다.
 * - 데이터는 {@code junion.embedded-db.data-dir}(기본: ./db-data)에 저장되어 재시작해도 유지된다.
 * - 최초 기동 시(데이터 폴더에 DB가 없을 때)만 classpath의 db/schema.sql, db/data.sql, db/data-images.sql 을 실행한다.
 * - 기동할 때마다 db/sample-upload/ 의 샘플 이미지를 업로드 폴더(C:/devv/upload/sample)에 없으면 복사한다.
 * - DB를 초기화하려면 앱을 끄고 db-data 폴더를 삭제한 뒤 다시 실행하면 된다.
 *   (강제 종료로 mysqld 프로세스가 남아 있으면 먼저 종료해야 폴더가 지워진다)
 *
 * 외부 MySQL(예: 팀 공용 DB)을 쓰려면 junion.embedded-db.enabled=false 로 두고
 * spring.datasource.url 을 해당 DB로 바꾸면 된다.
 */
@Configuration
@ConditionalOnProperty(name = "junion.embedded-db.enabled", havingValue = "true", matchIfMissing = true)
public class EmbeddedMariaDbConfig {

	private static final Logger log = LoggerFactory.getLogger(EmbeddedMariaDbConfig.class);

	/** 업로드 컨트롤러들에 하드코딩된 업로드 폴더 (컨트롤러와 똑같은 문자열로 경로를 만들어야 OS와 무관하게 일치한다) */
	private static final String UPLOAD_ROOT = "C:\\devv\\upload\\";
	/** 샘플 이미지의 uploadPath (data-images.sql) */
	private static final String SAMPLE_PATH = "sample";

	@Value("${junion.embedded-db.port:13306}")
	private int port;

	@Value("${junion.embedded-db.data-dir:./db-data}")
	private String dataDir;

	@Value("${junion.embedded-db.name:junion}")
	private String dbName;

	@Bean(destroyMethod = "stop")
	public EmbeddedDb embeddedMariaDb() throws ManagedProcessException {
		File root = new File(dataDir).getAbsoluteFile();
		File data = new File(root, "data");
		boolean fresh = !new File(data, dbName).isDirectory();

		copySampleImages();

		if (isPortInUse(port)) {
			if (!fresh) {
				// IDE 의 강제 종료(Eclipse 빨간 정지 버튼 등)로 이전 실행의 DB 프로세스가 남아 있는 경우 그대로 재사용한다.
				log.warn("Port {} is already in use - reusing the embedded MariaDB left over from a previous run.", port);
				return new EmbeddedDb(null);
			}
			throw new IllegalStateException("내장 DB 포트 " + port + " 를 다른 프로그램이 사용 중입니다. "
					+ "application.properties 의 junion.embedded-db.port 와 spring.datasource.url 의 포트를 함께 바꿔주세요.");
		}

		DBConfigurationBuilder config = DBConfigurationBuilder.newBuilder();
		// 함께 포함된 바이너리 버전 (build.gradle 의 mariaDB4j-db-* 와 일치해야 함)
		config.setDatabaseVersion(config.isWindows() ? "mariadb-10.11.5-fix1"
				: config.isMacOS() ? "mariadb-10.2.11" : "mariadb-10.11.5");
		config.setPort(port);
		config.setBaseDir(new File(root, "base"));
		config.setDataDir(data);
		config.setTmpDir(new File(root, "tmp").getPath());
		config.setDeletingTemporaryBaseAndDataDirsOnShutdown(false);
		config.setDefaultCharacterSet("utf8mb4");
		config.addArg("--character-set-server=utf8mb4");
		config.addArg("--collation-server=utf8mb4_general_ci");
		// 매퍼에 chatRoom_tb / chatroom_tb 처럼 대소문자가 섞여 있어 OS와 무관하게 동일하게 동작하도록 함
		config.addArg("--lower_case_table_names=1");
		// 인증 없이 동작하므로 외부 접속은 막는다
		config.addArg("--bind-address=127.0.0.1");
		// 역설계한 스키마라 NOT NULL/기본값이 원본과 다를 수 있어 엄격 모드는 끈다
		config.addArg("--sql-mode=NO_ENGINE_SUBSTITUTION");
		config.addArg("--default-time-zone=+09:00");

		log.info("Starting embedded MariaDB on port {} (data: {})", port, data);
		DB db = DB.newEmbeddedDB(config.build());
		db.start();

		if (fresh) {
			log.info("Initializing database '{}' from db/schema.sql and db/data.sql", dbName);
			try {
				db.createDB(dbName);
				db.source("db/schema.sql", "root", null, dbName);
				db.source("db/data.sql", "root", null, dbName);
				db.source("db/data-images.sql", "root", null, dbName);
			} catch (ManagedProcessException | RuntimeException e) {
				// 초기화가 중간에 실패하면 다음 실행 때 다시 초기화되도록 데이터 폴더를 지운다
				db.stop();
				FileSystemUtils.deleteRecursively(data);
				throw e;
			}
		}
		return new EmbeddedDb(db);
	}

	/**
	 * data-images.sql 의 첨부 행이 가리키는 샘플 이미지를 업로드 폴더로 복사한다 (이미 있으면 건너뜀).
	 * 화면은 썸네일(s_uuid_파일명)을, 다운로드는 원본(uuid_파일명)을 읽으므로 둘 다 만든다.
	 */
	private void copySampleImages() {
		try {
			Resource[] files = new PathMatchingResourcePatternResolver()
					.getResources("classpath:db/sample-upload/*.*");
			int copied = 0;
			for (Resource file : files) {
				String name = file.getFilename();
				if (name == null || name.endsWith(".txt")) {
					continue;
				}
				String uuid = "seed-" + name.substring(0, name.lastIndexOf('.'));
				for (String target : new String[] { "s_" + uuid + "_" + name, uuid + "_" + name }) {
					File dest = new File(UPLOAD_ROOT + SAMPLE_PATH + "/" + target);
					if (dest.exists()) {
						continue;
					}
					dest.getParentFile().mkdirs();
					try (InputStream in = file.getInputStream()) {
						Files.copy(in, dest.toPath());
					}
					copied++;
				}
			}
			if (copied > 0) {
				log.info("Copied {} sample image files to {}{}", copied, UPLOAD_ROOT, SAMPLE_PATH);
			}
		} catch (IOException | RuntimeException e) {
			// 이미지가 없어도 앱은 동작하므로 경고만 남긴다
			log.warn("Could not copy sample images to {}{}: {}", UPLOAD_ROOT, SAMPLE_PATH, e.toString());
		}
	}

	private static boolean isPortInUse(int port) {
		try (Socket socket = new Socket()) {
			socket.connect(new InetSocketAddress("127.0.0.1", port), 500);
			return true;
		} catch (IOException e) {
			return false;
		}
	}

	/** 직접 띄운 DB만 종료하기 위한 래퍼 (재사용한 DB는 건드리지 않음). */
	public static class EmbeddedDb {
		private final DB db;

		EmbeddedDb(DB db) {
			this.db = db;
		}

		public void stop() throws ManagedProcessException {
			if (db != null) {
				db.stop();
			}
		}
	}

	/** 내장 DB가 완전히 뜬 뒤에 커넥션 풀이 만들어지도록 DB 빈에 의존시킨다. */
	@Bean
	@Primary
	public DataSource dataSource(EmbeddedDb embeddedMariaDb, DataSourceProperties properties) {
		return properties.initializeDataSourceBuilder().build();
	}
}
