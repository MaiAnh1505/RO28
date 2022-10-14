DROP DATABASE IF EXISTS Thuc_tap;
CREATE DATABASE Thuc_tap ;

USE Thuc_tap;
-- 1. Tạo table với các ràng buộc và kiểu dữ liệu. Thêm ít nhất 3 bản ghi vào table 

DROP TABLE IF EXISTS `GiangVien`;
CREATE TABLE `GiangVien` (
Magv INT NOT NULL UNIQUE KEY ,
Hoten VARCHAR(30) NOT NULL UNIQUE KEY,
Luong CHAR(20) NOT NULL UNIQUE KEY
);
INSERT INTO `GiangVien` (Magv, Hoten,Luong)
VALUES 
('1234','Lê Văn Hòa','1.200.000vnd'),
('1235','Lê Văn Hòan','9.200.000vnd'),
('1274','Lê Văn Hòang','4.200.000vnd'),
('1254','Lê Văn Ha','1.800.000vnd');


DROP TABLE IF EXISTS `SinhVien`;
CREATE TABLE `SinhVien` (
Masv INT NOT NULL UNIQUE KEY ,
Hoten VARCHAR(30) NOT NULL UNIQUE KEY,
Namsinh DATE NOT NULL UNIQUE KEY,
Quequan VARCHAR(30) NOT NULL UNIQUE KEY
);
INSERT INTO `SinhVien` (Masv, Hoten,Namsinh,Quequan)
VALUES 
('123','Trần VIệt Hoàng','1999-08-04','Hà Nội'),
('133','Trần Hoàng Việt','1989-08-04','Hà Giang'),
('124','Lê VIệt Hoàng','1997-08-07','Hà Nam'),
('183','Trần VIệt Hoà','1998-09-04','Thái Bình'),
('125','Trần VIệt Hoàn','2001-08-04','Nam Định');


DROP TABLE IF EXISTS `DeTai`;
CREATE TABLE `DeTai`(
Madt INT NOT NULL UNIQUE KEY ,
Tendt VARCHAR(30) NOT NULL UNIQUE KEY,
Kinhphi CHAR(20) NULL UNIQUE KEY,
NoiThucTap VARCHAR(30) NOT NULL UNIQUE KEY
);
INSERT INTO `DeTai`  (Madt, Tendt, Kinhphi, NoiThucTap)
VALUES 
('12','sale','2.000.000vnd','Hà Nội'),
('13','data','5.000.000vnd','Bắc Giang'),
('14','Marketing','7.000.000vnd','Hà Nam'),
('15','ads','3.000.000vnd','Huế'),
('16','CONG NGHE SINH HOC','4.000.000vnd','Hòa Bình');


DROP TABLE IF EXISTS `HuongDan`;
CREATE TABLE `HuongDan`(
ID INT NOT NULL UNIQUE KEY ,
Masv INT NOT NULL ,
Madt INT NOT NULL ,
Magv INT NOT NULL,
Ketqua VARCHAR(30) NOT NULL UNIQUE KEY,
FOREIGN KEY (Masv) REFERENCES `SinhVien`(Masv) ON DELETE CASCADE,
FOREIGN KEY (Madt) REFERENCES `DeTai`(Madt) ON DELETE CASCADE,
FOREIGN KEY (Magv) REFERENCES `GiangVien`(Magv) ON DELETE CASCADE
);
 
 
 
-- 2. Viết lệnh để
-- a) Lấy tất cả các sinh viên chưa có đề tài hướng dẫn 
SELECT SV.*
    FROM `HuongDan` HD
	RIGHT JOIN  `SinhVien` SV ON SV.masv=HD.masv
    WHERE HD.madt IS NULL;

-- b) Lấy ra số sinh viên làm đề tài ‘CONG NGHE SINH HOC’ 
SELECT COUNT(HD.Masv) AS SL_SV 
	FROM `HuongDan` HD 
	WHERE Madt=(SELECT Madt FROM `DeTai` WHERE Tendt='CONG NGHE SINH HOC') 
    GROUP BY Madt;


-- 3. Tạo view có tên là "SinhVienInfo" lấy các thông tin về học sinh bao gồm:  mã số, họ tên và tên đề tài 
-- (Nếu sinh viên chưa có đề tài thì column tên đề tài sẽ in ra "Chưa có") 
DROP VIEW IF EXISTS `SinhVienInfo`;
CREATE VIEW `SinhVienInfo` AS
SELECT		SV.MaSV,SV.HoTen,
    CASE WHEN D.TenDT IS NULL 
    THEN 'Chưa Có'
    ELSE D.TenDT END AS Tên_Đề_Tài
FROM		`HuongDan` HD
RIGHT JOIN	`SinhVien` SV ON SV.MaSV=HD.MaSV
LEFT JOIN	`DeTai` D ON D.MaDT = HD.MaDT;


-- 4. Tạo trigger cho table SinhVien khi insert sinh viên có năm sinh <= 1900  thì hiện ra thông báo "năm sinh phải > 1900" 
DROP TRIGGER IF EXISTS NS_SinhVien;
DELIMITER $$
CREATE TRIGGER NS_SinhVien
BEFORE INSERT ON `SinhVien`
FOR EACH ROW
BEGIN
	IF (YEAR( NEW.NamSinh) <= 1900) THEN
	SIGNAL SQLSTATE '45678'
	SET MESSAGE_TEXT = 'Năm Sinh Phải > 1900';
	END IF;
END$$
DELIMITER ;

INSERT INTO `SinhVien`	(HoTen,NamSinh,QueQuan)
VALUES ('Trần Lê Việt',	'1800-05-29','Hà Nội');


-- 5. Hãy cấu hình table sao cho khi xóa 1 sinh viên nào đó thì sẽ tất cả thông  tin trong table HuongDan liên quan tới sinh viên đó sẽ bị xóa đi 
DELETE FROM `SinhVien`
WHERE MaSV = 1;
