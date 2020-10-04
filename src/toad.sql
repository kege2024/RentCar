insert into rentcar values (1, '아반테', 1, 2000, 5, '현대', '1.jpg', '아반테 입니다');
insert into rentcar values (2, 'bmw', 3, 6000, 5, 'bmw', '2.jpg', 'bmw 입니다');
insert into rentcar values (3, '카니발', 3, 4000, 8, '현대', '3.jpg', '카니발 입니다');
insert into rentcar values (4, '카렌스', 2, 2000, 6, '현대', '4.jpg', '카렌스 입니다');
insert into rentcar values (5, '코란도', 2, 3000, 5, '쌍용', '5.jpg', '코란도 입니다');
insert into rentcar values (6, '에쿠스', 3, 3000, 5, '현대', '6.jpg', '에쿠스 입니다');
insert into rentcar values (7, '제네시스', 3, 4000, 5, '현대', '7.jpg', '제네시스 입니다');
insert into rentcar values (8, '그랜져', 3, 4000, 5, '현대', '8.jpg', '그랜져 입니다');
insert into rentcar values (9, 'k3', 1, 2000, 5, '기아', '9.jpg', 'k3 입니다');
insert into rentcar values (10, 'k5', 2, 3000, 5, '기아', '10.jpg', 'k5 입니다');
insert into rentcar values (11, 'k7', 3, 4000, 5, '기아', '11.jpg', 'k7 입니다');
insert into rentcar values (12, 'k9', 3, 5000, 5, '기아', '12.jpg', 'k9 입니다');
insert into rentcar values (13, '라세티', 1, 1500, 5, 'gm', '13.jpg', '라세티 입니다');
insert into rentcar values (14, 'lf소나타', 2, 3000, 5, '현대', '14.jpg', 'lf소나타 입니다');
insert into rentcar values (15, '말리부', 2, 3000, 5, 'gm', '15.jpg', '말리부 입니다');
insert into rentcar values (16, '모닝', 1, 1000, 5, '기아', '16.jpg', '모닝 입니다');
insert into rentcar values (17, '올란도', 2, 3000, 6, 'gm', '17.jpg', '올란도 입니다');
insert into rentcar values (18, '레이', 1, 1000, 5, '기아', '18.jpg', '레이 입니다');
insert into rentcar values (19, 'sm5', 2, 2000, 5, '삼성', '19.jpg', 'sm5 입니다');
insert into rentcar values (20, 'sm7', 3, 3000, 5, '삼성', '20.jpg', 'sm7 입니다');
insert into rentcar values (21, '소렌토', 2, 3000, 5, '기아', '21.jpg', '소렌토 입니다');
insert into rentcar values (22, '소울', 1, 1000, 5, '기아', '22.jpg', '소울 입니다');
insert into rentcar values (23, '스파크', 1, 1000, 5, 'gm', '23.jpg', '스파크 입니다');
insert into rentcar values (24, '스포티지', 2, 2000, 4, '기아', '24.jpg', '스포티지 입니다');
insert into rentcar values (25, '크루즈', 1, 2000, 5, 'gm', '25.jpg', '크루 입니다');
insert into rentcar values (26, '투리스모', 1, 2000, 6, 'gm', '26.jpg', '투리스모 입니다');

      <Resource auth="Container" driverClassName="oracle.jdbc.driver.OracleDriver" loginTimeout="10" maxWait="5000" name="jdbc/pool" password="apmsetup" type="javax.sql.DataSource" url="jdbc:oracle:thin@localhost:1521:XE" username="XE" />


CREATE TABLE XE.BOARD
(
  NUM        NUMBER,
  WRITER     VARCHAR2(20 BYTE),
  EMAIL      VARCHAR2(50 BYTE),
  SUBJECT    VARCHAR2(50 BYTE),
  PASSWORD   VARCHAR2(10 BYTE),
  REG_DATE   DATE,
  REF        NUMBER,
  RE_STEP    NUMBER,
  RE_LEVEL   NUMBER,
  READCOUNT  NUMBER,
  CONTENT    VARCHAR2(500 BYTE)
)

CREATE TABLE XE.MEMBER
(
  ID     VARCHAR2(10 BYTE),
  PASS1  VARCHAR2(20 BYTE),
  EMAIL  VARCHAR2(50 BYTE),
  TEL    VARCHAR2(20 BYTE),
  HOBBY  VARCHAR2(60 BYTE),
  JOB    VARCHAR2(15 BYTE),
  AGE    VARCHAR2(10 BYTE),
  INFO   VARCHAR2(500 BYTE)
)

CREATE TABLE XE.CARRESERVE
(
  RESERVENO  NUMBER,
  NO         NUMBER                             NOT NULL,
  ID         VARCHAR2(50 BYTE)                  NOT NULL,
  QTY        NUMBER                             NOT NULL,
  DDAY       NUMBER                             NOT NULL,
  RDAY       VARCHAR2(50 BYTE)                  NOT NULL,
  USEIN      NUMBER                             NOT NULL,
  USEWIFI    NUMBER                             NOT NULL,
  USESEAT    NUMBER                             NOT NULL,
  USENAVI    NUMBER                             NOT NULL
)

CREATE SEQUENCE XE.RESERVE_SEQ
  START WITH 21
  MAXVALUE 1000
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

 CREATE SEQUENCE XE.BOARD_SEQ
  START WITH 20
  MAXVALUE 1000
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;