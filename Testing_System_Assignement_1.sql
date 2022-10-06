DROP DATABASE IF EXISTS Testing_System_Assignement_1;
CREATE DATABASE Testing_System_Assignement_1;

USE Testing_System_Assignement_1;

DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
DepartmentName VARCHAR(30)  NOT NULL UNIQUE KEY
);
INSERT INTO `Department` (DepartmentName)
VALUES 
('Sale'),
('marketing'),
('Data'),
('Thu ki'),
('Bao ve'),
('Truc ban'),
('Hanh chinh'),
('Giam doc'),
('Nhan vien'),
('Quan ly');




DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position` (
PositionID  INT AUTO_INCREMENT PRIMARY KEY,
PositionName VARCHAR(50) NOT NULL UNIQUE KEY
);
INSERT INTO `Position` (PositionName)
VALUES 
('Dev'),
('Test'),
('PM'),
('CODE'),
('Scrum Master');



DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
AccountID INT AUTO_INCREMENT PRIMARY KEY,
Email VARCHAR(30) NOT NULL UNIQUE KEY,
Username  VARCHAR(30) NOT NULL UNIQUE KEY,
FullName VARCHAR(30) NOT NULL,
DepartmentID INT NOT NULL,
PositionID INT NOT NULL,
CreateDate DATETIME ,
FOREIGN KEY(DepartmentID) REFERENCES  `Department`(DepartmentID) ON DELETE CASCADE,
FOREIGN KEY(PositionID) REFERENCES  `Position`(PositionID) ON DELETE CASCADE
);
INSERT INTO `Account`(Email,Username,FullName,DepartmentID,PositionID,CreateDate)
VALUES 
    ('Email1@gmail.com','Username1','Fullname1',5,1,'2020-03-05'),
    ('Email2@gmail.com','Username2','Fullname2',1,2,'2009-03-05'),
    ('Email3@gmail.com','Username3','Fullname3',2,2,'2020-03-07'),
    ('Email4@gmail.com','Username4','Fullname4',3,4,'2001-03-08'),
    ('Email5@gmail.com','Username5','Fullname5',4,4,'2020-03-10'),
    ('Email6@gmail.com','Username6','Fullname6',6,3,'2020-04-05'),
    ('Email7@gmail.com','Username7','Fullname7',2,2,NULL),
    ('Email8@gmail.com','Username8','Fullname8',8,1,'2020-04-07'),
    ('Email9@gmail.com','Username9','Fullname9',2,2,'2020-04-07'),
    ('Email10@gmail.com','Username10','Fullname10',10,1,'2020-04-09'),
    ('Email11@gmail.com','Username11','Fullname11',10,1,DEFAULT),
    ('Email12@gmail.com','Username12','Fullname12',10,1,DEFAULT);




DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
GroupID  INT AUTO_INCREMENT PRIMARY KEY,
GroupName VARCHAR(30) NOT NULL UNIQUE KEY,
CreatorID INT NOT NULL UNIQUE KEY,
CreateDate DATE NOT NULL UNIQUE KEY
);

INSERT INTO `Group`(GroupName, CreatorID, CreateDate)
VALUES ('Testing System', 5, '2019-03-05'),
    ('Development', 1, '2020-03-07'),
    ('VTI Sale 01', 2, '2020-03-09'),
    ('VTI Sale 02', 3, '2020-03-10'),
    ('VTI Sale 03', 4, '2020-03-28'),
    ('VTI Creator', 6, '2020-04-06'),
    ('VTI Marketing 01', 7, '2020-04-07'),
    ('Management', 8, '2020-04-08'),
    ('Chat with love', 9, '2020-04-09'),
    ('Vi Ti Ai', 10, '2020-04-10');



DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount`(
GroupID INT,
AccountID INT NOT NULL ,
JoinDate DATE NOT NULL
);
INSERT INTO `GroupAccount`(GroupID, AccountID, JoinDate)
VALUES
    (1, 1, '2019-03-05'),
    (1, 2, '2020-03-07'),
    (3, 3, '2020-03-09'),
    (3, 4, '2020-03-10'),
    (5, 5, '2020-03-28'),
    (1, 3, '2020-04-06'),
    (1, 7, '2020-04-07'),
    (8, 3, '2020-04-08'),
    (1, 9, '2020-04-09'),
    (10, 10, '2020-04-10');
    
    
    

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion` (
TypeID INT AUTO_INCREMENT PRIMARY KEY,
TypeName VARCHAR(50) NOT NULL UNIQUE KEY
);
INSERT INTO TypeQuestion(TypeName)
VALUES ('Essay'),
    ('Multiple-Choice');
    
    


DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion` (
CategoryID INT AUTO_INCREMENT PRIMARY KEY,
CategoryName VARCHAR(50) NOT NULL UNIQUE KEY
);
INSERT INTO CategoryQuestion(CategoryName)
VALUES 
	('Java'),
    ('ASP.NET'),
    ('ADO.NET'),
    ('SQL'),
    ('Postman'),
    ('Ruby'),
    ('Python'),
    ('C++'),
    ('C Sharp'),
    ('PHP');





DROP TABLE IF EXISTS  `Question`;
CREATE TABLE `Question` (
QuestionID INT AUTO_INCREMENT PRIMARY KEY,
Content VARCHAR(60) NOT NULL UNIQUE KEY,
CategoryID INT NOT NULL UNIQUE KEY,
TypeID INT NOT NULL,
CreatorID INT NOT NULL, 
CreateDate DATE NOT NULL
);
INSERT INTO Question (Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES 
    ('Câu hỏi về Java', 1, '1', '2', '2020-04-05'),
    ('Câu Hỏi về PHP', 10, '2', '2', '2020-04-05'),
    ('Hỏi về C#', 9, '2', '3', '2020-04-06'),
    ('Hỏi về Ruby', 6, '1', '4', '2020-04-06'),
    ('Hỏi về Postman', 5, '1', '5', '2020-04-06'),
    ('Hỏi về ADO.NET', 3, '2', '6', '2020-04-06'),
    ('Hỏi về ASP.NET', 2, '1', '7', '2020-04-06'),
    ('Hỏi về C++', 8, '1', '8', '2020-04-07'),
    ('Hỏi về SQL', 4, '2', '9', '2020-04-07'),
    ('Hỏi về Python', 7, '1', '10', '2020-04-07');
    
    
    


DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer` (
AnswerID INT AUTO_INCREMENT PRIMARY KEY,
Content VARCHAR(50) ,
QuestionID  INT NOT NULL ,
IsCorrect BOOL,
FOREIGN KEY(QuestionID) REFERENCES  `Question`(QuestionID) ON DELETE CASCADE
);
INSERT INTO Answer(Content, QuestionID, isCorrect)
VALUES 
    ('Trả lời 01', 1, 0),
    ('Trả lời 02', 1, 1),
    ('Trả lời 03', 1, 0),
    ('Trả lời 04', 1, 1),
	('Trả lời 05', 2, 1),
    ('Trả lời 06', 3, 1),
    ('Trả lời 07', 4, 0),
    ('Trả lời 08', 8, 0),
    ('Trả lời 09', 9, 1),
    ('Trả lời 10', 10, 1);
    
    
    
    
    
    

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam` (
ExamID INT  AUTO_INCREMENT PRIMARY KEY,
`Code` VARCHAR(50) NOT NULL UNIQUE KEY,
Title  VARCHAR(30) NOT NULL UNIQUE KEY,
CategoryID INT NOT NULL UNIQUE KEY,
Duration VARCHAR(30) NOT NULL,
CreatorID INT NOT NULL ,
CreateDate Date NOT NULL 
);
INSERT INTO Exam (`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES   
    ('VTIQ001','Đề thi C#',1,60,'5','2019-04-05'),
    ('VTIQ002','Đề thi PHP',10,60,'2','2019-04-05'),
    ('VTIQ003','Đề thi C++',9,120,'2','2019-04-07'),
    ('VTIQ004','Đề thi Java',6,60,'3','2020-04-08'),
    ('VTIQ005','Đề thi Ruby',5,120,'4','2020-04-10'),
    ('VTIQ006','Đề thi Postman',3,60,'6','2020-04-05'),
    ('VTIQ007','Đề thi SQL',2,60,'7','2020-04-05'),
    ('VTIQ008','Đề thi Python', 8,60,'8',  '2020-04-07'),
    ('VTIQ009','Đề thi ADO.NET',4,90,'9','2020-04-07'),
    ('VTIQ010','Đề thi ASP.NET',7,90,'10','2020-04-08');
    





DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion` (
ExamID INT PRIMARY KEY,
QuestionID  INT NOT NULL ,
FOREIGN KEY(ExamID) REFERENCES  `Exam`(ExamID) ON DELETE CASCADE,
FOREIGN KEY(QuestionID) REFERENCES  `Question`(QuestionID) ON DELETE CASCADE
);
INSERT INTO ExamQuestion(ExamID, QuestionID)
VALUES   
	(1, 5),
    (2, 10),
    (3, 4),
    (4, 3),
    (5, 7),
    (6, 10),
    (7, 2),
    (8, 10),
    (9, 9),
    (10, 8);

