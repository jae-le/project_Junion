-- =====================================================================
-- 샘플 이미지 첨부 행 (data.sql 다음에 실행)
-- 실제 파일은 db/sample-upload/ 에 있고, 앱 기동 시 EmbeddedMariaDbConfig 가
-- 업로드 폴더(C:/devv/upload/sample/)로 s_<uuid>_<파일명>(썸네일)과 <uuid>_<파일명>(원본)으로 복사한다.
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO com_attach (uuid, uploadPath, fileName, image, com_email) VALUES
 ('seed-company1','sample','company1.jpg',1,'com1@test.com'),
 ('seed-company2','sample','company2.jpg',1,'com2@test.com'),
 ('seed-company3','sample','company3.jpg',1,'com3@test.com'),
 ('seed-company4','sample','company4.jpg',1,'com4@test.com'),
 ('seed-company5','sample','company5.jpg',1,'com5@test.com'),
 ('seed-company6','sample','company6.jpg',1,'com6@test.com');

INSERT INTO notice_attach (uuid, uploadPath, fileName, image, notice_num) VALUES
 ('seed-notice1','sample','notice1.jpg',1,1),
 ('seed-notice2','sample','notice2.jpg',1,2),
 ('seed-notice3','sample','notice3.jpg',1,3),
 ('seed-notice4','sample','notice4.jpg',1,4),
 ('seed-notice5','sample','notice5.jpg',1,5),
 ('seed-notice6','sample','notice6.jpg',1,6),
 ('seed-notice7','sample','notice7.jpg',1,7),
 ('seed-notice8','sample','notice8.jpg',1,8),
 ('seed-notice9','sample','notice9.jpg',1,9),
 ('seed-notice10','sample','notice10.jpg',1,10),
 ('seed-notice11','sample','notice11.jpg',1,11),
 ('seed-notice12','sample','notice12.jpg',1,12),
 ('seed-notice13','sample','notice13.jpg',1,13),
 ('seed-notice14','sample','notice14.jpg',1,14);

INSERT INTO sns_attach (uuid, uploadPath, fileName, image, sns_num) VALUES
 ('seed-sns1','sample','sns1.jpg',1,1),
 ('seed-sns2','sample','sns2.jpg',1,2),
 ('seed-sns3','sample','sns3.jpg',1,3),
 ('seed-sns4','sample','sns4.jpg',1,4),
 ('seed-sns5','sample','sns5.jpg',1,5),
 ('seed-sns6','sample','sns6.jpg',1,6),
 ('seed-sns7','sample','sns7.jpg',1,7),
 ('seed-sns8','sample','sns8.jpg',1,8),
 ('seed-sns10','sample','sns10.jpg',1,10),
 ('seed-sns12','sample','sns12.jpg',1,12);

INSERT INTO user_attach (uuid, uploadPath, fileName, image, user_email) VALUES
 ('seed-admin','sample','admin.png',1,'admin@admin.com'),
 ('seed-user1','sample','user1.png',1,'user1@test.com'),
 ('seed-user2','sample','user2.png',1,'user2@test.com'),
 ('seed-user3','sample','user3.png',1,'user3@test.com'),
 ('seed-user4','sample','user4.png',1,'user4@test.com'),
 ('seed-user5','sample','user5.png',1,'user5@test.com'),
 ('seed-user6','sample','user6.png',1,'user6@test.com');

-- 이력서 증명사진 (Unsplash 인물 사진, 출처는 sample-upload/CREDITS.txt)
INSERT INTO resume_attach (uuid, uploadPath, fileName, image, resume_num) VALUES
 ('seed-resume1','sample','resume1.jpg',1,1),
 ('seed-resume2','sample','resume2.jpg',1,2),
 ('seed-resume3','sample','resume3.jpg',1,3),
 ('seed-resume4','sample','resume4.jpg',1,4),
 ('seed-resume5','sample','resume5.jpg',1,5),
 ('seed-resume6','sample','resume6.jpg',1,6);
