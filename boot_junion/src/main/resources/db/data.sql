-- =====================================================================
-- junion 초기 데이터
--  1) 화면 동작에 꼭 필요한 기준 데이터 (job / stack / location / career / 데일리 CS)
--  2) 바로 둘러볼 수 있는 테스트 계정과 샘플 데이터
--     (날짜는 DB 초기화 시점 기준 상대값이라 항상 "최근 데이터"처럼 보인다)
--  3) 샘플 이미지 첨부 행은 data-images.sql 에 있다 (파일은 db/sample-upload/ 에서 복사됨)
--
-- 테스트 계정 (비밀번호는 모두 1234, 앱이 평문으로 비교함)
--   관리자    admin@admin.com   (공지사항/이용약관 작성 권한은 이 이메일로 판별)
--   개인회원  user1@test.com ~ user6@test.com
--   기업회원  com1@test.com ~ com6@test.com
-- =====================================================================

SET NAMES utf8mb4;

-- =====================================================================
-- 1. 기준 데이터
-- =====================================================================

INSERT INTO job (job_no, job_name) VALUES
 (100,'백엔드 개발자'),(101,'프론트엔드 개발자'),(102,'풀스택 개발자'),(103,'안드로이드 개발자'),
 (104,'iOS 개발자'),(105,'데이터 엔지니어'),(106,'DevOps/인프라 엔지니어'),(107,'게임 개발자'),
 (200,'UI/UX 디자이너'),(201,'웹 디자이너'),(202,'그래픽 디자이너'),(203,'영상 디자이너'),(204,'BX 디자이너'),
 (300,'서비스 기획자'),(301,'PM/PO'),(302,'데이터 분석가'),(303,'마케팅 기획자'),(304,'사업 기획자');

-- 이름은 comRegistUpload.jsp 에 주석으로 남아 있던 원래 버튼 목록 기준 (LIKE BINARY 비교라 대소문자 유지)
INSERT INTO stack (stack_no, stack_name) VALUES
 (400,'JAVA'),(401,'iOS'),(402,'Android'),(403,'PHP'),(404,'ASP'),(405,'.NET'),(406,'JavaScript'),
 (407,'Node.js'),(408,'React.js'),(409,'Vue.js'),(410,'DB'),(411,'C'),(412,'C++'),
 (500,'Adobe XD'),(501,'Sketch'),(502,'Zepline'),(503,'Premiere'),(504,'After Effect'),(505,'Lightroom'),(506,'InDesign'),
 (600,'Excel'),(601,'Power Point'),(602,'MS 오피스'),(603,'Notion'),(604,'Google Apps'),(605,'Slack'),(606,'Asana'),(607,'Cloud');

-- 화면의 시/도 선택 목록과 같은 2글자 표기
INSERT INTO location (location_name) VALUES
 ('서울'),('경기'),('인천'),('강원'),('충북'),('충남'),('대전'),('전북'),
 ('전남'),('광주'),('경북'),('경남'),('대구'),('울산'),('부산'),('제주');

INSERT INTO career (career_name) VALUES ('신입'),('1~3년'),('3~5년'),('5~7년'),('경력무관');

-- ---------------------------------------------------------------------
-- 데일리 CS (탭 값: Java / Spring / Javascript / HTML/CSS, 보기는 콤마 구분이라 보기 안에 콤마 금지)
-- ---------------------------------------------------------------------
INSERT INTO cs_tb (cs_num, cs_type, cs_answer_num) VALUES
 (1,'Java',2),(2,'Java',3),(3,'Java',1),(4,'Java',4),(5,'Java',2),(6,'Java',3),
 (7,'Spring',2),(8,'Spring',1),(9,'Spring',3),(10,'Spring',4),(11,'Spring',1),(12,'Spring',2),
 (13,'Javascript',3),(14,'Javascript',2),(15,'Javascript',4),(16,'Javascript',1),(17,'Javascript',3),(18,'Javascript',2),
 (19,'HTML/CSS',1),(20,'HTML/CSS',2),(21,'HTML/CSS',3),(22,'HTML/CSS',4),(23,'HTML/CSS',2),(24,'HTML/CSS',1);

INSERT INTO cs_question_tb (cs_num, cs_question_title, cs_question_option, cs_question_explanation) VALUES
 (1,'다음 중 불변(immutable) 객체인 것은?','StringBuilder,String,ArrayList,HashMap','String 은 한 번 생성되면 값이 바뀌지 않는 불변 객체입니다. 문자열을 자주 바꿔야 한다면 StringBuilder 를 사용합니다.'),
 (2,'Java에서 모든 클래스의 최상위 부모 클래스는?','Class,System,Object,Main','모든 클래스는 암묵적으로 java.lang.Object 를 상속합니다. equals / hashCode / toString 이 여기에 정의되어 있습니다.'),
 (3,'중복을 허용하지 않는 컬렉션 인터페이스는?','Set,List,Queue,Deque','Set 은 같은 요소를 두 번 저장하지 않습니다. 대표 구현체로 HashSet / TreeSet 이 있습니다.'),
 (4,'다음 중 checked exception 은?','NullPointerException,ArrayIndexOutOfBoundsException,IllegalArgumentException,IOException','IOException 은 컴파일 시점에 처리(try-catch 또는 throws)를 강제하는 checked exception 입니다.'),
 (5,'equals()를 재정의할 때 함께 재정의해야 하는 메서드는?','toString(),hashCode(),clone(),finalize()','equals 가 같다면 hashCode 도 같아야 HashMap / HashSet 이 올바르게 동작합니다.'),
 (6,'JVM에서 객체 인스턴스가 저장되는 메모리 영역은?','Stack,Method Area,Heap,PC Register','new 로 생성한 객체는 Heap 에 저장되고 GC 의 관리 대상이 됩니다.'),
 (7,'Spring에서 의존성 주입(DI)에 쓰는 어노테이션은?','@Controller,@Autowired,@RequestMapping,@Value','@Autowired 는 타입으로 빈을 찾아 주입합니다. 최근에는 생성자 주입을 권장합니다.'),
 (8,'Spring MVC에서 요청을 처음 받아 컨트롤러로 넘기는 것은?','DispatcherServlet,ViewResolver,HandlerAdapter,Filter','DispatcherServlet 이 프론트 컨트롤러 역할을 하며 HandlerMapping 으로 컨트롤러를 찾습니다.'),
 (9,'트랜잭션을 선언적으로 적용하는 어노테이션은?','@Repository,@Service,@Transactional,@Bean','@Transactional 은 메서드 또는 클래스에 트랜잭션 경계를 설정합니다. 기본적으로 RuntimeException 발생 시 롤백됩니다.'),
 (10,'Spring 빈의 기본 스코프는?','prototype,request,session,singleton','별도 설정이 없으면 빈은 컨테이너당 하나만 생성되는 singleton 스코프입니다.'),
 (11,'JSON 요청 본문을 객체로 받을 때 쓰는 어노테이션은?','@RequestBody,@RequestParam,@PathVariable,@ModelAttribute','@RequestBody 는 HttpMessageConverter 로 요청 본문을 객체로 변환합니다.'),
 (12,'AOP에서 실제로 부가 기능이 적용되는 지점을 뜻하는 용어는?','Advice,Join Point,Aspect,Weaving','Join Point 는 Advice 가 적용될 수 있는 실행 지점(메서드 실행 등)입니다.'),
 (13,'블록 스코프를 가지며 재할당할 수 없는 선언은?','var,let,const,function','const 는 블록 스코프이고 재할당할 수 없습니다. 단 객체 내부 값은 바꿀 수 있습니다.'),
 (14,'typeof null 의 결과는?','null,object,undefined,number','초기 JavaScript 구현의 버그가 호환성 때문에 남아 typeof null 은 object 입니다.'),
 (15,'배열의 각 요소로 새 배열을 만드는 메서드는?','forEach,filter,reduce,map','map 은 콜백의 반환값으로 새 배열을 만들어 반환합니다.'),
 (16,'비동기 작업의 완료/실패를 나타내는 객체는?','Promise,Callback,Event,Generator','Promise 는 pending / fulfilled / rejected 세 가지 상태를 가집니다.'),
 (17,'== 와 === 의 차이로 옳은 것은?','둘 다 같다,== 가 더 엄격하다,=== 는 타입까지 비교한다,=== 는 객체에만 쓴다','=== 는 형 변환 없이 값과 타입을 모두 비교합니다.'),
 (18,'이벤트가 하위 요소에서 상위 요소로 전파되는 현상은?','캡처링,버블링,위임,디바운싱','이벤트 버블링을 이용하면 상위 요소 하나에서 여러 자식의 이벤트를 처리(이벤트 위임)할 수 있습니다.'),
 (19,'가장 큰 제목을 나타내는 HTML 태그는?','h1,h6,header,title','h1 이 가장 높은 수준의 제목입니다. 페이지당 하나를 쓰는 것이 일반적입니다.'),
 (20,'Flexbox에서 주축 방향 정렬 속성은?','align-items,justify-content,flex-wrap,order','justify-content 는 주축(main axis) 정렬을 담당합니다.'),
 (21,'요소를 가장 가까운 위치 지정 조상 기준으로 배치하는 position 값은?','static,relative,absolute,sticky','absolute 는 문서 흐름에서 빠지고 가장 가까운 positioned 조상을 기준으로 배치됩니다.'),
 (22,'CSS 선택자 우선순위가 가장 높은 것은?','태그 선택자,클래스 선택자,ID 선택자,인라인 style','인라인 style 이 가장 높고 그다음 ID / 클래스 / 태그 순입니다 (!important 제외).'),
 (23,'이미지의 대체 텍스트를 지정하는 속성은?','title,alt,src,name','alt 는 이미지를 볼 수 없을 때 보여지고 스크린 리더가 읽어 접근성에 중요합니다.'),
 (24,'box-sizing: border-box 의 의미는?','width에 padding과 border를 포함한다,width에 margin을 포함한다,content만 width로 계산한다,border를 숨긴다','border-box 는 width / height 에 padding 과 border 까지 포함해 계산합니다.');

INSERT INTO cs_user (cs_num, user_email, cs_user_check)
SELECT cs_num, NULL, '미참여' FROM cs_tb;
UPDATE cs_user SET user_email = 'user1@test.com', cs_user_check = '참여' WHERE cs_num IN (1, 7, 13);

-- =====================================================================
-- 2. 회원
-- =====================================================================

INSERT INTO user_tb (user_email, user_pw, user_pw_check, user_name, user_questionNum, user_questionAnswer, user_type,
                     user_tel, user_location, user_location2, user_birthdate, user_gender, recent_noticeNumArray) VALUES
 ('admin@admin.com','1234','1234','관리자',1,'관리자','1','010-0000-0000','서울','강남구','1990-01-01','남',NULL),
 ('user1@test.com','1234','1234','김개발',1,'서울','1','010-1111-1111','서울','마포구','1997-03-15','남','1,2,5'),
 ('user2@test.com','1234','1234','이디자',2,'초코','1','010-2222-2222','경기','성남시','1999-08-21','여','3,9'),
 ('user3@test.com','1234','1234','박프론',3,'부산','1','010-3333-3333','서울','성동구','1998-11-02','여','2,6'),
 ('user4@test.com','1234','1234','최데이',4,'수학','1','010-4444-4444','대전','유성구','1995-05-30','남','7,12'),
 ('user5@test.com','1234','1234','정기획',5,'파랑','1','010-5555-5555','서울','영등포구','1996-01-19','여','10'),
 ('user6@test.com','1234','1234','한모바',6,'바다','1','010-6666-6666','부산','해운대구','2000-07-07','남','11,13');

INSERT INTO user_job (user_email, job_name) VALUES
 ('user1@test.com','백엔드 개발자'),('user1@test.com','풀스택 개발자'),
 ('user2@test.com','UI/UX 디자이너'),('user2@test.com','웹 디자이너'),
 ('user3@test.com','프론트엔드 개발자'),
 ('user4@test.com','데이터 엔지니어'),('user4@test.com','데이터 분석가'),
 ('user5@test.com','서비스 기획자'),('user5@test.com','PM/PO'),
 ('user6@test.com','안드로이드 개발자'),('user6@test.com','iOS 개발자');

INSERT INTO user_stack (user_email, stack_name) VALUES
 ('user1@test.com','JAVA'),('user1@test.com','DB'),('user1@test.com','JavaScript'),('user1@test.com','Cloud'),
 ('user2@test.com','Adobe XD'),('user2@test.com','Sketch'),('user2@test.com','Zepline'),('user2@test.com','Notion'),
 ('user3@test.com','JavaScript'),('user3@test.com','React.js'),('user3@test.com','Vue.js'),('user3@test.com','Node.js'),
 ('user4@test.com','DB'),('user4@test.com','JAVA'),('user4@test.com','Excel'),('user4@test.com','Cloud'),
 ('user5@test.com','Notion'),('user5@test.com','Excel'),('user5@test.com','Power Point'),('user5@test.com','Asana'),
 ('user6@test.com','Android'),('user6@test.com','iOS'),('user6@test.com','JAVA'),('user6@test.com','Slack');

INSERT INTO com_tb (com_email, com_pw, com_pw_check, com_name, com_serial_number, user_type, com_tel, com_person,
                    com_location, com_year, com_content, com_sale, com_type, com_salary, com_CEO, com_site, com_employee) VALUES
 ('com1@test.com','1234','1234','주니온테크','1234567890','2','02-111-1111','박인사',
  '서울 강남구 테헤란로 152','2015-04-01',
  '주니온테크는 주니어 개발자와 기업을 연결하는 채용 플랫폼과 HR SaaS를 만드는 회사입니다. 데이터 기반 매칭으로 지원자와 기업 모두 시간을 아낄 수 있도록 돕고 있으며, 코드 리뷰와 페어 프로그래밍이 일상인 개발 문화를 가지고 있습니다.',
  '1200000','주식회사',4800,'최대표','https://example.com/juniontech',120),
 ('com2@test.com','1234','1234','디자인랩','0987654321','2','031-222-2222','정담당',
  '경기 성남시 분당구 판교역로 166','2019-09-10',
  '디자인랩은 브랜드 경험과 디지털 서비스 디자인을 전문으로 하는 스튜디오입니다. 리서치부터 UI 설계, 디자인 시스템 구축까지 서비스의 처음과 끝을 함께 고민합니다.',
  '350000','유한회사',4200,'한대표','https://example.com/designlab',35),
 ('com3@test.com','1234','1234','클라우드브릿지','1112223334','2','02-333-3333','윤채용',
  '서울 성동구 왕십리로 83-21','2017-02-15',
  '클라우드브릿지는 기업의 온프레미스 시스템을 클라우드로 옮기고 운영하는 인프라 전문 기업입니다. 쿠버네티스 기반 플랫폼과 24시간 관제 서비스를 제공합니다.',
  '820000','주식회사',5200,'오대표','https://example.com/cloudbridge',85),
 ('com4@test.com','1234','1234','핀테크원','2223334445','2','02-444-4444','서담당',
  '서울 영등포구 여의대로 108','2016-06-20',
  '핀테크원은 누구나 쉽게 쓰는 간편결제와 자산관리 서비스를 만듭니다. 금융 규제를 지키면서도 빠르게 실험하는 애자일 조직을 지향합니다.',
  '2500000','주식회사',5600,'강대표','https://example.com/fintechone',210),
 ('com5@test.com','1234','1234','그린모빌리티','3334445556','2','051-555-5555','문인사',
  '부산 해운대구 센텀중앙로 79','2020-03-02',
  '그린모빌리티는 전기 킥보드와 자전거 공유 서비스를 운영하는 모빌리티 스타트업입니다. 부산을 시작으로 전국 주요 도시로 서비스를 넓혀가고 있습니다.',
  '180000','주식회사',4000,'배대표','https://example.com/greenmobility',48),
 ('com6@test.com','1234','1234','에듀플러스','4445556667','2','042-666-6666','신담당',
  '대전 유성구 대학로 99','2018-11-11',
  '에듀플러스는 AI 기반 맞춤형 학습 플랫폼을 운영하는 에듀테크 기업입니다. 학생 개개인의 학습 데이터를 분석해 최적의 학습 경로를 추천합니다.',
  '420000','유한회사',4400,'조대표','https://example.com/eduplus',62);

INSERT INTO com_stack (com_email, stack) VALUES
 ('com1@test.com','JAVA'),('com1@test.com','React.js'),('com1@test.com','DB'),('com1@test.com','Cloud'),
 ('com2@test.com','Adobe XD'),('com2@test.com','Sketch'),('com2@test.com','Zepline'),
 ('com3@test.com','Cloud'),('com3@test.com','JAVA'),('com3@test.com','Node.js'),
 ('com4@test.com','JAVA'),('com4@test.com','iOS'),('com4@test.com','Android'),('com4@test.com','DB'),
 ('com5@test.com','Android'),('com5@test.com','iOS'),('com5@test.com','Node.js'),
 ('com6@test.com','Vue.js'),('com6@test.com','JavaScript'),('com6@test.com','DB');

-- =====================================================================
-- 3. 채용공고 (마감일은 초기화 시점 기준 상대값)
-- =====================================================================

INSERT INTO notice_tb (notice_num, com_email, com_name, notice_title, notice_job, notice_recruitNum, notice_area1, notice_area2,
                       notice_career, notice_pay1, notice_pay2, notice_startDate, notice_endDate, notice_contactType,
                       notice_department, notice_position, notice_jobInfo, notice_condition, notice_prefer, notice_benefit,
                       notice_hit, notice_status) VALUES
 (1,'com1@test.com','주니온테크','신입 백엔드 개발자 채용 (Java/Spring)','백엔드 개발자',2,'서울','강남구',
  '신입','연봉',3600,DATE_SUB(CURDATE(), INTERVAL 5 DAY),DATE_ADD(CURDATE(), INTERVAL 30 DAY),'정규직',
  '플랫폼개발팀','사원',
  '- Spring Boot 기반 채용 플랫폼 API 개발\n- MyBatis / MySQL 을 활용한 데이터 처리 로직 구현\n- 사내 관리자 페이지 기능 개발 및 운영\n- 코드 리뷰와 테스트 코드 작성에 참여',
  '- Java 와 Spring 에 대한 기본 지식\n- 관계형 DB 와 SQL 에 대한 이해\n- Git 을 이용한 협업 경험\n- 학력 무관',
  '- 개인/팀 프로젝트를 배포해 운영해 본 경험\n- AWS 등 클라우드 사용 경험\n- 기술 블로그 운영 또는 오픈소스 기여 경험',
  '- 유연근무제 (8~11시 자율 출근)\n- 점심 식대 지원, 간식 무제한\n- 도서 / 교육비 연 100만원 지원\n- 최신 맥북 지급',
  152,'공고중'),
 (2,'com1@test.com','주니온테크','프론트엔드 개발자 (React, 경력 1~3년)','프론트엔드 개발자',1,'서울','강남구',
  '1~3년','연봉',4500,DATE_SUB(CURDATE(), INTERVAL 10 DAY),DATE_ADD(CURDATE(), INTERVAL 14 DAY),'정규직',
  '프로덕트팀','주임',
  '- React 기반 채용 서비스 웹 프론트엔드 개발\n- 디자인 시스템 컴포넌트 설계 및 유지보수\n- 성능 개선과 웹 접근성 개선',
  '- React 실무 경험 1년 이상\n- JavaScript / TypeScript 에 능숙하신 분\n- REST API 연동 경험',
  '- Next.js 사용 경험\n- 테스트 코드(Jest, Testing Library) 작성 경험\n- 디자이너와 긴밀히 협업해 본 경험',
  '- 유연근무제\n- 장비 지원 (모니터 2대)\n- 컨퍼런스 참가비 지원',
  98,'공고중'),
 (3,'com2@test.com','디자인랩','UI/UX 디자이너 (계약직 6개월)','UI/UX 디자이너',1,'경기','성남시',
  '경력무관','면접 후 결정',NULL,DATE_SUB(CURDATE(), INTERVAL 40 DAY),DATE_SUB(CURDATE(), INTERVAL 3 DAY),'계약직',
  '디자인팀','디자이너',
  '- 웹/앱 서비스 UI 설계 및 프로토타이핑\n- 사용자 인터뷰와 사용성 테스트 진행\n- 디자인 가이드 문서화',
  '- 포트폴리오 필수 제출\n- Figma 또는 Adobe XD 능숙자',
  '- 디자인 시스템 구축 경험\n- 모션 디자인 가능자',
  '- 자율 출퇴근\n- 정규직 전환 검토',
  64,'공고마감'),
 (4,'com2@test.com','디자인랩','브랜드 / BX 디자이너 신입 채용','BX 디자이너',1,'경기','성남시',
  '신입','연봉',3200,DATE_SUB(CURDATE(), INTERVAL 2 DAY),DATE_ADD(CURDATE(), INTERVAL 21 DAY),'정규직',
  '브랜드팀','사원',
  '- 클라이언트 브랜드 아이덴티티 디자인\n- 패키지 / 편집 / 굿즈 디자인\n- 브랜드 가이드북 제작',
  '- 그래픽 툴(일러스트레이터, 포토샵, InDesign) 능숙자\n- 포트폴리오 필수',
  '- 타이포그래피에 관심이 많은 분\n- 영상 편집 가능자',
  '- 디자인 툴 구독료 지원\n- 연 1회 해외 디자인 페어 견학',
  41,'공고중'),
 (5,'com3@test.com','클라우드브릿지','DevOps 엔지니어 (Kubernetes)','DevOps/인프라 엔지니어',2,'서울','성동구',
  '3~5년','연봉',6000,DATE_SUB(CURDATE(), INTERVAL 7 DAY),DATE_ADD(CURDATE(), INTERVAL 3 DAY),'정규직',
  '플랫폼엔지니어링팀','선임',
  '- 쿠버네티스 기반 고객사 플랫폼 구축 및 운영\n- CI/CD 파이프라인 설계\n- 모니터링 / 알림 체계 고도화',
  '- 리눅스 서버 운영 경력 3년 이상\n- 쿠버네티스 운영 경험\n- AWS 또는 GCP 실무 경험',
  '- Terraform 등 IaC 경험\n- CKA 자격증 보유자',
  '- 자격증 취득 지원\n- 재택근무 주 2회\n- 야간 장애 대응 수당 별도',
  77,'공고중'),
 (6,'com3@test.com','클라우드브릿지','주니어 백엔드 개발자 (Node.js)','백엔드 개발자',2,'서울','성동구',
  '신입,1~3년','연봉',4000,DATE_SUB(CURDATE(), INTERVAL 1 DAY),DATE_ADD(CURDATE(), INTERVAL 25 DAY),'정규직',
  '서비스개발팀','사원',
  '- 클라우드 관리 콘솔 백엔드 API 개발\n- 고객사 사용량 집계 배치 개발',
  '- JavaScript 또는 TypeScript 사용 경험\n- 비동기 프로그래밍에 대한 이해',
  '- Node.js 로 서비스를 배포해 본 경험\n- 클라우드 자격증 보유자',
  '- 교육 플랫폼 무제한 수강\n- 점심 식대 지원',
  55,'공고중'),
 (7,'com4@test.com','핀테크원','결제 서버 개발자 (Java)','백엔드 개발자',3,'서울','영등포구',
  '3~5년','연봉',6500,DATE_SUB(CURDATE(), INTERVAL 12 DAY),DATE_ADD(CURDATE(), INTERVAL 18 DAY),'정규직',
  '결제플랫폼팀','선임',
  '- 간편결제 승인 / 정산 시스템 개발\n- 대용량 트랜잭션 처리 성능 개선\n- 금융 규제 대응 기능 개발',
  '- Java / Spring 기반 백엔드 개발 경력 3년 이상\n- RDBMS 설계 및 튜닝 경험',
  '- 결제 / 금융 도메인 경험\n- Kafka 등 메시지 큐 사용 경험',
  '- 스톡옵션 부여\n- 연 1회 건강검진\n- 사내 카페 운영',
  134,'공고중'),
 (8,'com4@test.com','핀테크원','iOS 개발자 (자산관리 앱)','iOS 개발자',1,'서울','영등포구',
  '1~3년','연봉',5000,DATE_SUB(CURDATE(), INTERVAL 4 DAY),DATE_ADD(CURDATE(), INTERVAL 9 DAY),'정규직',
  '모바일팀','주임',
  '- 자산관리 iOS 앱 신규 기능 개발\n- SwiftUI 기반 화면 개선',
  '- Swift 로 앱을 출시해 본 경험\n- iOS 앱 아키텍처에 대한 이해',
  '- 금융 앱 보안 관련 경험',
  '- 개발 장비 지원\n- 스톡옵션 부여',
  49,'공고중'),
 (9,'com4@test.com','핀테크원','서비스 기획자 (PM)','서비스 기획자',1,'서울','영등포구',
  '5~7년','연봉',7000,DATE_SUB(CURDATE(), INTERVAL 20 DAY),DATE_ADD(CURDATE(), INTERVAL 6 DAY),'정규직',
  '전략기획실','책임',
  '- 자산관리 서비스 로드맵 수립\n- 데이터 기반 기능 우선순위 결정\n- 개발 / 디자인 / 컴플라이언스 협업 리드',
  '- 서비스 기획 또는 PM 경력 5년 이상\n- 데이터 분석을 통한 의사결정 경험',
  '- 금융 서비스 기획 경험\n- SQL 사용 가능자',
  '- 성과급\n- 리프레시 휴가',
  88,'공고중'),
 (10,'com5@test.com','그린모빌리티','안드로이드 개발자 (공유 킥보드 앱)','안드로이드 개발자',2,'부산','해운대구',
  '1~3년','연봉',4300,DATE_SUB(CURDATE(), INTERVAL 3 DAY),DATE_ADD(CURDATE(), INTERVAL 27 DAY),'정규직',
  '앱개발팀','주임',
  '- Kotlin 기반 사용자 앱 개발\n- 지도 / 위치 기반 기능 개발\n- 앱 안정성 모니터링',
  '- 안드로이드 앱 출시 경험\n- Kotlin 사용 가능자',
  '- 지도 SDK 사용 경험\n- BLE 통신 개발 경험',
  '- 이동수단 이용권 무료\n- 부산 이주 정착금 지원',
  37,'공고중'),
 (11,'com5@test.com','그린모빌리티','운영 데이터 분석가 인턴','데이터 분석가',1,'부산','해운대구',
  '신입','월급',230,DATE_SUB(CURDATE(), INTERVAL 1 DAY),DATE_ADD(CURDATE(), INTERVAL 12 DAY),'인턴직',
  '운영팀','인턴',
  '- 기기 이용 데이터 분석 및 리포트 작성\n- 재배치 효율 개선을 위한 지표 설계',
  '- SQL 기초 활용 가능자\n- Excel 능숙자',
  '- Python 데이터 분석 경험',
  '- 정규직 전환형 인턴\n- 점심 식대 지원',
  29,'공고중'),
 (12,'com6@test.com','에듀플러스','풀스택 개발자 (Vue + Java)','풀스택 개발자',2,'대전','유성구',
  '1~3년,3~5년','연봉',4800,DATE_SUB(CURDATE(), INTERVAL 6 DAY),DATE_ADD(CURDATE(), INTERVAL 20 DAY),'정규직',
  '플랫폼팀','주임',
  '- 학습 플랫폼 웹 서비스 프론트/백엔드 개발\n- 학습 데이터 수집 API 개발',
  '- Vue.js 와 Java 기반 웹 개발 경험',
  '- 에듀테크 도메인 관심자\n- 대용량 로그 처리 경험',
  '- 대전 지역 주거 지원\n- 자기계발비 지원',
  45,'공고중'),
 (13,'com6@test.com','에듀플러스','콘텐츠 영상 디자이너','영상 디자이너',1,'대전','유성구',
  '경력무관','면접 후 결정',NULL,DATE_SUB(CURDATE(), INTERVAL 35 DAY),DATE_SUB(CURDATE(), INTERVAL 1 DAY),'프리랜서',
  '콘텐츠팀','디자이너',
  '- 온라인 강의 영상 편집 및 모션 그래픽 제작',
  '- Premiere / After Effect 능숙자\n- 포트폴리오 필수',
  '- 교육 콘텐츠 제작 경험',
  '- 원격 근무 가능',
  22,'공고마감'),
 (14,'com1@test.com','주니온테크','데이터 엔지니어 (신입 가능)','데이터 엔지니어',1,'서울','강남구',
  '신입,1~3년','연봉',4200,CURDATE(),DATE_ADD(CURDATE(), INTERVAL 40 DAY),'정규직',
  '데이터팀','사원',
  '- 채용 매칭 데이터 파이프라인 구축\n- 추천 모델 학습용 데이터 마트 설계',
  '- SQL 활용 능력\n- Java 또는 Python 사용 경험',
  '- 데이터 웨어하우스 / ETL 도구 경험',
  '- 유연근무제\n- 데이터 관련 교육 지원',
  18,'공고중');

INSERT INTO notice_stack (notice_num, stack, com_email) VALUES
 (1,'JAVA','com1@test.com'),(1,'DB','com1@test.com'),(1,'Cloud','com1@test.com'),
 (2,'JavaScript','com1@test.com'),(2,'React.js','com1@test.com'),
 (3,'Adobe XD','com2@test.com'),(3,'Sketch','com2@test.com'),(3,'Zepline','com2@test.com'),
 (4,'InDesign','com2@test.com'),(4,'Lightroom','com2@test.com'),
 (5,'Cloud','com3@test.com'),(5,'Slack','com3@test.com'),
 (6,'Node.js','com3@test.com'),(6,'JavaScript','com3@test.com'),(6,'DB','com3@test.com'),
 (7,'JAVA','com4@test.com'),(7,'DB','com4@test.com'),
 (8,'iOS','com4@test.com'),
 (9,'Notion','com4@test.com'),(9,'Excel','com4@test.com'),(9,'Asana','com4@test.com'),
 (10,'Android','com5@test.com'),(10,'JAVA','com5@test.com'),
 (11,'Excel','com5@test.com'),(11,'DB','com5@test.com'),
 (12,'Vue.js','com6@test.com'),(12,'JAVA','com6@test.com'),(12,'DB','com6@test.com'),
 (13,'Premiere','com6@test.com'),(13,'After Effect','com6@test.com'),
 (14,'DB','com1@test.com'),(14,'JAVA','com1@test.com'),(14,'Cloud','com1@test.com');

-- =====================================================================
-- 4. 이력서 / 지원 / 제안 / 스크랩 / 별점
-- =====================================================================

INSERT INTO resume_tb (resume_num, user_email, resume_title, resume_writeDate, resume_pay, career_start, career_end, resume_status,
                       resume_comName, resume_comPart, resume_comPosition, resume_eduStart, resume_eduEnd, resume_eduName,
                       resume_eduMajor, resume_eduStatus, resume_exStart, resume_exEnd, resume_exName, resume_exContent,
                       resume_licenseDate, resume_licenseContent, resume_portfolio_name, resume_portfolio_url, resume_intro, resume_offer) VALUES
 (1,'user1@test.com','성장하는 백엔드 개발자 김개발입니다',DATE_SUB(NOW(), INTERVAL 20 DAY),3800,
  '2022-01-03','2023-12-29','퇴사','스타트업A','개발팀','사원',
  '2016-03-02','2022-02-18','한국대학교','컴퓨터공학','졸업',
  '2021-07-01','2021-12-31','SW 개발자 부트캠프','Spring Boot 기반 팀 프로젝트 3건 진행',
  '2021-11-26','정보처리기사','개인 포트폴리오','https://github.com/example-dev',
  'Java와 Spring으로 2년간 API 서버를 개발하고 운영했습니다. 장애 대응과 쿼리 튜닝으로 응답 속도를 40% 개선한 경험이 있으며, 테스트 코드와 코드 리뷰 문화를 중요하게 생각합니다.','예'),
 (2,'user2@test.com','사용자를 먼저 생각하는 UI/UX 디자이너',DATE_SUB(NOW(), INTERVAL 15 DAY),3500,
  '2021-03-02','2024-02-29','퇴사','에이전시B','디자인팀','디자이너',
  '2017-03-02','2021-02-19','서울디자인대학교','시각디자인','졸업',
  '2020-01-06','2020-02-28','디자인 공모전','모바일 금융 앱 리디자인으로 장려상 수상',
  '2020-06-20','컴퓨터그래픽스운용기능사','디자인 포트폴리오','https://example.com/portfolio/designer',
  '에이전시에서 3년간 웹/앱 UI 설계와 디자인 시스템 구축을 담당했습니다. 사용자 인터뷰로 문제를 정의하고 프로토타입으로 빠르게 검증하는 과정을 좋아합니다.','예'),
 (3,'user3@test.com','React로 사용자 경험을 만드는 프론트엔드 개발자',DATE_SUB(NOW(), INTERVAL 8 DAY),4200,
  '2022-07-01',NULL,'재직중','커머스C','프론트엔드팀','주임',
  '2015-03-02','2021-08-20','부산대학교','정보컴퓨터공학','졸업',
  '2021-09-01','2022-02-28','오픈소스 컨트리뷰션 아카데미','UI 라이브러리 접근성 개선 PR 기여',
  '2022-05-14','SQLD','기술 블로그','https://example.com/blog/frontend',
  '커머스 서비스에서 React와 TypeScript로 상품 상세와 주문 화면을 개발하고 있습니다. Lighthouse 점수를 60점대에서 90점대로 끌어올린 성능 개선 경험이 있습니다.','예'),
 (4,'user4@test.com','데이터로 문제를 푸는 데이터 엔지니어',DATE_SUB(NOW(), INTERVAL 30 DAY),5000,
  '2020-01-02','2024-06-28','퇴사','물류D','데이터팀','선임',
  '2013-03-04','2019-08-23','충남대학교','통계학','졸업',
  NULL,NULL,NULL,NULL,
  '2019-12-07','빅데이터분석기사','데이터 파이프라인 프로젝트','https://github.com/example-data',
  '물류 회사에서 4년간 배송 데이터 파이프라인과 대시보드를 구축했습니다. 일 배치 처리 시간을 3시간에서 40분으로 단축했습니다.','예'),
 (5,'user5@test.com','고객 문제에서 출발하는 서비스 기획자',DATE_SUB(NOW(), INTERVAL 3 DAY),4600,
  '2019-02-01',NULL,'재직중','핀테크E','서비스기획팀','매니저',
  '2014-03-03','2019-02-15','이화대학교','경영학','졸업',
  '2018-07-01','2018-08-31','IT 서비스 기획 인턴','송금 서비스 개선안 기획',
  NULL,NULL,'기획 포트폴리오','https://example.com/portfolio/pm',
  '금융 서비스 기획 5년차입니다. 사용자 데이터 분석으로 이탈 구간을 찾아 개선해 가입 전환율을 18% 높인 경험이 있습니다.','아니오'),
 (6,'user6@test.com','신입 모바일 개발자 한모바입니다',DATE_SUB(NOW(), INTERVAL 1 DAY),3400,
  NULL,NULL,NULL,NULL,NULL,NULL,
  '2019-03-04','2025-02-20','해운대학교','소프트웨어학과','졸업',
  '2024-03-01','2024-12-20','모바일 앱 개발 동아리','캠퍼스 셔틀 위치 알림 앱 출시 (다운로드 2천 건)',
  '2024-09-10','정보처리기사','앱 포트폴리오','https://github.com/example-mobile',
  'Kotlin과 Swift로 앱을 직접 만들어 출시해 본 경험이 있습니다. 사용자의 리뷰를 보고 빠르게 개선하는 과정에서 큰 보람을 느낍니다.','예');

INSERT INTO resume_stack (resume_num, stack_name) VALUES
 (1,'JAVA'),(1,'DB'),(1,'Cloud'),
 (2,'Adobe XD'),(2,'Sketch'),(2,'Zepline'),
 (3,'JavaScript'),(3,'React.js'),(3,'Node.js'),
 (4,'DB'),(4,'JAVA'),(4,'Excel'),
 (5,'Notion'),(5,'Excel'),(5,'Asana'),
 (6,'Android'),(6,'iOS'),(6,'JAVA');

INSERT INTO submit_tb (notice_num, resume_num, user_email, com_email, joincompany_date, submit_check, submit_status) VALUES
 (1,1,'user1@test.com','com1@test.com',DATE_SUB(NOW(), INTERVAL 4 DAY),'열람','합격'),
 (7,1,'user1@test.com','com4@test.com',DATE_SUB(NOW(), INTERVAL 2 DAY),'미열람',NULL),
 (14,1,'user1@test.com','com1@test.com',DATE_SUB(NOW(), INTERVAL 1 DAY),'미열람',NULL),
 (3,2,'user2@test.com','com2@test.com',DATE_SUB(NOW(), INTERVAL 20 DAY),'열람','보류'),
 (4,2,'user2@test.com','com2@test.com',DATE_SUB(NOW(), INTERVAL 1 DAY),'미열람',NULL),
 (2,3,'user3@test.com','com1@test.com',DATE_SUB(NOW(), INTERVAL 6 DAY),'열람','합격'),
 (6,3,'user3@test.com','com3@test.com',DATE_SUB(NOW(), INTERVAL 1 DAY),'미열람',NULL),
 (12,4,'user4@test.com','com6@test.com',DATE_SUB(NOW(), INTERVAL 3 DAY),'열람','불합격'),
 (10,6,'user6@test.com','com5@test.com',DATE_SUB(NOW(), INTERVAL 2 DAY),'미열람',NULL),
 (1,6,'user6@test.com','com1@test.com',DATE_SUB(NOW(), INTERVAL 3 DAY),'열람',NULL);

INSERT INTO offer (notice_num, user_email, com_email, resume_num, offer_content, offer_date, offer_agree, resume_submitDate) VALUES
 (2,'user1@test.com','com1@test.com',1,'안녕하세요 주니온테크입니다. 이력서를 인상 깊게 보았습니다. 프론트엔드 포지션도 관심 있으시면 지원 부탁드립니다.',DATE_SUB(NOW(), INTERVAL 3 DAY),'미응답',NULL),
 (5,'user1@test.com','com3@test.com',1,'클라우드 운영 경험을 쌓고 싶으시다면 DevOps 포지션을 제안드립니다.',DATE_SUB(NOW(), INTERVAL 1 DAY),'미응답',NULL),
 (9,'user5@test.com','com4@test.com',5,'핀테크원 전략기획실입니다. 금융 서비스 기획 경험을 높이 평가해 PM 포지션을 제안드립니다.',DATE_SUB(NOW(), INTERVAL 5 DAY),'지원완료',DATE_SUB(NOW(), INTERVAL 4 DAY)),
 (12,'user3@test.com','com6@test.com',3,'에듀플러스 플랫폼팀입니다. Vue 경험이 있으시면 풀스택 포지션도 잘 맞으실 것 같습니다.',DATE_SUB(NOW(), INTERVAL 7 DAY),'제안거절',NULL),
 (8,'user6@test.com','com4@test.com',6,'iOS 앱 출시 경험이 인상적이었습니다. 자산관리 앱 iOS 개발자 포지션을 제안드립니다.',DATE_SUB(NOW(), INTERVAL 2 DAY),'미응답',NULL);

INSERT INTO notice_scrap (notice_num, user_email) VALUES
 (2,'user1@test.com'),(5,'user1@test.com'),(7,'user1@test.com'),
 (4,'user2@test.com'),(3,'user2@test.com'),
 (2,'user3@test.com'),(12,'user3@test.com'),
 (14,'user4@test.com'),(11,'user4@test.com'),
 (9,'user5@test.com'),
 (10,'user6@test.com'),(8,'user6@test.com');

INSERT INTO com_scrap (com_email, user_email) VALUES
 ('com1@test.com','user1@test.com'),('com3@test.com','user1@test.com'),('com4@test.com','user1@test.com'),
 ('com2@test.com','user2@test.com'),
 ('com1@test.com','user3@test.com'),('com6@test.com','user3@test.com'),
 ('com4@test.com','user5@test.com'),
 ('com5@test.com','user6@test.com');

INSERT INTO recent_notice (notice_num, user_email) VALUES
 (1,'user1@test.com'),(2,'user1@test.com'),(5,'user1@test.com'),
 (3,'user2@test.com'),(9,'user2@test.com'),
 (2,'user3@test.com'),(6,'user3@test.com'),
 (7,'user4@test.com'),(12,'user4@test.com'),
 (10,'user5@test.com'),
 (11,'user6@test.com'),(13,'user6@test.com');

INSERT INTO com_star_tb (user_email, com_email, com_star, notice_num) VALUES
 ('user1@test.com','com1@test.com',5,1),
 ('user3@test.com','com1@test.com',4,2),
 ('user6@test.com','com1@test.com',4,1),
 ('user2@test.com','com2@test.com',4,3),
 ('user4@test.com','com6@test.com',3,12);

-- =====================================================================
-- 5. 커뮤니티 게시판 (본문은 HTML 로 그대로 출력되므로 줄바꿈은 <br>)
-- =====================================================================

INSERT INTO user_board (board_no, user_email, board_title, board_content, create_date, board_hit) VALUES
 (1,'user1@test.com','신입 백엔드 포트폴리오 피드백 부탁드려요',
  'Spring Boot + MyBatis로 만든 커뮤니티 프로젝트입니다.<br>로그인, 게시판, 댓글, 파일 업로드까지 구현했는데 면접에서 어필할 만한 부분이 뭘까요?<br><br>배포는 AWS EC2 + RDS로 했고, README에 ERD와 API 문서를 정리해 두었습니다.',
  DATE_SUB(NOW(), INTERVAL 9 DAY),87),
 (2,'user2@test.com','UI/UX 디자이너 면접 후기 공유합니다',
  '포트폴리오 설명 위주로 30분 정도 진행됐어요.<br>"이 화면에서 가장 고민한 부분이 무엇인가요?" 같은 질문이 많았습니다.<br><br>결과물보다 과정(리서치, 가설, 검증)을 설명할 수 있게 준비하시는 걸 추천드려요!',
  DATE_SUB(NOW(), INTERVAL 8 DAY),64),
 (3,'user3@test.com','프론트엔드 신입이 꼭 알아야 할 것들 정리',
  '1. 브라우저 렌더링 과정<br>2. 이벤트 루프와 비동기<br>3. HTTP 캐시와 쿠키/세션<br>4. 웹 접근성 기본<br><br>면접에서 실제로 받았던 질문 위주로 골라봤어요. 추가할 내용 있으면 댓글 부탁드립니다.',
  DATE_SUB(NOW(), INTERVAL 7 DAY),132),
 (4,'user4@test.com','비전공자 데이터 엔지니어 전환 후기',
  '통계학 전공으로 분석 업무를 하다가 데이터 엔지니어로 전환했습니다.<br>SQL을 정말 많이 썼던 경험이 큰 도움이 됐어요.<br><br>공부 순서: SQL → Python → Airflow → 클라우드(AWS) 순서로 했습니다.',
  DATE_SUB(NOW(), INTERVAL 6 DAY),58),
 (5,'user5@test.com','기획자 포트폴리오는 어떻게 구성하시나요?',
  '현업 기획자인데 이직 준비 중입니다.<br>화면 기획서 위주로 넣어야 할지, 문제 정의와 지표 개선 사례 위주로 넣어야 할지 고민이네요.<br>다른 분들은 어떻게 하셨는지 궁금합니다.',
  DATE_SUB(NOW(), INTERVAL 5 DAY),41),
 (6,'user6@test.com','첫 앱 출시하고 느낀 점',
  '캠퍼스 셔틀 위치 알림 앱을 출시했는데 생각보다 리뷰가 많이 달렸어요.<br>크래시 리포트 보면서 밤새 고친 게 제일 기억에 남네요 😂<br><br>출시해 보는 경험 강력 추천합니다!',
  DATE_SUB(NOW(), INTERVAL 4 DAY),73),
 (7,'user1@test.com','코딩테스트 준비 스터디 모집 (주 2회 온라인)',
  '백준/프로그래머스 위주로 주 2회 문제 풀이하실 분 모집합니다.<br>- 화, 목 저녁 9시<br>- 디스코드 음성 채널<br>- 현재 3명, 2명 더 모집합니다.',
  DATE_SUB(NOW(), INTERVAL 3 DAY),49),
 (8,'user3@test.com','이력서 기술 스택은 몇 개까지 적는 게 좋을까요?',
  '써본 건 많은데 깊게 다룬 건 몇 개 안 돼서 고민입니다.<br>다들 어떤 기준으로 적으시나요?',
  DATE_SUB(NOW(), INTERVAL 2 DAY),36),
 (9,'user2@test.com','디자인 시스템 처음 만들 때 참고한 자료',
  'Material Design, Apple HIG 가이드를 많이 참고했어요.<br>컬러/타이포 토큰부터 정하고 버튼, 인풋 같은 기본 컴포넌트를 먼저 만들면 훨씬 수월합니다.',
  DATE_SUB(NOW(), INTERVAL 1 DAY),22),
 (10,'user4@test.com','SQL 실력 늘리는 방법 추천해 주세요',
  '윈도우 함수까지는 익숙한데 실행 계획 보는 게 아직 어렵네요.<br>추천할 만한 책이나 강의 있으면 알려주세요!',
  DATE_SUB(NOW(), INTERVAL 5 HOUR),12);

INSERT INTO board_user_comment (user_email, commentContent, board_no, commentCreatedTime) VALUES
 ('user3@test.com','ERD와 API 문서까지 정리하신 거 정말 좋네요! 트러블슈팅 경험을 하나 꼭 넣으세요.',1,DATE_SUB(NOW(), INTERVAL 8 DAY)),
 ('user4@test.com','배포까지 해보신 게 큰 강점이에요. 응답 속도 개선 같은 수치가 있으면 더 좋아요.',1,DATE_SUB(NOW(), INTERVAL 8 DAY)),
 ('user5@test.com','과정 설명이 중요하다는 말 공감합니다. 후기 감사해요!',2,DATE_SUB(NOW(), INTERVAL 7 DAY)),
 ('user1@test.com','이벤트 루프는 정말 단골 질문이죠. 정리 감사합니다 👍',3,DATE_SUB(NOW(), INTERVAL 6 DAY)),
 ('user6@test.com','저장해 두고 볼게요!',3,DATE_SUB(NOW(), INTERVAL 6 DAY)),
 ('user1@test.com','저도 스터디 참여하고 싶습니다!',7,DATE_SUB(NOW(), INTERVAL 2 DAY)),
 ('user6@test.com','저도요! 연락 부탁드립니다.',7,DATE_SUB(NOW(), INTERVAL 2 DAY)),
 ('user1@test.com','실무에서 써본 것 위주로 적고, 나머지는 "경험 있음" 정도로 따로 묶어요.',8,DATE_SUB(NOW(), INTERVAL 1 DAY));

INSERT INTO user_board_like (board_no, user_email) VALUES
 (1,'user3@test.com'),(1,'user4@test.com'),(1,'user6@test.com'),
 (2,'user5@test.com'),(2,'user1@test.com'),
 (3,'user1@test.com'),(3,'user2@test.com'),(3,'user4@test.com'),(3,'user6@test.com'),
 (6,'user1@test.com'),(6,'user3@test.com'),
 (7,'user6@test.com');

INSERT INTO com_board (board_no, com_email, board_title, board_content, create_date, board_hit) VALUES
 (1,'com1@test.com','주니어 개발자 온보딩, 어떻게 하시나요?',
  '저희는 입사 후 2주간 멘토 1:1 매칭과 사내 코드베이스 투어를 진행합니다.<br>다른 회사들은 어떤 방식으로 온보딩하시는지 궁금합니다.',
  DATE_SUB(NOW(), INTERVAL 6 DAY),31),
 (2,'com3@test.com','채용 공고 조회수를 높이는 팁 공유합니다',
  '1. 업무 내용을 구체적으로 (사용 기술, 팀 규모)<br>2. 연봉 범위 공개<br>3. 팀원 인터뷰 링크 첨부<br><br>이렇게 바꾼 뒤 지원자가 2배 늘었어요.',
  DATE_SUB(NOW(), INTERVAL 5 DAY),45),
 (3,'com4@test.com','기술 면접 질문, 어떻게 구성하세요?',
  '라이브 코딩 vs 과제 vs 경험 기반 질문 중 어떤 방식이 효과적이었는지 의견 부탁드립니다.',
  DATE_SUB(NOW(), INTERVAL 3 DAY),27),
 (4,'com2@test.com','디자이너 포트폴리오 리뷰 기준 공유',
  '저희는 결과물보다 문제 정의와 의사결정 과정을 중점적으로 봅니다.<br>3~4개 프로젝트를 깊이 있게 보여주는 포트폴리오를 선호해요.',
  DATE_SUB(NOW(), INTERVAL 2 DAY),19),
 (5,'com6@test.com','지방 소재 기업 채용 노하우 있을까요?',
  '대전에 있다 보니 수도권 인재 채용이 쉽지 않네요.<br>주거 지원 외에 효과 있었던 방법이 있다면 공유 부탁드립니다.',
  DATE_SUB(NOW(), INTERVAL 1 DAY),14);

INSERT INTO com_board_comment (com_email, commentContent, board_no, commentCreatedTime) VALUES
 ('com3@test.com','저희는 첫 주에 작은 버그 수정을 배포까지 해보게 합니다. 적응이 훨씬 빨라요.',1,DATE_SUB(NOW(), INTERVAL 5 DAY)),
 ('com4@test.com','연봉 범위 공개 효과 정말 크죠. 좋은 팁 감사합니다.',2,DATE_SUB(NOW(), INTERVAL 4 DAY)),
 ('com1@test.com','경험 기반 질문 + 짧은 과제 조합이 가장 만족스러웠습니다.',3,DATE_SUB(NOW(), INTERVAL 2 DAY)),
 ('com5@test.com','저희도 부산이라 공감합니다. 하이브리드 근무가 효과가 있었어요.',5,DATE_SUB(NOW(), INTERVAL 12 HOUR));

INSERT INTO com_board_like (board_no, com_email) VALUES
 (1,'com3@test.com'),(1,'com4@test.com'),(2,'com1@test.com'),(2,'com4@test.com'),(2,'com6@test.com'),(5,'com5@test.com');

-- 공지 게시판(개인/기업 공용 커뮤니티)
INSERT INTO notice_board (board_no, login_email, board_title, board_content, create_date, board_hit) VALUES
 (1,'admin@admin.com','Junion 커뮤니티 이용 수칙 안내',
  '모두가 즐겁게 이용할 수 있도록 아래 수칙을 지켜주세요.<br>1. 비방, 욕설 금지<br>2. 광고성 게시글 금지<br>3. 개인정보 노출 주의<br><br>위반 게시글은 사전 안내 없이 삭제될 수 있습니다.',
  DATE_SUB(NOW(), INTERVAL 14 DAY),210),
 (2,'admin@admin.com','이달의 인기 게시글 선정 이벤트',
  '추천을 가장 많이 받은 게시글 작성자 3분께 커피 쿠폰을 드립니다 ☕<br>이벤트 기간: 이번 달 말일까지',
  DATE_SUB(NOW(), INTERVAL 7 DAY),96),
 (3,'com1@test.com','주니온테크 채용 설명회 안내',
  '다음 주 수요일 저녁 7시 온라인으로 채용 설명회를 진행합니다.<br>현직 개발자와의 Q&A 시간도 준비되어 있습니다.',
  DATE_SUB(NOW(), INTERVAL 3 DAY),58),
 (4,'user1@test.com','이력서 첨삭 품앗이 하실 분',
  '서로 이력서 봐주실 분 구합니다! 개발 직군이면 좋겠어요.',
  DATE_SUB(NOW(), INTERVAL 1 DAY),17);

INSERT INTO notice_board_comment (login_email, commentContent, board_no, commentCreatedTime) VALUES
 ('user3@test.com','참여하고 싶습니다!',4,DATE_SUB(NOW(), INTERVAL 20 HOUR)),
 ('user6@test.com','설명회 꼭 들을게요.',3,DATE_SUB(NOW(), INTERVAL 2 DAY));

INSERT INTO notice_board_like (board_no, login_email) VALUES
 (1,'user1@test.com'),(1,'user2@test.com'),(2,'user3@test.com'),(3,'user6@test.com');

-- =====================================================================
-- 6. 고객센터 (공지사항은 <pre> 로 출력되므로 줄바꿈 그대로)
-- =====================================================================

INSERT INTO announcements_board (login_email, board_title, board_content, create_date) VALUES
 ('admin@admin.com','[공지] Junion 서비스 정식 오픈 안내',
  '안녕하세요, Junion 운영팀입니다.\n\n주니어 개발자와 기업을 연결하는 Junion 서비스가 정식 오픈했습니다.\n채용공고, 이력서 관리, 커뮤니티, SNS, 데일리 CS 퀴즈까지 다양한 기능을 이용해 보세요.\n\n앞으로도 더 좋은 서비스로 보답하겠습니다. 감사합니다.',
  DATE_SUB(NOW(), INTERVAL 30 DAY)),
 ('admin@admin.com','[점검] 정기 서버 점검 안내',
  '서비스 안정화를 위해 정기 점검을 진행합니다.\n\n- 일시: 매주 일요일 02:00 ~ 04:00\n- 내용: 서버 보안 업데이트 및 DB 최적화\n\n점검 시간에는 서비스 이용이 제한됩니다. 양해 부탁드립니다.',
  DATE_SUB(NOW(), INTERVAL 21 DAY)),
 ('admin@admin.com','[업데이트] 인재풀 기능 추가',
  '기업회원을 위한 인재풀 기능이 추가되었습니다.\n\n- 이력서 공개에 동의한 회원의 이력서를 검색할 수 있습니다.\n- 직무, 기술 스택, 경력, 지역으로 필터링할 수 있습니다.\n- 마음에 드는 인재에게 바로 포지션을 제안할 수 있습니다.\n\n개인회원은 이력서 작성 시 "인재풀 공개" 여부를 선택할 수 있습니다.',
  DATE_SUB(NOW(), INTERVAL 14 DAY)),
 ('admin@admin.com','[이벤트] 데일리 CS 퀴즈 참여 이벤트',
  '매일 CS 퀴즈를 풀고 실력도 키우고 선물도 받아가세요!\n\n- 기간: 이번 달 1일 ~ 말일\n- 대상: 데일리 CS 퀴즈를 10문제 이상 참여한 개인회원\n- 경품: 추첨을 통해 개발 도서 10권 증정\n\n당첨자는 다음 달 첫째 주에 공지사항으로 안내드립니다.',
  DATE_SUB(NOW(), INTERVAL 10 DAY)),
 ('admin@admin.com','[안내] 개인정보 처리방침 개정 안내',
  '개인정보 처리방침이 일부 개정되어 안내드립니다.\n\n- 개정 내용: 이력서 보관 기간 명시 (탈퇴 후 즉시 파기)\n- 시행일: 공지일로부터 7일 후\n\n자세한 내용은 고객센터 > 이용약관에서 확인하실 수 있습니다.',
  DATE_SUB(NOW(), INTERVAL 5 DAY)),
 ('admin@admin.com','[안내] SNS 채팅 기능 오픈',
  'SNS에서 다른 회원과 1:1 채팅을 할 수 있게 되었습니다.\n\n상대방 프로필에서 "메시지" 버튼을 눌러 대화를 시작해 보세요.\n불쾌한 메시지를 받으셨다면 고객센터로 신고해 주세요.',
  DATE_SUB(NOW(), INTERVAL 2 DAY));

-- 이용약관 (상세 화면이 white-space: pre 이므로 줄바꿈 그대로)
INSERT INTO terms_tb (login_email, board_title, board_content, create_date, term_type) VALUES
 ('admin@admin.com','개인회원 이용약관',
  '제1조 (목적)\n이 약관은 Junion(이하 "회사")이 제공하는 채용정보 서비스(이하 "서비스")의 이용과 관련하여 회사와 개인회원 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.\n\n제2조 (정의)\n1. "개인회원"이란 이 약관에 동의하고 회원가입을 한 구직자를 말합니다.\n2. "이력서"란 개인회원이 서비스에 등록한 학력, 경력, 자기소개 등의 정보를 말합니다.\n\n제3조 (서비스의 내용)\n회사는 개인회원에게 채용공고 열람, 입사지원, 이력서 관리, 커뮤니티, SNS 서비스를 제공합니다.\n\n제4조 (회원의 의무)\n1. 회원은 사실과 다른 정보를 등록해서는 안 됩니다.\n2. 회원은 타인의 정보를 도용해서는 안 됩니다.',
  DATE_SUB(NOW(), INTERVAL 30 DAY),'개인'),
 ('admin@admin.com','개인정보 수집 및 이용 동의 (개인)',
  '1. 수집 항목\n- 필수: 이름, 이메일, 비밀번호, 비밀번호 찾기 질문/답변\n- 선택: 연락처, 생년월일, 성별, 거주지역, 희망 직무, 기술 스택\n\n2. 수집 목적\n- 회원 식별 및 서비스 제공\n- 맞춤형 채용공고 추천\n\n3. 보유 기간\n- 회원 탈퇴 시까지 (탈퇴 후 즉시 파기)',
  DATE_SUB(NOW(), INTERVAL 30 DAY),'개인'),
 ('admin@admin.com','이력서 공개 및 포지션 제안 수신 동의',
  '1. 이력서를 "인재풀 공개"로 설정하면 기업회원이 이력서를 열람할 수 있습니다.\n2. 기업회원은 공개된 이력서를 보고 포지션을 제안할 수 있습니다.\n3. 연락처 등 민감한 정보는 지원 또는 제안 수락 후에만 공개됩니다.\n4. 공개 여부는 이력서 관리에서 언제든지 변경할 수 있습니다.',
  DATE_SUB(NOW(), INTERVAL 20 DAY),'개인'),
 ('admin@admin.com','기업회원 이용약관',
  '제1조 (목적)\n이 약관은 회사가 제공하는 채용 서비스의 이용과 관련하여 회사와 기업회원 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.\n\n제2조 (정의)\n1. "기업회원"이란 사업자등록번호로 가입한 구인 기업을 말합니다.\n2. "채용공고"란 기업회원이 서비스에 등록한 구인 정보를 말합니다.\n\n제3조 (채용공고 등록)\n1. 기업회원은 사실에 근거한 채용공고를 등록해야 합니다.\n2. 채용절차법 등 관계 법령을 위반하는 공고는 사전 통보 없이 삭제될 수 있습니다.\n\n제4조 (지원자 정보의 보호)\n기업회원은 열람한 지원자 정보를 채용 목적 외로 사용할 수 없습니다.',
  DATE_SUB(NOW(), INTERVAL 30 DAY),'기업'),
 ('admin@admin.com','인재풀 이용 정책 (기업)',
  '1. 인재풀은 이력서 공개에 동의한 개인회원의 정보만 제공합니다.\n2. 포지션 제안은 실제 채용 계획이 있는 공고에 한해 발송해야 합니다.\n3. 동일 회원에게 반복적인 제안을 보내는 행위는 제한될 수 있습니다.\n4. 정책 위반 시 서비스 이용이 제한될 수 있습니다.',
  DATE_SUB(NOW(), INTERVAL 20 DAY),'기업'),
 ('admin@admin.com','채용공고 등록 가이드 (기업)',
  '1. 업무 내용, 자격 요건, 우대 사항, 복리후생을 구체적으로 작성해 주세요.\n2. 급여는 가능한 범위를 공개하면 지원율이 높아집니다.\n3. 마감일이 지난 공고는 자동으로 "공고마감" 상태가 됩니다.\n4. 회사 이미지를 등록하면 공고 목록에서 더 잘 보입니다.',
  DATE_SUB(NOW(), INTERVAL 10 DAY),'기업');

-- =====================================================================
-- 7. SNS (본문은 HTML 로 그대로 출력되므로 줄바꿈은 <br>)
-- =====================================================================

INSERT INTO sns_tb (sns_num, login_email, user_type, sns_title, sns_content, sns_date) VALUES
 (1,'user1@test.com','1','첫 글','Junion SNS 첫 글입니다! 백엔드 개발자를 준비하고 있어요.<br>같이 공부하실 분들 팔로우 환영합니다 🙌',DATE_SUB(NOW(), INTERVAL 10 DAY)),
 (2,'com1@test.com','2','채용 소식','주니온테크에서 신입 백엔드 개발자를 채용합니다.<br>Java / Spring 에 관심 있는 분들의 많은 지원 바랍니다!<br>#채용 #신입 #백엔드',DATE_SUB(NOW(), INTERVAL 9 DAY)),
 (3,'user2@test.com','1','작업 공유','요즘 작업 중인 앱 리디자인 시안입니다.<br>컬러 팔레트를 정하는 데 일주일이 걸렸네요 🎨',DATE_SUB(NOW(), INTERVAL 8 DAY)),
 (4,'user3@test.com','1','성능 개선 회고','Lighthouse 성능 점수 62 → 94 달성!<br>이미지 lazy loading이랑 번들 분할이 제일 효과가 컸어요.',DATE_SUB(NOW(), INTERVAL 7 DAY)),
 (5,'com3@test.com','2','팀 소개','클라우드브릿지 플랫폼엔지니어링팀의 하루를 소개합니다.<br>아침 스탠드업 → 장애 회고 → 자동화 개선 작업!<br>함께할 DevOps 엔지니어를 찾고 있어요.',DATE_SUB(NOW(), INTERVAL 6 DAY)),
 (6,'user4@test.com','1','오늘의 공부','Airflow DAG 의존성 설계 공부 중입니다.<br>배치가 꼬이지 않게 하는 게 생각보다 어렵네요 🤔',DATE_SUB(NOW(), INTERVAL 5 DAY)),
 (7,'com4@test.com','2','사내 행사','핀테크원 사내 해커톤이 열렸습니다!<br>24시간 동안 12개 팀이 아이디어를 실제 서비스로 만들어냈어요 🚀',DATE_SUB(NOW(), INTERVAL 4 DAY)),
 (8,'user6@test.com','1','앱 출시','드디어 첫 앱을 출시했습니다 📱<br>캠퍼스 셔틀 위치를 실시간으로 알려주는 앱이에요.<br>피드백 환영합니다!',DATE_SUB(NOW(), INTERVAL 3 DAY)),
 (9,'user5@test.com','1','기획 인사이트','좋은 기획은 "무엇을 만들까"보다 "무엇을 만들지 않을까"에서 시작한다고 생각해요.',DATE_SUB(NOW(), INTERVAL 2 DAY)),
 (10,'com5@test.com','2','부산 오피스','그린모빌리티 부산 센텀 오피스 전경입니다 🌊<br>바다가 보이는 곳에서 일할 동료를 찾습니다.',DATE_SUB(NOW(), INTERVAL 1 DAY)),
 (11,'user1@test.com','1','코테 스터디','코딩테스트 스터디 2주차! 오늘은 그래프 탐색(BFS/DFS) 문제를 풀었어요.',DATE_SUB(NOW(), INTERVAL 10 HOUR)),
 (12,'com6@test.com','2','에듀플러스 소식','에듀플러스 AI 학습 추천 기능이 새롭게 업데이트되었습니다 📚<br>학습 데이터를 기반으로 더 정확한 추천을 제공합니다.',DATE_SUB(NOW(), INTERVAL 3 HOUR));

INSERT INTO sns_comment_tb (sns_num, login_email, user_type, sns_comment_content, sns_comment_date) VALUES
 (1,'user3@test.com','1','환영해요! 같이 열심히 해봐요 😊',DATE_SUB(NOW(), INTERVAL 10 DAY)),
 (1,'user6@test.com','1','팔로우했어요!',DATE_SUB(NOW(), INTERVAL 9 DAY)),
 (2,'user1@test.com','1','지원했습니다! 좋은 결과 있었으면 좋겠어요.',DATE_SUB(NOW(), INTERVAL 8 DAY)),
 (3,'user5@test.com','1','색감 너무 예뻐요!',DATE_SUB(NOW(), INTERVAL 8 DAY)),
 (4,'user1@test.com','1','번들 분할 어떻게 하셨는지 궁금해요!',DATE_SUB(NOW(), INTERVAL 7 DAY)),
 (4,'user3@test.com','1','React.lazy + 라우트 단위로 나눴어요 👍',DATE_SUB(NOW(), INTERVAL 6 DAY)),
 (7,'user1@test.com','1','해커톤 재밌어 보여요!',DATE_SUB(NOW(), INTERVAL 4 DAY)),
 (8,'user2@test.com','1','축하드려요 🎉',DATE_SUB(NOW(), INTERVAL 3 DAY)),
 (8,'com5@test.com','2','멋진 경험이네요. 저희 앱개발팀 공고도 확인해 주세요!',DATE_SUB(NOW(), INTERVAL 2 DAY)),
 (10,'user6@test.com','1','부산 사람으로서 반갑네요!',DATE_SUB(NOW(), INTERVAL 20 HOUR));

INSERT INTO sns_like_tb (sns_num, login_email, user_type) VALUES
 (1,'user3@test.com','1'),(1,'user6@test.com','1'),
 (2,'user1@test.com','1'),(2,'user4@test.com','1'),(2,'user6@test.com','1'),
 (3,'user5@test.com','1'),(3,'user3@test.com','1'),
 (4,'user1@test.com','1'),(4,'user2@test.com','1'),(4,'user4@test.com','1'),(4,'com1@test.com','2'),
 (5,'user1@test.com','1'),
 (7,'user1@test.com','1'),(7,'user5@test.com','1'),
 (8,'user2@test.com','1'),(8,'user3@test.com','1'),(8,'com5@test.com','2'),
 (10,'user6@test.com','1'),
 (12,'user4@test.com','1');

INSERT INTO sns_follow_tb (login_email, follow_email, follow_user_type) VALUES
 ('user1@test.com','com1@test.com','2'),('user1@test.com','com3@test.com','2'),('user1@test.com','user3@test.com','1'),('user1@test.com','user4@test.com','1'),
 ('user2@test.com','user1@test.com','1'),('user2@test.com','com2@test.com','2'),('user2@test.com','user5@test.com','1'),
 ('user3@test.com','user1@test.com','1'),('user3@test.com','user2@test.com','1'),('user3@test.com','com1@test.com','2'),
 ('user4@test.com','user1@test.com','1'),('user4@test.com','com6@test.com','2'),
 ('user5@test.com','user2@test.com','1'),('user5@test.com','com4@test.com','2'),
 ('user6@test.com','user1@test.com','1'),('user6@test.com','com5@test.com','2'),('user6@test.com','com4@test.com','2'),
 ('com1@test.com','user1@test.com','1'),('com1@test.com','user3@test.com','1');

INSERT INTO sns_intro_tb (user_email, sns_intro) VALUES
 ('user1@test.com','백엔드 개발자를 꿈꾸는 김개발입니다. Java / Spring / 클라우드에 관심이 많아요.'),
 ('user2@test.com','사용자 경험을 고민하는 UI/UX 디자이너입니다. 디자인 시스템을 좋아해요.'),
 ('user3@test.com','React로 빠르고 접근성 좋은 웹을 만드는 프론트엔드 개발자입니다.'),
 ('user4@test.com','데이터 파이프라인을 설계하는 데이터 엔지니어입니다. SQL이 제일 재밌어요.'),
 ('user5@test.com','고객 문제에서 출발하는 서비스 기획자입니다.'),
 ('user6@test.com','앱 출시 경험이 있는 신입 모바일 개발자입니다. Kotlin / Swift 둘 다 좋아해요.');

INSERT INTO sns_feedback_tb (login_email, user_type, resume_num, feedback_content, feedback_date) VALUES
 ('user3@test.com','1',1,'프로젝트 경험이 잘 정리되어 있어요. 성능 개선 수치를 맨 위로 올리면 더 눈에 띌 것 같아요!',DATE_SUB(CURDATE(), INTERVAL 5 DAY)),
 ('user4@test.com','1',1,'자기소개가 구체적이라 좋네요. 사용한 기술 스택 버전도 적어보세요.',DATE_SUB(CURDATE(), INTERVAL 3 DAY)),
 ('user1@test.com','1',3,'Lighthouse 점수 개선 사례 인상적입니다 👍',DATE_SUB(CURDATE(), INTERVAL 2 DAY)),
 ('user5@test.com','1',2,'리서치 과정이 잘 드러나서 좋아요.',DATE_SUB(CURDATE(), INTERVAL 1 DAY));

-- 1:1 채팅 (방 + 메시지 + 읽음 상태)
INSERT INTO chatroom_tb (chatRoom_id, sender_id, receiver_id) VALUES
 (1,'user1@test.com','user3@test.com'),
 (2,'user1@test.com','user6@test.com'),
 (3,'user2@test.com','user5@test.com');

INSERT INTO chat_tb (chat_id, chatRoom_id, sender_id, receiver_id, message, `timestamp`) VALUES
 (1,1,'user1@test.com','user3@test.com','안녕하세요! 성능 개선 글 잘 봤어요.',DATE_SUB(NOW(), INTERVAL 2 DAY)),
 (2,1,'user3@test.com','user1@test.com','감사합니다 😊 궁금한 거 있으면 편하게 물어보세요!',DATE_SUB(NOW(), INTERVAL 2 DAY)),
 (3,1,'user1@test.com','user3@test.com','번들 분할할 때 라우트 기준으로 나누셨나요?',DATE_SUB(NOW(), INTERVAL 1 DAY)),
 (4,1,'user3@test.com','user1@test.com','네, 라우트 단위로 나누고 큰 라이브러리는 따로 분리했어요.',DATE_SUB(NOW(), INTERVAL 20 HOUR)),
 (5,2,'user6@test.com','user1@test.com','코테 스터디 아직 자리 있나요?',DATE_SUB(NOW(), INTERVAL 1 DAY)),
 (6,2,'user1@test.com','user6@test.com','네! 화요일 9시에 디스코드로 오시면 돼요.',DATE_SUB(NOW(), INTERVAL 22 HOUR)),
 (7,2,'user6@test.com','user1@test.com','좋아요, 그때 뵐게요!',DATE_SUB(NOW(), INTERVAL 2 HOUR)),
 (8,3,'user5@test.com','user2@test.com','디자인 시스템 글 잘 봤어요. 기획자 입장에서도 도움이 많이 됐어요.',DATE_SUB(NOW(), INTERVAL 5 HOUR));

INSERT INTO message_status_tb (chat_id, user_id, is_read) VALUES
 (1,'user3@test.com',1),(2,'user1@test.com',1),(3,'user3@test.com',1),(4,'user1@test.com',1),
 (5,'user1@test.com',1),(6,'user6@test.com',1),(7,'user1@test.com',0),
 (8,'user2@test.com',0);
