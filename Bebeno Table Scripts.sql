-- WEB 계정 생성
--CREATE USER BEBENO IDENTIFIED BY BEBENO;
--GRANT RESOURCE, CONNECT TO BEBENO;

--DROP TABLE WAGLE_BOARD;
--DROP TABLE CART;
--DROP TABLE MEMBER;
--DROP TABLE BBN_STORE;
--DROP TABLE STORE_FILE;
--DROP TABLE WAGLE_BOARD_REPLY;
--DROP TABLE WAGLE_FILE;
--DROP SEQUENCE SEQ_UNO;
--DROP SEQUENCE SEQ_STORE_NO;
--DROP SEQUENCE SEQ_S_FILE_NO;
--DROP SEQUENCE SEQ_WAGLE_BOARD_NO;
--DROP SEQUENCE SEQ_WAGLE_REPLY_NO;
--DROP SEQUENCE SEQ_W_FILE_NO;

------------------------------------------------
-------------- BBN_STORE 관련 테이블 ------------
------------------------------------------------

CREATE TABLE BBN_STORE (
    STORE_NO NUMBER PRIMARY KEY,
    STORE_WRITERNO NUMBER,
    STORE_KORNAME VARCHAR2(100),
    STORE_ENGNAME VARCHAR2(100),
    STORE_ZIPCODE NUMBER,
    STORE_ADDRESS1 VARCHAR2(100),
    STORE_ADDRESS2 VARCHAR2(100),
    STORE_PHONE VARCHAR2(20),
    STORE_TIME VARCHAR2(100),
    STORE_TYPE VARCHAR2(20) CHECK(STORE_TYPE IN('와인샵', '레스토랑')),
    STORE_STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STORE_STATUS IN('Y', 'N')),
    STORE_CONTENT VARCHAR2(2000), 
    STORE_CONTENT2 VARCHAR2(2000),
	ORIGINAL_FILENAME VARCHAR2(100), 
	RENAMED_FILENAME VARCHAR2(100), 
    ENROLL_DATE DATE DEFAULT SYSDATE,
    MODIFY_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN BBN_STORE.STORE_NO IS '상점고유번호';
COMMENT ON COLUMN BBN_STORE.STORE_WRITERNO IS '작성자고유번호';
COMMENT ON COLUMN BBN_STORE.STORE_KORNAME IS '한글상호';
COMMENT ON COLUMN BBN_STORE.STORE_ENGNAME IS '영문상호';
COMMENT ON COLUMN BBN_STORE.STORE_ZIPCODE IS '우편번호';
COMMENT ON COLUMN BBN_STORE.STORE_ADDRESS1 IS '주소1';
COMMENT ON COLUMN BBN_STORE.STORE_ADDRESS2 IS '주소2';
COMMENT ON COLUMN BBN_STORE.STORE_PHONE IS '연락처';
COMMENT ON COLUMN BBN_STORE.STORE_TIME IS '운영시간';
COMMENT ON COLUMN BBN_STORE.STORE_TYPE IS '업종';
COMMENT ON COLUMN BBN_STORE.STORE_STATUS IS '상태값';
COMMENT ON COLUMN BBN_STORE.STORE_CONTENT IS '내용';
COMMENT ON COLUMN BBN_STORE.STORE_CONTENT2 IS '내용2';
COMMENT ON COLUMN BBN_STORE.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN BBN_STORE.RENAMED_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN BBN_STORE.ENROLL_DATE IS '등록일';
COMMENT ON COLUMN BBN_STORE.MODIFY_DATE IS '수정일';

CREATE SEQUENCE SEQ_STORE_NO;


------------------------------------------------
-------------- STORE_FILE 관련 테이블 ------------
------------------------------------------------
CREATE TABLE STORE_FILE (
    S_FILE_NO NUMBER PRIMARY KEY,
    STORE_NO NUMBER,
    ORIGINAL_FILENAME VARCHAR2(100),
	RENAMED_FILENAME VARCHAR2(100),
    FOREIGN KEY (STORE_NO) REFERENCES BBN_STORE (STORE_NO)
);

CREATE SEQUENCE SEQ_S_FILE_NO;

COMMENT ON COLUMN STORE_FILE.S_FILE_NO IS '파일고유번호';
COMMENT ON COLUMN STORE_FILE.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN STORE_FILE.RENAMED_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN STORE_FILE.STORE_NO IS '상점고유번호';
------------------------------------------------
--------------- MEMBER 관련 테이블 ---------------
------------------------------------------------

CREATE TABLE MEMBER (
    NO NUMBER PRIMARY KEY,
    ID VARCHAR2(30) NOT NULL UNIQUE,
    NICKNAME VARCHAR2(30) NOT NULL UNIQUE,
    PASSWORD VARCHAR2(100) NOT NULL,
    ROLE VARCHAR2(20) DEFAULT 'ROLE_USER',
    NAME VARCHAR2(15) NOT NULL,
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(100),
    ADDRESS VARCHAR2(100),
    BIRTH VARCHAR2(20) NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N')),
    ENROLL_DATE DATE DEFAULT SYSDATE,
    MODIFY_DATE DATE DEFAULT SYSDATE,
    O_PROFILEIMGNAME VARCHAR2(100), 
	R_PROFILEIMGNAME VARCHAR2(100)
);

COMMENT ON COLUMN MEMBER.NO IS '회원번호';
COMMENT ON COLUMN MEMBER.ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.NICKNAME IS '닉네임';
COMMENT ON COLUMN MEMBER.PASSWORD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.ROLE IS '회원타입';
COMMENT ON COLUMN MEMBER.NAME IS '회원명';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.BIRTH IS '생일';
COMMENT ON COLUMN MEMBER.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원가입일';
COMMENT ON COLUMN MEMBER.MODIFY_DATE IS '정보수정일';
COMMENT ON COLUMN MEMBER.O_PROFILEIMGNAME IS '프로필이미지파일원래이름';
COMMENT ON COLUMN MEMBER.R_PROFILEIMGNAME IS '프로필이미지파일변경이름';

CREATE SEQUENCE SEQ_UNO;

INSERT INTO MEMBER (
    NO, 
    ID,
    NICKNAME,
    PASSWORD, 
    ROLE,
    NAME, 
    PHONE, 
    EMAIL, 
    ADDRESS, 
    BIRTH, 
    STATUS, 
    ENROLL_DATE, 
    MODIFY_DATE,
    O_PROFILEIMGNAME,
    R_PROFILEIMGNAME
) VALUES(
    SEQ_UNO.NEXTVAL, 
    'admin2', 
    'Sumin',
    '1234', 
    'ROLE_USER', 
    '수민서', 
    '010-1234-5742', 
    'admin@iei.or.kr', 
    '서울시 강남구 역삼동',
    '1999-04-28',
    DEFAULT,
    DEFAULT,
    DEFAULT,
    NULL,
    NULL
);

COMMIT;

--SELECT * FROM MEMBER WHERE ID='admin' AND STATUS='Y'; 
                                         
-- 멤버 조회
-- SELECT * FROM MEMBER WHERE ID=? AND STATUS='Y'

-- 멤버 추가
-- INSERT INTO MEMBER VALUES(SEQ_UNO.NEXTVAL,?,?,DEFAULT,?,?,?,?,?,DEFAULT,DEFAULT,DEFAULT)

-- 멤버 수정               
-- UPDATE MEMBER SET NAME=?,PHONE=?,EMAIL=?,ADDRESS=?,HOBBY=?,MODIFY_DATE=SYSDATE WHERE NO=?

-- 멤버 패스워드 변경
-- UPDATE MEMBER SET PASSWORD=? WHERE NO=?

-- 멤버 삭제
-- UPDATE MEMBER SET STATUS=? WHERE NO=?

------------------------------------------------
--------- BEBENO_WINEBOARD 관련 테이블 ----------
------------------------------------------------

CREATE TABLE BEBENO_WINEBOARD (	
    WINE_BNO NUMBER PRIMARY KEY,
    WINE_CODE NUMBER,
	WINE_NAME VARCHAR2(100), 
    WINE_ENG VARCHAR2(100),
	WINE_TYPE VARCHAR2(50), 
    WINE_MF VARCHAR2(50),
    WINE_NATIONAL VARCHAR2(50),
    WINE_PRICE VARCHAR2(10),
	ORIGINAL_FILENAME VARCHAR2(100), 
	RENAMED_FILENAME VARCHAR2(100), 
    WINE_SL VARCHAR2(10),
    WINE_AC VARCHAR2(10),
    WINE_BODY VARCHAR2(10),
    WINE_TN VARCHAR2(10),
    WINE_INFO VARCHAR2(500),
	READCOUNT NUMBER DEFAULT 0, 
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
    CREATE_DATE DATE DEFAULT SYSDATE,
    MODIFY_DATE DATE DEFAULT SYSDATE 
);

-- WINEBOARD 테이블 COMMENT 추가
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_BNO IS '게시물번호';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_CODE IS '와인코드';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_NAME IS '와인명';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_ENG IS '영문명';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_TYPE IS '종류';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_MF IS '제조국';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_NATIONAL IS '지역';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_PRICE IS '가격';
COMMENT ON COLUMN BEBENO_WINEBOARD.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN BEBENO_WINEBOARD.RENAMED_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_SL IS '당도';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_AC IS '산도';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_BODY IS '바디';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_TN IS '타닌';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_INFO IS '상세정보';
COMMENT ON COLUMN BEBENO_WINEBOARD.READCOUNT IS '조회수';
COMMENT ON COLUMN BEBENO_WINEBOARD.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN BEBENO_WINEBOARD.CREATE_DATE IS '게시글올린날짜';
COMMENT ON COLUMN BEBENO_WINEBOARD.MODIFY_DATE IS '게시글수정날짜';

CREATE SEQUENCE SEQ_WINE_NO;

---------------------------------------------------------------------------
-------------- WAGLE_BOARD 관련 테이블 ------------
------------------------------------------------

CREATE TABLE WAGLE_BOARD (
    WAGLE_NO NUMBER,
    WRITER_NO NUMBER,
    WINE_NO NUMBER,
    SHOP_NO NUMBER,
	WAGLE_TITLE VARCHAR2(50), 
	WALGE_CONTENT VARCHAR2(2000), 
	ORIGINAL_FILENAME VARCHAR2(100),
	RENAMED_FILENAME VARCHAR2(100), 
	READCOUNT NUMBER DEFAULT 0, 
    STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')),
    CREATE_DATE DATE DEFAULT SYSDATE, 
    MODIFY_DATE DATE DEFAULT SYSDATE,
    CATEGORY VARCHAR2(20) CHECK (CATEGORY IN('wine', 'shop')),
    CONSTRAINT PK_BOARD_NO PRIMARY KEY(WAGLE_NO),
    CONSTRAINT FK_BOARD_WRITER FOREIGN KEY(WRITER_NO) REFERENCES MEMBER(NO) ON DELETE SET NULL,
    CONSTRAINT FK_WINE_NO FOREIGN KEY(WINE_NO) REFERENCES BEBENO_WINEBOARD(WINE_BNO) ON DELETE SET NULL,
    CONSTRAINT FK_SHOP_NO FOREIGN KEY(SHOP_NO) REFERENCES BBN_STORE(STORE_NO) ON DELETE SET NULL
);

CREATE SEQUENCE SEQ_WAGLE_BOARD_NO;

COMMENT ON COLUMN WAGLE_BOARD.WAGLE_NO IS '게시글번호';
COMMENT ON COLUMN WAGLE_BOARD.WRITER_NO IS '게시글작성자';
COMMENT ON COLUMN WAGLE_BOARD.WINE_NO IS '참조와인번호';
COMMENT ON COLUMN WAGLE_BOARD.SHOP_NO IS '참조가게번호';
COMMENT ON COLUMN WAGLE_BOARD.WAGLE_TITLE IS '게시글제목';
COMMENT ON COLUMN WAGLE_BOARD.WALGE_CONTENT IS '게시글내용';
COMMENT ON COLUMN WAGLE_BOARD.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN WAGLE_BOARD.RENAMED_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN WAGLE_BOARD.READCOUNT IS '조회수';
COMMENT ON COLUMN WAGLE_BOARD.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN WAGLE_BOARD.CREATE_DATE IS '게시글올린날짜';
COMMENT ON COLUMN WAGLE_BOARD.MODIFY_DATE IS '게시글수정날짜';
COMMENT ON COLUMN WAGLE_BOARD.CATEGORY IS '와글타입';

INSERT INTO WAGLE_BOARD VALUES(SEQ_WAGLE_BOARD_NO.NEXTVAL, 1, '', '', '게시글 1',  '와인후기', '원본파일명.txt', '변경된파일명.txt', DEFAULT, 'Y', SYSDATE, SYSDATE, 'wine');

-- 총 게시글 갯수
-- SELECT COUNT(*) FROM BOARD WHERE STATUS='Y'

-- 조회수 증가
-- UPDATE BOARD SET READCOUNT=? WHERE NO=?

-- 게시글 작성
-- INSERT INTO BOARD VALUES(SEQ_BOARD_NO.NEXTVAL,?,?,?,?,?,DEFAULT,DEFAULT,DEFAULT,DEFAULT)

-- 게시글 수정
-- UPDATE BOARD SET TITLE=?,CONTENT=?,ORIGINAL_FILENAME=?,RENAMED_FILENAME=?,MODIFY_DATE=SYSDATE WHERE NO=?

-- 게시글 삭제
-- UPDATE BOARD SET STATUS=? WHERE NO=?

------------------------------------------------
---------- WAGLE_BOARD_REPLY 관련 테이블 --------
------------------------------------------------

CREATE TABLE WAGLE_BOARD_REPLY(
      NO NUMBER PRIMARY KEY,
      W_NO NUMBER,
      WRITER_NO NUMBER,
      CONTENT VARCHAR2(400),
      STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
      CREATE_DATE DATE DEFAULT SYSDATE,
      MODIFY_DATE DATE DEFAULT SYSDATE,
      FOREIGN KEY (W_NO) REFERENCES WAGLE_BOARD (WAGLE_NO),
      FOREIGN KEY (WRITER_NO) REFERENCES MEMBER
);

CREATE SEQUENCE SEQ_WAGLE_REPLY_NO;

COMMENT ON COLUMN WAGLE_BOARD_REPLY.NO IS '댓글번호';
COMMENT ON COLUMN WAGLE_BOARD_REPLY.W_NO IS '댓글이작성된게시글';
COMMENT ON COLUMN WAGLE_BOARD_REPLY.WRITER_NO IS '댓글작성자';
COMMENT ON COLUMN WAGLE_BOARD_REPLY.CONTENT IS '댓글내용';
COMMENT ON COLUMN WAGLE_BOARD_REPLY.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN WAGLE_BOARD_REPLY.CREATE_DATE IS '댓글올린날짜';
COMMENT ON COLUMN WAGLE_BOARD_REPLY.MODIFY_DATE IS '댓글수정날짜';

INSERT INTO WAGLE_BOARD_REPLY VALUES(SEQ_WAGLE_REPLY_NO.NEXTVAL, 1, 1, '안녕하세요.', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO WAGLE_BOARD_REPLY VALUES(SEQ_WAGLE_REPLY_NO.NEXTVAL, 1, 1, '반갑습니다.', DEFAULT, DEFAULT, DEFAULT);

------------------------------------------------
-------------- WAGLE_FILE 관련 테이블 ------------
------------------------------------------------
CREATE TABLE WAGLE_FILE (
    W_FILE_NO NUMBER PRIMARY KEY,
    W_NO NUMBER,
    ORIGINAL_FILENAME VARCHAR2(100),
	RENAMED_FILENAME VARCHAR2(100),
    FOREIGN KEY (W_NO) REFERENCES WAGLE_BOARD (WAGLE_NO)
);

CREATE SEQUENCE SEQ_W_FILE_NO;

COMMENT ON COLUMN WAGLE_FILE.W_FILE_NO IS '파일고유번호';
COMMENT ON COLUMN WAGLE_FILE.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN WAGLE_FILE.RENAMED_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN WAGLE_FILE.W_NO IS '와글고유번호';

COMMIT;                                      


-- WINEBOARD 테이블 COMMENT 추가
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_BNO IS '게시물번호';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_CODE IS '와인코드';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_NAME IS '와인명';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_ENG IS '영문명';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_TYPE IS '종류';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_MF IS '제조국';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_NATIONAL IS '지역';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_PRICE IS '가격';
COMMENT ON COLUMN BEBENO_WINEBOARD.ORIGINAL_FILENAME IS '첨부파일원래이름';
COMMENT ON COLUMN BEBENO_WINEBOARD.RENAMED_FILENAME IS '첨부파일변경이름';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_SL IS '당도';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_AC IS '산도';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_BODY IS '바디';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_TN IS '타닌';
COMMENT ON COLUMN BEBENO_WINEBOARD.WINE_INFO IS '상세정보';
COMMENT ON COLUMN BEBENO_WINEBOARD.READCOUNT IS '조회수';
COMMENT ON COLUMN BEBENO_WINEBOARD.STATUS IS '상태값(Y/N)';
COMMENT ON COLUMN BEBENO_WINEBOARD.CREATE_DATE IS '게시글올린날짜';
COMMENT ON COLUMN BEBENO_WINEBOARD.MODIFY_DATE IS '게시글수정날짜';
COMMENT ON COLUMN BEBENO_WINEBOARD.amount IS '와인수량';

CREATE SEQUENCE SEQ_WINE_NO;

insert into bebeno_wineboard values(seq_wine_no.nextval,01,'지로 리보 Giro Ribot,Giro Ribot', 'Cava Ab Origine Brut Reserva','스파클링','스페인','페네데스','59000원','1','1','1','1','1','1','1',DEFAULT,DEFAULT,DEFAULT,DEFAULT);
commit;

-- 명령어 시퀀스 조회/삭제

select * from user_sequences;

commit;


-- CART TABLE CREATE -- 
CREATE TABLE CART( 
    ID VARCHAR2(30),
    WINE_BNO NUMBER,
    CART_ID NUMBER PRIMARY KEY,
    CART_QTY NUMBER(10),
    ADDDATE date default sysdate
);  

-- 카트 테이블 COMMENT 추가 --
COMMENT ON COLUMN CART.ID IS '회원아이디';
COMMENT ON COLUMN CART.WINE_BNO IS '와인게시물번호';
COMMENT ON COLUMN CART.CART_ID IS '장바구니번호';
COMMENT ON COLUMN CART.CART_QTY IS '장바구니수량'; 
COMMENT ON COLUMN CART.addDate IS '장바구니입력날짜'; 

-- 시퀀스 생성 -- 
CREATE SEQUENCE SEQ_CART_NO;

-- member, wineboard 테이블 조인 -- 
 ALTER TABLE CART ADD CONSTRAINT cart_fk_WINE_BNO FOREIGN KEY (WINE_BNO) REFERENCES bebeno_wineboard(WINE_BNO);
 ALTER TABLE CART ADD CONSTRAINT CART_FK_ID FOREIGN KEY (ID) REFERENCES MEMBER(ID); 

