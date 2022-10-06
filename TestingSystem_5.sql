USE Testing_System_Assignement_1;

-- 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
WITH NV_Sale AS
(
SELECT A.*, D.DepartmentName
FROM account A
INNER JOIN department D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale'
)
SELECT * FROM NV_Sale;

-- 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
WITH CTE_DSNV_Sale AS
(
SELECT count(GA1.AccountID) AS countGA1 FROM groupaccount GA1
GROUP BY GA1.AccountID
)
SELECT A.AccountID, A.Username, count(GA.AccountID) AS SL
FROM groupaccount GA
INNER JOIN account A ON GA.AccountID = A.AccountID
GROUP BY GA.AccountID
HAVING count(GA.AccountID) = (SELECT MAX(countGA1) AS maxCount FROM CTE_DSNV_Sale);

-- 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
-- b1 tạo view 
CREATE OR REPLACE VIEW vw_ContenTren18Tu AS 
SELECT *FROM Question
WHERE LENGTH(Content) > 18;
-- B2 view vừa tạo 
SELECT *FROM vw_ContenTren18Tu;
-- b3 xóa (lỗi )
DELETE FROM vw_ContenTren18Tu;

-- 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

-- 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
WITH ho_nguyen AS
(
SELECT Q.CategoryID, Q.Content, A.FullName AS Creator 
FROM Question Q
INNER JOIN `account` A ON A.AccountID = Q.CreatorID
WHERE SUBSTRING_INDEX( A.FullName, ' ', 1 ) = 'Nguyễn'
)
SELECT * FROM ho_nguyen;


