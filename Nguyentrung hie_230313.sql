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

-- truy vân
-- câu 1
select sv.masv "Mã SV", sv.hoten "Họ Tên", sv.malop "Mã Lớp", d.diemhp "Điểm HP", d.mahp "Mã HP" from sinhvien sv
 join diemhp d on sv.masv = d.masv where d.diemhp >=5;
 -- câu 2
 select sv.masv "Mã SV", sv.hoten "Họ Tên", sv.malop "Mã Lớp", d.diemhp "Điểm HP", d.mahp "Mã HP" from sinhvien sv
 join diemhp d on sv.masv = d.masv order by sv.malop asc, sv.hoten asc;
 -- câu 3
 select sv.masv "Mã SV" ,sv.hoten "Họ Tên", sv.malop "Mã Lớp", d.diemhp "Điểm HP", hocky "Học Kỳ"  from sinhvien sv
 join diemhp d on sv.masv = d.masv join dmhocphan hp on d.mahp = hp.mahp where (d.diemhp between 5 and 7) and hocky = 1;
 -- câu 4
  select sv.masv, sv.hoten,sv.malop,l.tenlop,n.makhoa  from sinhvien sv 
 join dmlop l on sv.malop = l.malop join dmnganh n on l.manganh = n.manganh join dmkhoa k on n.makhoa = k.makhoa
 where n.makhoa = "CNTT";
 
 -- câu 5
 select sv.malop,l.tenlop, count(sv.masv) "SiSo"from sinhvien sv join dmlop l on l.malop = sv.malop group by sv.malop ;
 
 -- câu 6
 select masv, dmhocphan.hocky, sum(diemhp * dmhocphan.sodvht) / sum(dmhocphan.sodvht) as DiemTBC from diemhp
join dmhocphan on diemhp.mahp = dmhocphan.mahp
group by masv, dmhocphan.hocky;

-- câu 7
select  
sv.malop,l.tenlop,
case
	when sv.gioitinh = 0 then 'nam'
    when sv.gioitinh = 1 then 'nu'
end as 'giới tính', count(sv.masv) "soluong"
from dmlop l join sinhvien sv on sv.malop = l.malop group by sv.malop, sv.gioitinh;

-- câu 8
select 
    sinhvien.masv,
    sinhvien.hoten,
    (sum(diemhp.diemhp * dmhocphan.sodvht) / sum(dmhocphan.sodvht)) as DiemTBC
from sinhvien join diemhp on sinhvien.masv = diemhp.masv
join dmhocphan on diemhp.mahp = dmhocphan.mahp
where dmhocphan.hocky = 1
group by sinhvien.masv, sinhvien.hoten;

-- câu 9
select 
    sinhvien.masv,
    sinhvien.hoten,
    count(diemhp.mahp) as SoHocPhanThieuDiem
from sinhvien join diemhp on sinhvien.masv = diemhp.masv
where diemhp.diemhp < 5
group by sinhvien.masv, sinhvien.hoten;
 -- câu 10 
  select 
    diemhp.mahp,
    count(diemhp.masv) as sl_sv_thieu
from sinhvien join diemhp on sinhvien.masv = diemhp.masv where diemhp.diemhp < 5
group by diemhp.mahp;
-- câu 11
select 
    sinhvien.masv,
    sinhvien.hoten,
    sum(diemhp.diemhp) as tongdvht
from sinhvien join diemhp on sinhvien.masv = diemhp.masv
where diemhp.diemhp < 5
group by sinhvien.masv, sinhvien.hoten;
