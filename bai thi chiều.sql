create database HACKATHON_06;
use HACKATHON_06;
create table dmkhoa(
makhoa varchar(20) primary key,
tenkhoa varchar(255) 
);

create table dmnganh(
manganh int primary key,
tennganh varchar(255),
makhoa varchar(20),
foreign key (makhoa) references dmkhoa(makhoa)
);

create table dmlop(
malop  varchar(20) primary key,
tenlop varchar(255),
manganh int,
khoahoc int,
hedt varchar(255),
namnhaphoc int,
foreign key(manganh) references dmnganh(manganh)
);

create table dmhocphan(
mahp int primary key,
tenhp varchar(255),
sodvht int ,
manganh int, 
hocky int,
foreign key(manganh) references dmnganh(manganh)
);
create table sinhvien(
masv int primary key,
hoten varchar(255),
malop varchar(20),
gioitinh tinyint(1),
ngaysinh date,
diachi varchar(255),
foreign key (malop) references dmlop(malop)
);

create table diemhp(
masv int,
mahp int,
diemhp float,
foreign key (masv) references sinhvien(masv),
foreign key (mahp) references dmhocphan(mahp)
);
-- Thêm dữ liệu vào các bảng như sau:
insert into dmkhoa(makhoa,tenkhoa) values
("CNTT","Công Nghệ Thông Tin"),
("KT","Kế Toán"),
("SP","Sư Phạm");

insert into dmnganh(manganh,tennganh,makhoa) values
(140902,"Sư Phạm Toán Tin","SP"),
(480202,"Tin Học Ứng Dụng","CNTT");

insert into dmlop() values
("CT11","Cao Đẳng Tin Học",480202,11,"TC",2013),
("CT12","Cao Đẳng Tin Học",480202,12,"CĐ",2013),
("CT13","Cao Đẳng Tin Học",480202,13,"TC",2014);

insert into dmhocphan() values
(1,"Toán Cao cấp A1",4,480202,1),
(2,"Tiếng Anh 1",3,480202,1),
(3,"Vật Lý Đại Cương",4,480202,1),
(4,"Tiếng Anh 2",7,480202,1),
(5,"Tiếng Anh 1",3,480202,1),
(6,"Xác Suất Thống Kê",3,480202,1);

insert into sinhvien() values
(1,"Phan Thanh","CT12",0,"1990-09-12","Tuy Phước"),
(2,"Nguyến Thị Cẩm","CT12",1,"1994-01-12","Quy Nhơn"),
(3,"Võ Thị Hà","CT12",1,"1995-07-02","An Nhơn"),
(4,"Trần Hoài Nam","CT12",0,"1994-04-05","Tây Sơn"),
(5,"Trần Văn Hoàng","CT13",0,"1995-08-04","Vĩnh Thạnh"),
(6,"Đặng Thị Thảo","CT13",1,"1995-06-12","Quy Nhơn"),
(7,"Lê Thị Sen","CT13",1,"1994-08-12","Phủ Mỹ"),
(8,"Nguyễn Văn Huy","CT11",0,"1995-06-04","Tuy Phước"),
(9,"Trần Thị Hoa","CT11",1,"1994-08-09","Hoài Nhơn");
insert into diemhp() values 
(2,2,5.9),(2,3,4.5),(3,1,4.3),(3,2,6.7),(3,3,7.3),
(4,1,4),(4,2,5.2),(4,3,3.5),(5,1,9.8),(5,2,7.9),
(5,3,7.5),(6,1,6.1),(6,2,5.6),(6,3,4),(7,1,6.2);



-- 1. Cho biết họ tên sinh viên KHÔNG học học phần nào (5đ)
select sv.masv, sv.hoten from sinhvien sv left join diemhp d on sv.masv = d.masv where d.diemhp is null;
-- 2.Cho biết họ tên sinh viên CHƯA học học phần nào có mã 1 (5đ)
select sv.masv, sv.hoten from sinhvien sv left join diemhp d on sv.masv = d.masv and d.mahp =1 where d.diemhp is null ;
-- 3.Cho biết Tên học phần KHÔNG có sinh viên điểm HP <5. (5đ)
select hp.mahp,hp.tenhp from diemhp d right join dmhocphan hp on d.mahp = hp.mahp and d.diemhp <5 where d.masv is null;
-- 4.Cho biết Họ tên sinh viên KHÔNG có học phần điểm HP<5 (5đ)
select sv.masv, sv.hoten from diemhp d right join sinhvien sv on d.masv = sv.masv and d.diemhp <5 where d.masv is null;
-- 5.Cho biết Tên lớp có sinh viên tên Hoa (5đ)
select lop.tenlop from sinhvien join dmlop lop on sinhvien.malop = lop.malop where sinhvien.hoten like ("%Hoa");
-- 6.Cho biết HoTen sinh viên có điểm học phần 1 là <5.
select sv.hoten from sinhvien sv join diemhp d on sv.masv = d.masv where d.mahp = 1 and d.diemhp < 5;
-- 7.Cho biết danh sách các học phần có số đơn vị học trình lớn hơn hoặc bằng số đơn vị học trình của học phần mã 1.
select mahp,tenhp,sodvht from dmhocphan
where sodvht >= (select sodvht from dmhocphan where mahp = 1);
-- 8.Cho biết HoTen sinh viên có DiemHP cao nhất. 
select sinhvien.hoten,  diemhp.mahp, diemhp.diemhp from sinhvien join diemhp on sinhvien.masv = diemhp.masv
where diemhp.diemhp >= ALL (select diemhp from diemhp);
-- 9 Cho biết MaSV, HoTen sinh viên có điểm học phần mã 1 cao nhất.
select sinhvien.hoten from sinhvien join diemhp ON sinhvien.masv = diemhp.masv
where diemhp.diemhp >= ALL (select diemhp from diemhp where diemhp.mahp =1);
-- 10.Cho biết MaSV, MaHP có điểm HP lớn hơn bất kì các điểm HP của sinh viên mã 3 (ANY).
select diemhp.masv,diemhp.mahp from  diemhp
where diemhp.diemhp >= ANY (select diemhp from diemhp where diemhp.masv =3);
-- 11.Cho biết MaSV, HoTen sinh viên ít nhất một lần học học phần nào đó. (EXISTS)
select sv.masv,sv.hoten from sinhvien sv where
EXISTS (select 1 from diemhp where diemhp.masv = sv.masv);
-- 12.Cho biết MaSV, HoTen sinh viên đã không học học phần nào. (EXISTS)
 select sv.masv,sv.hoten from sinhvien sv where
not EXISTS (select 1 from diemhp where diemhp.masv = sv.masv);
-- 13.Cho biết MaSV đã học ít nhất một trong hai học phần có mã 1, 2. 
(select d.masv from diemhp d where d.mahp =1)
UNION 
(select d.masv from diemhp d where d.mahp =2);
-- 14.Tạo thủ tục có tên KIEM_TRA_LOP cho biết HoTen sinh viên KHÔNG có điểm HP <5 ở lớp có mã chỉ định (tức là tham số truyền vào procedure là mã lớp).
-- Phải kiểm tra MaLop chỉ định có trong danh mục hay không, nếu không thì hiển thị thông báo ‘Lớp này không có trong danh mục’. Khi lớp tồn tại thì đưa ra kết quả.
-- Ví dụ gọi thủ tục: Call KIEM_TRA_LOP(‘CT12’).
delimiter //
create procedure KIEM_TRA_LOP(malop varchar(20))
begin
if not exists (select 1 from dmlop where dmlop.malop = malop ) then select "Lớp này không có trong danh mục"  as message;
else 
select sv.hoten from sinhvien sv join diemhp on diemhp.masv = sv.masv where sv.malop = malop  and not diemhp.diemhp < 5 ;
 end if;
end ;
// delimiter ;
Call KIEM_TRA_LOP("CT12")
-- 15.Tạo một trigger để kiểm tra tính hợp lệ của dữ liệu nhập vào bảng sinhvien là MaSV không được rỗng  Nếu rỗng hiển thị thông báo ‘Mã sinh viên phải được nhập’.
delimiter //
create trigger check_masv_not_null
before insert on sinhvien
for each row
begin
if new.masv is null or new.masv = "" then 
  SIGNAL SQLSTATE '45000'
  set message_text = "Mã sinh viên phải được nhập" ;
end if ;
end ;
// delimiter ;
-- 16.Tạo một TRIGGER khi thêm một sinh viên trong bảng sinhvien ở một lớp nào đó thì cột SiSo của lớp đó trong bảng dmlop 
-- (các bạn tạo thêm một cột SiSo trong bảng dmlop) tự động tăng lên 1, 
-- đảm bảo tính toàn vẹn dữ liệu khi thêm một sinh viên mới trong bảng sinhvien thì sinh viên đó phải có mã lớp trong bảng dmlop.
--  Đảm bảo tính toàn vẹn dữ liệu khi thêm là mã lớp phải có trong bảng dmlop.


 
-- 17.Viết một function DOC_DIEM đọc điểm chữ số thập phân thành chữ  Sau đó ứng dụng để lấy ra MaSV, HoTen, MaHP, DiemHP, DOC_DIEM(DiemHP) 
-- để đọc điểm HP của sinh viên đó thành chữ
DELIMITER //

CREATE FUNCTION doc_diem(diemhp FLOAT) RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
    DECLARE docdiem VARCHAR(255);
    DECLARE integer_part INT;
    DECLARE decimal_part INT;

    SET integer_part = FLOOR(diemhp);
    SET decimal_part = ROUND((diemhp - integer_part) * 10);

    SET docdiem =
        CASE
            WHEN integer_part = 10 THEN 'mười'
            ELSE CASE integer_part
                WHEN 9 THEN 'chín'
                WHEN 8 THEN 'tám'
                WHEN 7 THEN 'bảy'
                WHEN 6 THEN 'sáu'
                WHEN 5 THEN 'năm'
                WHEN 4 THEN 'bốn'
                WHEN 3 THEN 'ba'
                WHEN 2 THEN 'hai'
                WHEN 1 THEN 'một'
                ELSE ''
            END
        END;

    IF integer_part >= 0 AND integer_part <= 10 THEN
        SET docdiem = CONCAT(docdiem, ' phẩy ');
        
        IF decimal_part = 0 THEN
            SET docdiem = CONCAT(docdiem, 'không');
        ELSE
            SET docdiem =
                CASE decimal_part
                    WHEN 9 THEN CONCAT(docdiem, 'chín')
                    WHEN 8 THEN CONCAT(docdiem, 'tám')
                    WHEN 7 THEN CONCAT(docdiem, 'bảy')
                    WHEN 6 THEN CONCAT(docdiem, 'sáu')
                    WHEN 5 THEN CONCAT(docdiem, 'lăm')
                    WHEN 4 THEN CONCAT(docdiem, 'bốn')
                    WHEN 3 THEN CONCAT(docdiem, 'ba')
                    WHEN 2 THEN CONCAT(docdiem, 'hai')
                    WHEN 1 THEN CONCAT(docdiem, 'một')
                    ELSE ''
                END;
        END IF;
    END IF;

    RETURN docdiem;
END;
//

DELIMITER ;

SELECT
    sv.masv AS "Mã SV",
    sv.hoten AS "Tên SV",
    d.mahp AS "Mã HP",
    d.diemhp AS "Điểm HP",
    doc_diem(d.diemhp) AS "Điểm Chữ"
FROM
    sinhvien sv
join
    diemhp d ON sv.masv = d.masv;

DELIMITER //

-- 18 


-- 19
CREATE PROCEDURE HIEN_THI_MAHP(IN mahp INT)
BEGIN
    -- Kiểm tra học phần có tồn tại trong danh mục hay không
    IF NOT EXISTS (SELECT 1 FROM dmhocphan WHERE dmhocphan.mahp = mahp) THEN
        SELECT 'Không có học phần này' AS message;
    ELSE
        -- Hiển thị tên sinh viên CHƯA học học phần có mã chỉ định
        SELECT 
            sinhvien.hoten
        FROM 
            sinhvien
        WHERE 
            sinhvien.masv NOT IN 
                (SELECT diemhp.masv FROM diemhp WHERE diemhp.mahp = mahp);
    END IF;
END //

DELIMITER ;
CALL HIEN_THI_MAHP(1);
