USE Testing_System_Assignement_1;

-- 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ 
SELECT  A.Email, B.DepartmentName , A.FullName 
FROM `Account`A
INNER JOIN Department B ON A.DepartmentID = B.DepartmentName;

 -- 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010  
SELECT * FROM `Account`
WHERE CreateDate < '2010/12/20';

-- 3: Viết lệnh để lấy ra tất cả các developer  
SELECT A.FullName, B.PositionName, A.Email
FROM `Account`A
INNER JOIN `Position`B ON A.PositionID = B.PositionID 
WHERE B.PositionName = 'developer';

-- 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên 
SELECT D.DepartmentName, count(a.DepartmentID) AS SL 
FROM account A
INNER JOIN department D ON a.DepartmentID = D.DepartmentID
GROUP BY A.DepartmentID
HAVING COUNT(A.DepartmentID) >3;

-- 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều
SELECT E.QuestionID, Q.Content 
FROM examquestion E
INNER JOIN question Q ON Q.QuestionID = E.QuestionID
GROUP BY E.QuestionID
HAVING count(E.QuestionID) = (SELECT MAX(countQues) as maxcountQues FROM (
SELECT COUNT(E.QuestionID) AS countQues FROM examquestion E
GROUP BY E.QuestionID) AS countTable);


-- 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question 
SELECT a.CategoryID, a.CategoryName, count(q.CategoryID) 
FROM categoryquestion a
JOIN question q ON a.CategoryID = q.CategoryID
GROUP BY q.CategoryID;

-- 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam Question 
SELECT q.QuestionID, q.Content , count(e.QuestionID) 
FROM examquestion e
RIGHT JOIN question q ON q.QuestionID = e.QuestionID
GROUP BY q.QuestionID;


-- 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.QuestionID, Q.Content, count(A.QuestionID)
FROM answer A
INNER JOIN question Q ON Q.QuestionID = A.QuestionID
GROUP BY A.QuestionID
HAVING count(A.QuestionID) = (SELECT max(countQues) FROM
(SELECT count(B.QuestionID) AS countQues FROM answer B
GROUP BY B.QuestionID) AS countAnsw);

-- 9: Thống kê số lượng account trong mỗi group
SELECT G.GroupID, COUNT(A.AccountID) AS 'SO LUONG'
FROM GroupAccount A
JOIN `Group` G ON A.GroupID = G.GroupID
GROUP BY G.GroupID
ORDER BY G.GroupID ASC;

-- 10: Tìm chức vụ có ít người nhất
SELECT P.PositionID, P.PositionName, count( A.PositionID) AS SL FROM account A
INNER JOIN position P ON A.PositionID = P.PositionID
GROUP BY A.PositionID
HAVING count(A.PositionID)= (SELECT MIN(minP) FROM(
SELECT count(B.PositionID) AS minP FROM account B
GROUP BY B.PositionID) AS minPA);

-- 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT D.DepartmentID, D.DepartmentName, P.PositionName, count(P.PositionName) 
FROM `account` A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
INNER JOIN position P ON A.PositionID = P.PositionID
GROUP BY D.DepartmentID, P.PositionID;

-- 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT Q.QuestionID, Q.Content, A.FullName, TQ.TypeName AS Author, ANS.Content 
FROM question Q
INNER JOIN categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
INNER JOIN account A ON A.AccountID = Q.CreatorID
INNER JOIN Answer AS ANS ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID ASC;

-- 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT TQ.TypeID, TQ.TypeName, COUNT(Q.TypeID) AS SL FROM question Q
INNER JOIN typequestion TQ ON Q.TypeID = TQ.TypeID
GROUP BY Q.TypeID;

-- 14:Lấy ra group không có account nào sử dụng Left Join
SELECT * FROM `group` G
LEFT JOIN groupaccount A ON G.GroupID = A.GroupID
WHERE A.AccountID IS NULL;

-- 15: Lấy ra group không có account nào
SELECT * FROM `Group`
WHERE GroupID NOT IN (SELECT GroupID FROM GroupAccount);

-- 16: Lấy ra question không có answer nào
SELECT * FROM Question
WHERE QuestionID NOT IN (SELECT QuestionID From Answer);


-- 17
-- a) Lấy các account thuộc nhóm thứ 1
SELECT A.FullName 
FROM `Account` A
JOIN GroupAccount G ON A.AccountID = G.AccountID
WHERE G.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT A.FullName 
FROM `Account` A
JOIN GroupAccount G ON A.AccountID = G.AccountID
WHERE G.GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount G ON A.AccountID = G.AccountID
WHERE G.GroupID = 1
UNION
SELECT A.FullName
FROM `Account` A
JOIN GroupAccount G ON A.AccountID = G.AccountID
WHERE G.GroupID = 2;


-- 18
-- a) Lấy các group có lớn hơn 5 thành viên
SELECT G.GroupName, COUNT(A.GroupID) AS SL
FROM GroupAccount A
JOIN `Group` G ON A.GroupID = G.GroupID
GROUP BY G.GroupID
HAVING COUNT(A.GroupID) >= 5;

-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT G.GroupName, COUNT(A.GroupID) AS SL
FROM GroupAccount A
JOIN `Group` G ON A.GroupID = G.GroupID
GROUP BY G.GroupID
HAVING COUNT(A.GroupID) <= 7;

-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT G.GroupName, COUNT(A.GroupID) AS SL
FROM GroupAccount A
JOIN `Group`G ON A.GroupID = G.GroupID
GROUP BY G.GroupID
HAVING COUNT(A.GroupID) >= 5
UNION
SELECT G.GroupName, COUNT(A.GroupID) AS SL
FROM GroupAccount A
JOIN `Group` G ON A.GroupID = G.GroupID
GROUP BY G.GroupID
HAVING COUNT(A.GroupID) <= 7;