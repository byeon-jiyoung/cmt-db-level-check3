-- 회원
CREATE TABLE member (
	member_id	VARCHAR(30) NOT NULL, 						-- 회원아이디
	member_pw   VARCHAR(30) NOT NULL,    					-- 비밀번호
	member_name	VARCHAR(20) NOT NULL,     					-- 회원명
	birth       DATE    	  	NULL,     						-- 생년월일
	join_date   DATETIME    NOT NULL DEFAULT(NOW()),	-- 가입일
	PRIMARY KEY (member_id)
);

-- 사진
CREATE TABLE photo (
	member_id     	VARCHAR(30)  NOT NULL,     					-- 회원아이디
	path          	VARCHAR(100) NOT NULL,     					-- 첨부파일경로
	file_name		VARCHAR(40)	 NOT NULL,							-- 파일명
	register_date 	DATETIME     NOT NULL DEFAULT(NOW()),  	-- 등록일
	PRIMARY KEY (member_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id)
);

-- 직업
CREATE TABLE job (
	job_id INT         NOT NULL AUTO_INCREMENT, 	-- 직업번호
	job_name   VARCHAR(50) NOT NULL,						-- 직업명
	PRIMARY KEY (job_id)
);

-- 작가
CREATE TABLE author (
	author_id	VARCHAR(30)  NOT NULL,		-- 작가아이디
	job_id		INT          NOT NULL,		-- 직업번호
	author_name	VARCHAR(50)  NULL,			-- 작가명
	introduce	VARCHAR(200) NULL,			-- 소개글
	PRIMARY KEY (author_id),
	FOREIGN KEY (author_id) REFERENCES member (member_id),
	FOREIGN KEY (job_id) REFERENCES job (job_id)
);

-- 카테고리
CREATE TABLE category (
	category_id INT          NOT NULL AUTO_INCREMENT,		-- 카테고리번호
	author_id   VARCHAR(30)  NOT NULL,							-- 작성자(작가아이디)
	title       VARCHAR(30)  NOT NULL,							-- 제목
	content     VARCHAR(200) NOT NULL,							-- 내용
	PRIMARY KEY (category_id),
	FOREIGN KEY (author_id) REFERENCES author (author_id)
);

-- 첨부파일
CREATE TABLE attachment (
	attachment_id INT          NOT NULL AUTO_INCREMENT,	-- 첨부파일번호
	author_id     VARCHAR(30)  NOT NULL,     					-- 회원아이디
	path          VARCHAR(100) NOT NULL,     					-- 첨부파일경로
	file_name		VARCHAR(40)	NOT NULL,						-- 파일명
	register_date DATETIME     NOT NULL DEFAULT(NOW()),   -- 등록일
	PRIMARY KEY (attachment_id),
	FOREIGN KEY (author_id) REFERENCES author (author_id)
);

-- 게시글
CREATE TABLE board (
	board_id      INT          NOT NULL AUTO_INCREMENT,	-- 게시글번호
	attachment_id INT          NULL,								-- 대표이미지(첨부파일번호)
	author_id     VARCHAR(30)  NOT NULL,						-- 작가아이디
	category_id   INT          NOT NULL,						-- 카테고리번호
	title         VARCHAR(200) NOT NULL,						-- 제목
	sub_title     VARCHAR(200) NULL,								-- 소제목
	content       LONGTEXT     NOT NULL,						-- 내용
	register_date DATETIME     NOT NULL DEFAULT(NOW()),	-- 작성일
	PRIMARY KEY (board_id),
	FOREIGN KEY (attachment_id) REFERENCES attachment (attachment_id),
	FOREIGN KEY (author_id) REFERENCES author (author_id),
	FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- 태그
CREATE TABLE hashtag (
	hashtag_name  VARCHAR(30) NOT NULL,							-- 태그명
	register_date DATETIME    NOT NULL DEFAULT(NOW()),		-- 등록일
	PRIMARY KEY (hashtag_name)
);

-- 게시글_태그
CREATE TABLE board_hashtag (
	board_id     INT         NOT NULL, 	-- 게시글번호
	hashtag_name VARCHAR(30) NOT NULL,  			-- 태그명
	PRIMARY KEY (board_id, hashtag_name),
	FOREIGN KEY (board_id) REFERENCES board (board_id),
	FOREIGN KEY (hashtag_name) REFERENCES hashtag (hashtag_name)
);

-- 댓글
CREATE TABLE reply (
	reply_id      INT           NOT NULL AUTO_INCREMENT,		-- 댓글번호
	member_id     VARCHAR(30)   NOT NULL,     					-- 작성자(회원아이디)
	board_id      INT           NOT NULL,    						-- 게시글번호
	content       VARCHAR(1000) NOT NULL,   						-- 내용
	register_date DATETIME      NOT NULL DEFAULT(NOW()),     -- 작성일
	PRIMARY KEY (reply_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id),
	FOREIGN KEY (board_id) REFERENCES board (board_id)
);

-- 구독
CREATE TABLE subscribe (
	category_id	  INT			  NOT NULL,							-- 작가아이디
	member_id     VARCHAR(30) NOT NULL,							-- 구독자(회원아이디)
	register_date DATETIME    NOT NULL DEFAULT(NOW()),		-- 구독일
	PRIMARY KEY (category_id, member_id),
	FOREIGN KEY (category_id) REFERENCES category (category_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id)
);

-- 좋아요
CREATE TABLE good (
	board_id      INT         NOT NULL,							-- 게시글번호
	member_id     VARCHAR(30) NOT NULL,							-- 회원아이디
	register_date DATETIME    NOT NULL DEFAULT(NOW()),    -- 등록일
	PRIMARY KEY (board_id, member_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id),
	FOREIGN KEY (board_id) REFERENCES board (board_id)
);

-- 공유경로
CREATE TABLE sharing_path (
	sharing_path_id	INT			NOT NULL AUTO_INCREMENT,	-- 공유경로번호
	path					VARCHAR(50)	NOT NULL,						-- 공유경로명
	PRIMARY KEY(sharing_path_id)
);

-- 공유
CREATE TABLE sharing (
	sharing_id    		INT         NOT NULL AUTO_INCREMENT,		-- 공유번호
	member_id     		VARCHAR(30) NOT NULL,							-- 회원아이디
	board_id     	 	INT         NOT NULL,							-- 게시글번호cmt3
	sharing_path_id	INT 			NOT NULL,							-- 공유경로
	register_date 		DATETIME    NOT NULL DEFAULT(NOW()),		-- 등록일
	PRIMARY KEY (sharing_id),
	FOREIGN KEY (member_id) REFERENCES member (member_id),
	FOREIGN KEY (board_id) REFERENCES board (board_id),
	FOREIGN KEY (sharing_path_id) REFERENCES sharing_path (sharing_path_id)
);


-- 