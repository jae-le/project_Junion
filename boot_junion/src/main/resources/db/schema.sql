-- =====================================================================
-- junion 스키마 (MyBatis 매퍼/DTO 기반 역설계본)
--
-- 원본 DB 덤프가 없어 src/main/resources/mybatis/mappers/*.xml 과 DTO를 보고 재구성했다.
-- 컬럼 타입/길이/기본값은 추정치이므로 원본과 다를 수 있다.
-- 내장 MariaDB 최초 기동 시 EmbeddedMariaDbConfig 가 이 파일을 실행한다.
--
-- 참고
-- - 매퍼에 테이블명 대소문자가 섞여 있어(COM_BOARD / com_board 등) lower_case_table_names=1 로 기동한다.
-- - FK는 걸지 않았다. 앱이 자식 테이블을 직접 지우는 순서가 제각각이라 FK가 있으면 삭제가 실패한다.
-- - com_scrap / notice_scrap 는 컬럼 목록 없는 INSERT(values(...))를 쓰므로 컬럼 수/순서를 바꾸면 안 된다.
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 회원
-- ---------------------------------------------------------------------

-- 개인회원 (user_type '1')
CREATE TABLE user_tb (
  user_email            VARCHAR(100) NOT NULL,
  user_pw               VARCHAR(255) NOT NULL,
  user_pw_check         VARCHAR(255) NULL,
  user_name             VARCHAR(50)  NOT NULL,
  user_questionNum      INT          NULL,          -- 비밀번호 찾기 질문 번호 1~8
  user_questionAnswer   VARCHAR(255) NULL,
  user_type             CHAR(1)      NOT NULL DEFAULT '1',
  user_tel              VARCHAR(20)  NULL,
  user_location         VARCHAR(20)  NULL,          -- 시/도 (location.location_name)
  user_location2        VARCHAR(30)  NULL,          -- 군/구
  user_birthdate        VARCHAR(10)  NULL,          -- 'YYYY-MM-DD' (STR_TO_DATE 로 파싱됨)
  user_gender           VARCHAR(10)  NULL,          -- '남' / '여'
  user_stack            VARCHAR(500) NULL,          -- legacy
  user_position         VARCHAR(255) NULL,          -- legacy
  recent_noticeNumArray TEXT         NULL,          -- 최근 본 공고 번호 (콤마 구분)
  PRIMARY KEY (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 기업회원 (user_type '2')
-- com_email 이 PK 여야 GROUP BY com_email 쿼리(cardPage.xml, main.xml)가 동작한다.
CREATE TABLE com_tb (
  com_email         VARCHAR(100) NOT NULL,
  com_pw            VARCHAR(255) NOT NULL,
  com_pw_check      VARCHAR(255) NULL,
  com_name          VARCHAR(100) NOT NULL,
  com_serial_number VARCHAR(20)  NOT NULL,           -- 사업자등록번호
  user_type         CHAR(1)      NOT NULL DEFAULT '2',
  com_tel           VARCHAR(20)  NULL,
  com_person        VARCHAR(50)  NULL,               -- 담당자
  com_location      VARCHAR(255) NULL,               -- 도로명 주소 (앞 2글자로 지역 필터)
  com_year          DATE         NULL,               -- 설립일
  com_content       TEXT         NULL,
  com_sale          VARCHAR(50)  NULL,               -- 매출(만원)
  com_type          VARCHAR(20)  NULL,               -- 주식회사 / 유한회사 ...
  com_salary        INT          NULL,               -- 평균연봉(만원)
  com_CEO           VARCHAR(50)  NULL,
  com_site          VARCHAR(255) NULL,
  com_employee      INT          NULL,
  update_date       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (com_email),
  UNIQUE KEY uk_com_serial_number (com_serial_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE user_job (
  id         INT          NOT NULL AUTO_INCREMENT,
  user_email VARCHAR(100) NOT NULL,
  job_name   VARCHAR(50)  NOT NULL,
  PRIMARY KEY (id),
  KEY idx_user_job_email (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE user_stack (
  id         INT          NOT NULL AUTO_INCREMENT,
  user_email VARCHAR(100) NOT NULL,
  stack_name VARCHAR(50)  NOT NULL,
  PRIMARY KEY (id),
  KEY idx_user_stack_email (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE com_stack (
  id        INT          NOT NULL AUTO_INCREMENT,
  com_email VARCHAR(100) NOT NULL,
  stack     VARCHAR(50)  NULL,
  PRIMARY KEY (id),
  KEY idx_com_stack_email (com_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 개인회원 프로필 이미지
CREATE TABLE user_attach (
  fileNo     INT          NOT NULL AUTO_INCREMENT,
  uuid       VARCHAR(100) NOT NULL,
  uploadPath VARCHAR(255) NOT NULL,
  fileName   VARCHAR(255) NOT NULL,
  image      TINYINT(1)   NOT NULL DEFAULT 0,
  user_email VARCHAR(100) NOT NULL,
  PRIMARY KEY (fileNo),
  KEY idx_user_attach_email (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 기업 이미지
CREATE TABLE com_attach (
  uuid       VARCHAR(100) NOT NULL,
  uploadPath VARCHAR(255) NOT NULL,
  fileName   VARCHAR(255) NOT NULL,
  image      TINYINT(1)   NOT NULL DEFAULT 0,
  com_email  VARCHAR(100) NOT NULL,
  PRIMARY KEY (uuid),
  KEY idx_com_attach_email (com_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 기업 별점 (지원자가 남김)
CREATE TABLE com_star_tb (
  id         INT          NOT NULL AUTO_INCREMENT,
  user_email VARCHAR(100) NOT NULL,
  com_email  VARCHAR(100) NOT NULL,
  com_star   INT          NOT NULL,
  notice_num INT          NOT NULL,
  PRIMARY KEY (id),
  KEY idx_com_star_com (com_email),
  KEY idx_com_star_user_notice (user_email, notice_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- 코드성 기준 테이블 (data.sql 에서 채움)
-- ---------------------------------------------------------------------

-- 100~199 개발 / 200~299 디자인 / 300~399 기획 (join.xml 에 범위가 고정되어 있음)
CREATE TABLE job (
  job_no   INT         NOT NULL,
  job_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (job_no),
  UNIQUE KEY uk_job_name (job_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 400~499 개발 / 500~599 디자인 / 600~699 기획
CREATE TABLE stack (
  stack_no   INT         NOT NULL,
  stack_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (stack_no),
  UNIQUE KEY uk_stack_name (stack_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE location (
  location_no   INT         NOT NULL AUTO_INCREMENT,
  location_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (location_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE career (
  career_no   INT         NOT NULL AUTO_INCREMENT,
  career_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (career_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- 채용공고 / 지원 / 제안 / 스크랩
-- ---------------------------------------------------------------------

CREATE TABLE notice_tb (
  notice_num         INT          NOT NULL AUTO_INCREMENT,
  com_email          VARCHAR(100) NOT NULL,
  com_name           VARCHAR(100) NULL,
  notice_title       VARCHAR(255) NULL,
  notice_job         VARCHAR(100) NULL,
  notice_recruitNum  INT          NULL,
  notice_area1       VARCHAR(20)  NULL,        -- 시/도
  notice_area2       VARCHAR(30)  NULL,        -- 군/구
  notice_career      VARCHAR(100) NULL,        -- '신입,1~3년' 처럼 콤마 구분
  notice_pay1        VARCHAR(20)  NULL,        -- 연봉 / 월급 / 면접 후 결정
  notice_pay2        INT          NULL,
  notice_startDate   DATE         NULL,
  notice_endDate     DATE         NULL,
  notice_contactType VARCHAR(100) NULL,        -- 정규직,계약직,인턴직,프리랜서
  notice_department  VARCHAR(100) NULL,
  notice_position    VARCHAR(100) NULL,
  notice_jobInfo     TEXT         NULL,
  notice_condition   TEXT         NULL,
  notice_prefer      TEXT         NULL,
  notice_benefit     TEXT         NULL,
  notice_hit         INT          NOT NULL DEFAULT 0,
  notice_status      VARCHAR(10)  NULL DEFAULT '공고중',   -- 공고중 / 공고마감
  noticeCheck        VARCHAR(10)  NULL DEFAULT '미열람',   -- 열람 / 미열람
  update_date        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (notice_num),
  KEY idx_notice_com (com_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notice_stack (
  id         INT          NOT NULL AUTO_INCREMENT,
  notice_num INT          NOT NULL,
  stack      VARCHAR(50)  NOT NULL,
  com_email  VARCHAR(100) NULL,
  PRIMARY KEY (id),
  KEY idx_notice_stack_num (notice_num),
  KEY idx_notice_stack_com (com_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notice_attach (
  uuid       VARCHAR(100) NOT NULL,
  uploadPath VARCHAR(255) NOT NULL,
  fileName   VARCHAR(255) NOT NULL,
  image      TINYINT(1)   NOT NULL DEFAULT 0,
  notice_num INT          NOT NULL,
  PRIMARY KEY (uuid),
  KEY idx_notice_attach_num (notice_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 이력서. resume_num 은 매퍼가 max+1 로 직접 채번한다.
CREATE TABLE resume_tb (
  resume_num            INT          NOT NULL,
  user_email            VARCHAR(100) NOT NULL,
  resume_title          VARCHAR(100) NULL,
  resume_writeDate      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  resume_age            VARCHAR(20)  NULL,
  resume_pay            INT          NULL,
  career_start          DATE         NULL,
  career_end            DATE         NULL,
  resume_status         VARCHAR(10)  NULL,        -- 재직중 / 퇴사
  resume_comName        VARCHAR(100) NULL,
  resume_comPart        VARCHAR(100) NULL,
  resume_comPosition    VARCHAR(100) NULL,
  resume_eduStart       DATE         NULL,
  resume_eduEnd         DATE         NULL,
  resume_eduName        VARCHAR(100) NULL,
  resume_eduMajor       VARCHAR(100) NULL,
  resume_eduStatus      VARCHAR(10)  NULL,        -- 졸업 / 졸업예정 / 재학중 / 휴학중
  resume_eduDegree      VARCHAR(50)  NULL,
  resume_exStart        DATE         NULL,
  resume_exEnd          DATE         NULL,
  resume_exName         VARCHAR(100) NULL,
  resume_exContent      VARCHAR(255) NULL,
  resume_licenseDate    DATE         NULL,
  resume_licenseContent VARCHAR(255) NULL,
  resume_portfolio_name VARCHAR(255) NULL,
  resume_portfolio_url  VARCHAR(500) NULL,
  resume_intro          TEXT         NULL,
  resume_offer          VARCHAR(5)   NULL DEFAULT '예',  -- 인재풀 공개 여부 예 / 아니오
  -- 아래는 SELECT 에서만 쓰이는 컬럼 (없으면 Unknown column 오류)
  user_address          VARCHAR(255) NULL,
  career_month          VARCHAR(50)  NULL,
  careerNum             INT          NULL,
  eduNum                INT          NULL,
  exNum                 INT          NULL,
  licenseNum            INT          NULL,
  portfolioNum          INT          NULL,
  PRIMARY KEY (resume_num),
  KEY idx_resume_user (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE resume_stack (
  id         INT         NOT NULL AUTO_INCREMENT,
  resume_num INT         NOT NULL,
  stack_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  KEY idx_resume_stack_num (resume_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE resume_attach (
  uuid       VARCHAR(100) NOT NULL,
  uploadPath VARCHAR(255) NOT NULL,
  fileName   VARCHAR(255) NOT NULL,
  image      TINYINT(1)   NOT NULL DEFAULT 0,
  resume_num INT          NOT NULL,
  PRIMARY KEY (uuid),
  KEY idx_resume_attach_num (resume_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 지원 내역
CREATE TABLE submit_tb (
  submit_no        INT          NOT NULL AUTO_INCREMENT,
  notice_num       INT          NOT NULL,
  resume_num       INT          NOT NULL,
  user_email       VARCHAR(100) NOT NULL,
  com_email        VARCHAR(100) NULL,
  joincompany_date DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  submit_check     VARCHAR(10)  NULL DEFAULT '미열람',   -- 미열람 / 열람
  submit_status    VARCHAR(10)  NULL,                    -- 합격 / 불합격 / 보류
  PRIMARY KEY (submit_no),
  KEY idx_submit_notice_resume (notice_num, resume_num),
  KEY idx_submit_user (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 기업 -> 개인 포지션 제안
CREATE TABLE offer (
  offer_no          INT          NOT NULL AUTO_INCREMENT,
  notice_num        INT          NULL,
  user_email        VARCHAR(100) NULL,
  com_email         VARCHAR(100) NULL,
  resume_num        INT          NULL,
  offer_title       VARCHAR(200) NULL,
  offer_name        VARCHAR(100) NULL,
  offer_job         VARCHAR(100) NULL,
  offer_career      VARCHAR(50)  NULL,
  offer_pay         VARCHAR(50)  NULL,
  offer_content     TEXT         NULL,
  offer_date        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  offer_agree       VARCHAR(10)  NOT NULL DEFAULT '미응답',  -- 미응답 / 지원완료 / 제안거절
  resume_submitDate DATETIME     NULL,
  PRIMARY KEY (offer_no),
  KEY idx_offer_notice_user (notice_num, user_email),
  KEY idx_offer_user (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 최근 본 공고 (비로그인 조회 시 user_email 이 NULL 로 들어옴)
CREATE TABLE recent_notice (
  id         INT          NOT NULL AUTO_INCREMENT,
  notice_num INT          NOT NULL,
  user_email VARCHAR(100) NULL,
  PRIMARY KEY (id),
  KEY idx_recent_user_notice (user_email, notice_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 주의: 컬럼 없는 INSERT 사용 -> 컬럼 2개, 순서 고정
CREATE TABLE notice_scrap (
  notice_num INT          NOT NULL,
  user_email VARCHAR(100) NOT NULL,
  PRIMARY KEY (notice_num, user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 주의: 컬럼 없는 INSERT 사용 -> 컬럼 2개, 순서 고정
CREATE TABLE com_scrap (
  com_email  VARCHAR(100) NOT NULL,
  user_email VARCHAR(100) NOT NULL,
  PRIMARY KEY (com_email, user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- 게시판 (개인 / 기업 / 공지)
-- ---------------------------------------------------------------------

CREATE TABLE user_board (
  board_no      INT          NOT NULL AUTO_INCREMENT,
  user_email    VARCHAR(100) NOT NULL,
  board_title   VARCHAR(255) NOT NULL,
  board_content LONGTEXT     NULL,
  create_date   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  board_hit     INT          NOT NULL DEFAULT 0,
  user_type     INT          NULL,
  board_file    VARCHAR(255) NULL,
  board_like    INT          NULL DEFAULT 0,
  PRIMARY KEY (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE com_board (
  board_no      INT          NOT NULL AUTO_INCREMENT,
  com_email     VARCHAR(100) NOT NULL,
  board_title   VARCHAR(255) NOT NULL,
  board_content LONGTEXT     NULL,
  create_date   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  board_hit     INT          NOT NULL DEFAULT 0,
  user_type     INT          NULL,
  PRIMARY KEY (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notice_board (
  board_no      INT          NOT NULL AUTO_INCREMENT,
  login_email   VARCHAR(100) NOT NULL,
  board_title   VARCHAR(255) NOT NULL,
  board_content LONGTEXT     NULL,
  create_date   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  board_hit     INT          NOT NULL DEFAULT 0,
  user_type     INT          NULL,
  PRIMARY KEY (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE user_board_like (
  id         INT          NOT NULL AUTO_INCREMENT,
  board_no   INT          NOT NULL,
  user_email VARCHAR(100) NOT NULL,
  board_like INT          NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uk_user_board_like (board_no, user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE com_board_like (
  id         INT          NOT NULL AUTO_INCREMENT,
  board_no   INT          NOT NULL,
  com_email  VARCHAR(100) NOT NULL,
  board_like INT          NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uk_com_board_like (board_no, com_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notice_board_like (
  id          INT          NOT NULL AUTO_INCREMENT,
  board_no    INT          NOT NULL,
  login_email VARCHAR(100) NOT NULL,
  board_like  INT          NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uk_notice_board_like (board_no, login_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE board_user_comment (
  commentNo          INT           NOT NULL AUTO_INCREMENT,
  user_email         VARCHAR(100)  NULL,
  commentContent     VARCHAR(1000) NOT NULL,
  board_no           INT           NOT NULL,
  commentCreatedTime DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (commentNo),
  KEY idx_buc_board (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE com_board_comment (
  commentNo          INT           NOT NULL AUTO_INCREMENT,
  com_email          VARCHAR(100)  NULL,
  commentContent     VARCHAR(1000) NOT NULL,
  board_no           INT           NOT NULL,
  commentCreatedTime DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (commentNo),
  KEY idx_cbc_board (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notice_board_comment (
  commentNo          INT           NOT NULL AUTO_INCREMENT,
  login_email        VARCHAR(100)  NULL,
  commentContent     VARCHAR(1000) NOT NULL,
  board_no           INT           NOT NULL,
  commentCreatedTime DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (commentNo),
  KEY idx_nbc_board (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE board_attach (
  uuid       VARCHAR(100) NOT NULL,
  uploadPath VARCHAR(200) NOT NULL,
  fileName   VARCHAR(255) NOT NULL,
  image      TINYINT(1)   NOT NULL DEFAULT 0,
  board_no   INT          NOT NULL,
  PRIMARY KEY (uuid),
  KEY idx_board_attach_no (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE com_board_attach (
  uuid       VARCHAR(100) NOT NULL,
  uploadPath VARCHAR(200) NOT NULL,
  fileName   VARCHAR(255) NOT NULL,
  image      TINYINT(1)   NOT NULL DEFAULT 0,
  board_no   INT          NOT NULL,
  PRIMARY KEY (uuid),
  KEY idx_com_board_attach_no (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE notice_board_attach (
  uuid       VARCHAR(100) NOT NULL,
  uploadPath VARCHAR(200) NOT NULL,
  fileName   VARCHAR(255) NOT NULL,
  image      TINYINT(1)   NOT NULL DEFAULT 0,
  board_no   INT          NOT NULL,
  PRIMARY KEY (uuid),
  KEY idx_notice_board_attach_no (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- 고객센터: 공지사항 / 이용약관
-- ---------------------------------------------------------------------

CREATE TABLE announcements_board (
  board_no      INT          NOT NULL AUTO_INCREMENT,
  login_email   VARCHAR(100) NULL,
  board_title   VARCHAR(255) NOT NULL,
  board_content LONGTEXT     NULL,
  create_date   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE terms_tb (
  board_no      INT          NOT NULL AUTO_INCREMENT,
  login_email   VARCHAR(100) NULL,
  board_title   VARCHAR(255) NOT NULL,
  board_content LONGTEXT     NULL,
  create_date   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  term_type     VARCHAR(10)  NOT NULL,   -- 개인 / 기업
  PRIMARY KEY (board_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- 데일리 CS 퀴즈 (cs_num 마다 세 테이블에 한 행씩 있어야 함)
-- ---------------------------------------------------------------------

CREATE TABLE cs_tb (
  cs_num        INT         NOT NULL,
  cs_type       VARCHAR(30) NOT NULL,   -- Java / Spring / Javascript / HTML/CSS
  cs_answer_num INT         NOT NULL,   -- 정답 보기 번호 (1부터)
  PRIMARY KEY (cs_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cs_question_tb (
  cs_num                  INT           NOT NULL,
  cs_question_title       TEXT          NOT NULL,
  cs_question_option      VARCHAR(1000) NOT NULL,   -- 보기 (콤마 구분)
  cs_question_explanation TEXT          NULL,
  PRIMARY KEY (cs_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- INSERT 없이 UPDATE 만 하므로 문제마다 행이 미리 있어야 한다.
CREATE TABLE cs_user (
  cs_num        INT          NOT NULL,
  user_email    VARCHAR(100) NULL,
  cs_user_check VARCHAR(10)  NULL DEFAULT '미참여',
  PRIMARY KEY (cs_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------
-- SNS / 채팅
-- ---------------------------------------------------------------------

CREATE TABLE sns_tb (
  sns_num     INT          NOT NULL AUTO_INCREMENT,
  login_email VARCHAR(100) NOT NULL,
  user_type   CHAR(1)      NOT NULL,
  sns_title   VARCHAR(255) NULL,
  sns_content TEXT         NULL,
  sns_date    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (sns_num),
  KEY idx_sns_login (login_email),
  KEY idx_sns_date (sns_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sns_comment_tb (
  sns_comment_num     INT          NOT NULL AUTO_INCREMENT,
  sns_num             INT          NOT NULL,
  login_email         VARCHAR(100) NOT NULL,
  user_type           CHAR(1)      NOT NULL,
  sns_comment_content TEXT         NULL,
  sns_comment_date    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (sns_comment_num),
  KEY idx_sns_comment_num (sns_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sns_attach (
  uuid       VARCHAR(100) NOT NULL,
  uploadPath VARCHAR(255) NOT NULL,
  fileName   VARCHAR(255) NOT NULL,
  image      TINYINT(1)   NOT NULL DEFAULT 0,
  sns_num    INT          NOT NULL,
  PRIMARY KEY (uuid),
  KEY idx_sns_attach_num (sns_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sns_like_tb (
  sns_num     INT          NOT NULL,
  login_email VARCHAR(100) NOT NULL,
  user_type   CHAR(1)      NOT NULL,
  PRIMARY KEY (sns_num, login_email, user_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- login_email(팔로워) -> follow_email(팔로잉 대상), follow_user_type 은 대상의 회원유형
CREATE TABLE sns_follow_tb (
  login_email      VARCHAR(100) NOT NULL,
  follow_email     VARCHAR(100) NOT NULL,
  follow_user_type CHAR(1)      NOT NULL,
  PRIMARY KEY (login_email, follow_email, follow_user_type),
  KEY idx_follow_email (follow_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ON DUPLICATE KEY UPDATE 를 쓰므로 user_email 이 PK 여야 함
CREATE TABLE sns_intro_tb (
  user_email VARCHAR(100) NOT NULL,
  sns_intro  TEXT         NULL,
  PRIMARY KEY (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sns_feedback_tb (
  feedback_num     INT          NOT NULL AUTO_INCREMENT,
  login_email      VARCHAR(100) NOT NULL,
  user_type        CHAR(1)      NOT NULL,
  resume_num       INT          NOT NULL,
  feedback_content TEXT         NULL,
  feedback_date    DATE         NULL,
  PRIMARY KEY (feedback_num),
  KEY idx_feedback_resume (resume_num)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 매퍼에서 chatRoom_tb / chatroom_tb 두 가지로 씀 (lower_case_table_names=1 필요)
CREATE TABLE chatroom_tb (
  chatRoom_id INT          NOT NULL AUTO_INCREMENT,
  sender_id   VARCHAR(100) NOT NULL,
  receiver_id VARCHAR(100) NOT NULL,
  PRIMARY KEY (chatRoom_id),
  KEY idx_chatroom_pair (sender_id, receiver_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE chat_tb (
  chat_id     INT          NOT NULL AUTO_INCREMENT,
  chatRoom_id INT          NOT NULL,
  sender_id   VARCHAR(100) NOT NULL,
  receiver_id VARCHAR(100) NOT NULL,
  message     TEXT         NULL,
  `timestamp` DATETIME     NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (chat_id),
  KEY idx_chat_room (chatRoom_id, chat_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE message_status_tb (
  chat_id INT          NOT NULL,
  user_id VARCHAR(100) NOT NULL,
  is_read TINYINT(1)   NOT NULL DEFAULT 0,
  PRIMARY KEY (chat_id, user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
