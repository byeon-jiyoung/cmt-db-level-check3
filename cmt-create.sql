-- 회원
CREATE TABLE member (
	member_id	VARCHAR(30)	NOT NULL,
	member_pw	VARCHAR(30)	NOT NULL,
	member_name	VARCHAR(20) NOT NULL,
	birth			DATE    	  	NULL,
	join_date	DATETIME    NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (member_id)
);

-- 사진
CREATE TABLE photo (
	member_id		VARCHAR(30)		NOT NULL,
	path          	VARCHAR(100)	NOT NULL,
	file_name		VARCHAR(40)		NOT NULL,
	register_date 	DATETIME			NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (member_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id)
);

-- 직업
CREATE TABLE job (
	job_id		INT         NOT NULL AUTO_INCREMENT,
	job_name		VARCHAR(50)	NOT NULL,
	PRIMARY KEY (job_id)
);

-- 작가
CREATE TABLE author (
	author_id	VARCHAR(30)		NOT NULL,
	job_id		INT				NOT NULL,
	author_name	VARCHAR(50)		NULL,
	introduce	VARCHAR(200)	NULL,
	PRIMARY KEY (author_id),
	FOREIGN KEY (author_id) REFERENCES member (member_id),
	FOREIGN KEY (job_id) REFERENCES job (job_id)
);

-- 카테고리
CREATE TABLE category (
	category_id	INT				NOT NULL AUTO_INCREMENT,
	author_id   VARCHAR(30)		NOT NULL,
	title       VARCHAR(30)		NOT NULL,
	content     VARCHAR(200)	NOT NULL,
	PRIMARY KEY (category_id),
	FOREIGN KEY (author_id) REFERENCES author (author_id)
);

-- 첨부파일
CREATE TABLE attachment (
	attachment_id	INT				NOT NULL AUTO_INCREMENT,
	author_id		VARCHAR(30)		NOT NULL,
	path				VARCHAR(100)	NOT NULL,
	file_name		VARCHAR(40)		NOT NULL,
	register_date	DATETIME			NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (attachment_id),
	FOREIGN KEY (author_id) REFERENCES author (author_id)
);

-- 게시글
CREATE TABLE board (
	board_id			INT          	NOT NULL AUTO_INCREMENT,
	attachment_id	INT          	NULL,
	author_id		VARCHAR(30)		NOT NULL,
	category_id   	INT          	NOT NULL,
	title         	VARCHAR(200)	NOT NULL,
	sub_title     	VARCHAR(200) 	NULL,
	content       	LONGTEXT     	NOT NULL,
	register_date 	DATETIME     	NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (board_id),
	FOREIGN KEY (attachment_id) REFERENCES attachment (attachment_id),
	FOREIGN KEY (author_id) REFERENCES author (author_id),
	FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- 태그
CREATE TABLE hashtag (
	hashtag_name	VARCHAR(30) NOT NULL,
	register_date	DATETIME    NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (hashtag_name)
);

-- 게시글_태그
CREATE TABLE board_hashtag (
	board_id			INT         NOT NULL,
	hashtag_name	VARCHAR(30)	NOT NULL,
	PRIMARY KEY (board_id, hashtag_name),
	FOREIGN KEY (board_id) REFERENCES board (board_id),
	FOREIGN KEY (hashtag_name) REFERENCES hashtag (hashtag_name)
);

-- 댓글
CREATE TABLE reply (
	reply_id			INT           	NOT NULL AUTO_INCREMENT,
	member_id		VARCHAR(30)   	NOT NULL,
	board_id			INT           	NOT NULL,
	content			VARCHAR(1000)	NOT NULL,
	register_date 	DATETIME      	NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (reply_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id),
	FOREIGN KEY (board_id) REFERENCES board (board_id)
);

-- 구독
CREATE TABLE subscribe (
	category_id		INT			NOT NULL,
	member_id		VARCHAR(30)	NOT NULL,
	register_date	DATETIME    NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (category_id, member_id),
	FOREIGN KEY (category_id) REFERENCES category (category_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id)
);

-- 좋아요
CREATE TABLE good (
	board_id			INT         NOT NULL,
	member_id		VARCHAR(30) NOT NULL,
	register_date	DATETIME    NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (board_id, member_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id),
	FOREIGN KEY (board_id) REFERENCES board (board_id)
);

-- 공유경로
CREATE TABLE sharing_path (
	sharing_path_id	INT			NOT NULL AUTO_INCREMENT,
	path					VARCHAR(50)	NOT NULL,
	PRIMARY KEY(sharing_path_id)
);

-- 공유
CREATE TABLE sharing (
	sharing_id    		INT         NOT NULL AUTO_INCREMENT,
	member_id     		VARCHAR(30)	NOT NULL,
	board_id     	 	INT         NOT NULL,
	sharing_path_id	INT 			NOT NULL,
	register_date 		DATETIME    NOT NULL DEFAULT(NOW()),
	PRIMARY KEY (sharing_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id),
	FOREIGN KEY (board_id) REFERENCES board (board_id),
	FOREIGN KEY (sharing_path_id) REFERENCES sharing_path (sharing_path_id)
);