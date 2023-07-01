DROP TABLE MATCH CASCADE CONSTRAINTS;
DROP TABLE `SET` CASCADE CONSTRAINTS;
DROP TABLE GAME CASCADE CONSTRAINTS;
DROP TABLE FIGHTER CASCADE CONSTRAINTS;
DROP TABLE PLAYERGAME CASCADE CONSTRAINTS;
DROP TABLE PLAYER CASCADE CONSTRAINTS;

-- MATCH table stores the date of the overall event, or match.  
-- Each SET has more than one GAME, and there are usually more than one sets in a MATCH.  
-- There is usually more than one GAME in a SET, and the winner of the most games determines the winner of a SET. 
-- There are usually two players in a GAME, hence the PLAYERGAME table which keeps track of each player's individual games, and can be tied back to GAME, SET, and MATCH. 
-- The FIGHTER table stores the names of fighters to prevent redundancy and errors

CREATE TABLE MATCH (
    matchid VARCHAR2(50),
    matchdate DATE,
    PRIMARY KEY (matchid),
);
CREATE TABLE `SET` ( -- set has to be in backticks because it is a keyword in mysql
    setid VARCHAR2(50),
    matchid VARCHAR2(50),
    PRIMARY KEY(setid),
    CONSTRAINT fk_setmatch FOREIGN KEY (matchid) REFERENCES MATCH(matchid)
);
CREATE TABLE GAME (
    gameid VARCHAR2(50),
    setid VARCHAR2(50),
    PRIMARY KEY(gameid),
    CONSTRAINT fk_gameset FOREIGN KEY (setid) REFERENCES `SET` (setid)
);
CREATE TABLE PLAYER (
    playername VARCHAR2(50),
    PRIMARY KEY (playername)
);
CREATE TABLE FIGHTER (
    fightername VARCHAR2(50),
    PRIMARY KEY (fightername)
);
CREATE TABLE PLAYERGAME (
    playergameid VARCHAR2(50),
    playername VARCHAR2(50),
    gameid VARCHAR2(50),
    fightername VARCHAR2(50),
    stockswon int,
    win BOOLEAN,
    PRIMARY KEY(playergameid),
    CONSTRAINT fk_playergameplayer FOREIGN KEY (playername) REFERENCES PLAYER (playername),
    CONSTRAINT fk_playergamegame FOREIGN KEY (gameid) REFERENCES GAME (gameid)
    CONSTRAINT fk_playergamefighter FOREIGN KEY (fightername) REFERENCES FIGHTER (fightername)
);