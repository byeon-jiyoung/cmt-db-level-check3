-- 카테고리 및 게시글 내용 출력
SELECT category.category_id, category.title, category.content, board.title, board.sub_title, author.author_name, board.register_date, board.content, attachment.path, attachment.file_name
FROM board
JOIN category ON board.category_id = category.category_id
JOIN author ON board.author_id = author.author_id
LEFT JOIN attachment ON attachment.attachment_id = board.attachment_id
WHERE board_id = 1;

-- 작가 아이디 변수 지정
SET @author_information := 
(SELECT author.author_id
FROM board
JOIN category ON board.category_id = category.category_id
JOIN author ON board.author_id = author.author_id
LEFT JOIN attachment ON attachment.attachment_id = board.attachment_id
WHERE board_id = 1);

SELECT @author_information;

-- 좋아요 수
SELECT COUNT(*) FROM good WHERE board_id = 1;

-- 공유 수
SELECT COUNT(sharing_id) FROM sharing WHERE board_id = 1;

-- 게시글에 포함된 태그
SELECT hashtag_name 
FROM board_hashtag
WHERE board_id = 1;

-- 댓글
SELECT member.member_name, reply.register_date, reply.content
FROM reply
JOIN member ON reply.member_id = member.member_id
WHERE board_id = 1;

-- 작가이름, 작가직업, 작가소개글, 작가프로필 사진

SELECT author.author_name, job.job_name, author.introduce, photo.path, photo.file_name, (SELECT COUNT(*) FROM subscribe WHERE author_id = @author_information) AS subscribe_count
FROM author 
JOIN member ON author_id = member_id 
LEFT JOIN photo ON photo.member_id = member.member_id
JOIN job ON job.job_id = author.job_id
WHERE author.author_id = @author_information;

-- 다른작가의 최신글 6개
SELECT attachment.path, board.title, board.content, board.author_id
FROM board
LEFT JOIN attachment ON attachment.attachment_id = board.attachment_id
WHERE board.author_id != @author_information 
ORDER BY board_id DESC LIMIT 6;

-- 이전글
SELECT *
FROM board
WHERE category_id = (SELECT category.category_id FROM board JOIN category ON board.category_id = category.category_id WHERE board_id = 1)
AND board_id < 1
ORDER BY board_id;

-- 다음글
SELECT *
FROM board
WHERE category_id = (SELECT category.category_id FROM board JOIN category ON board.category_id = category.category_id WHERE board_id = 1)
AND board_id > 1
ORDER BY board_id LIMIT 1;

