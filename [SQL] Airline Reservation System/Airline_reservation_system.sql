
-- Create database called Malaysia_Airline
Create DATABASE Malaysia_Airline

-- Use database Malaysia_Airline
Use Malaysia_Airline

-- Create table airline company
Create TABLE Airline_Company(
Airline_ID varchar(20),
Airline_Name varchar(50) NOT NULL,
Constraint airline_pk PRIMARY KEY(Airline_ID));

-- Create table Customer
Create TABLE Customer(
Customer_ID varchar(20),
First_Name varchar(50) NOT NULL,
Last_Name varchar(50) NOT NULL,
Street varchar(50) NOT NULL,
Postal_Code varchar(5) NOT NULL,
City varchar(20) NOT NULL,
State varchar(20) NOT NULL,
Country varchar(20) NOT NULL,
Constraint customer_pk PRIMARY KEY(Customer_ID));

--create table for pilot
Create TABLE Pilot(
Staff_NO varchar(20),
Airline_ID varchar(20) NOT NULL,
First_Name varchar(50) NOT NULL,
Last_Name varchar(50) NOT NULL,
Year_of_Experience int NOT NULL,
Age int NOT NULL,
Salary int NOT NULL,
Position varchar(50) NOT NULL,
Flying_Hour int NOT NULL,
Constraint pilot_pk PRIMARY KEY(Staff_NO),
Constraint pil_air_fk FOREIGN KEY(Airline_ID) REFERENCES Airline_Company(Airline_ID),
Constraint chk_pos CHECK((Position='Senior Pilot' AND Flying_Hour>=20000)
OR(Position='Pilot'AND Flying_Hour>0 AND Flying_Hour<20000)));

--create table for staff
Create TABLE Flight_Attendant(
Attendant_ID varchar(20),
Airline_ID varchar(20) NOT NULL,
Full_Name varchar(50) NOT NULL,
Position varchar(50) NOT NULL,
Street varchar(50) NOT NULL,
Postal_Code varchar(5) NOT NULL,
City varchar(20) NOT NULL,
State varchar(20) NOT NULL,
Country varchar(20) NOT NULL,
Salary int NOT NULL,
Constraint att_pk PRIMARY KEY(Attendant_ID),
Constraint att_air FOREIGN KEY(Airline_ID) REFERENCES Airline_company(Airline_ID));

--create table for flight
Create TABLE Flight(
Flight_NO varchar(20),
Airline_ID varchar(20) NOT NULL,
Number_of_Total_Seat_in_Economy_Class int NOT NULL,
Number_of_Total_Seat_in_Business_Class int NOT NULL,
Constraint flight_pk PRIMARY KEY(Flight_NO),
Constraint fli_air_fk FOREIGN KEY(Airline_ID) REFERENCES Airline_Company(Airline_ID)
);

--create table for flight booking
Create TABLE Flight_Booking(
Booking_NO varchar(20),
Flight_NO varchar(20) NOT NULL,
Customer_ID varchar(20) NOT NULL,
Booking_State varchar(20) NOT NULL,
Booking_Date date NOT NULL,
Date_of_Arrival date NOT NULL,
Date_of_Departure date NOT NULL,
Time_of_Arrival time(0) NOT NULL,
Time_of_Departure time(0) NOT NULL,
Class_Indicator varchar(20) NOT NULL,
Status_Indicator varchar(20) NOT NULL,
Outstanding_Balance int NOT NULL,
Amount_Paid_so_Far int NOT NULL,
Constraint book_pk PRIMARY KEY(Booking_NO),
Constraint book_fli_fk FOREIGN KEY(Flight_NO) REFERENCES Flight(Flight_NO),
Constraint book_cus_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID));

--create table for phone number(customer)
Create TABLE Customer_Phone_Number(
Customer_ID varchar(20),
Phone_Number varchar(11) DEFAULT 'NONE',
Constraint cus_pho_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID),
Constraint cus_pho_pk PRIMARY KEY(Customer_ID,Phone_Number));

--create table for email_address(customer)
Create TABLE Customer_Email_Address(
Customer_ID varchar(20),
Email_Address varchar(50) DEFAULT 'NONE',
Constraint cus_ema_fk FOREIGN KEY(Customer_ID) REFERENCES Customer(Customer_ID),
Constraint cus_ema_pk PRIMARY KEY(Customer_ID,Email_Address));

--create table for phone number(flight_attendant)
Create TABLE Attendant_Phone_Number(
Attendant_ID varchar(20),
Phone_Number varchar(11),
Constraint att_pho_fk FOREIGN KEY(Attendant_ID) REFERENCES Flight_Attendant(Attendant_ID),
Constraint att_pho_pk PRIMARY KEY(Attendant_ID,Phone_Number));

--create table for pilot and flight
Create TABLE Pilot_Flight(
Staff_NO varchar(20),
Flight_NO varchar(20),
Constraint pilot_fk FOREIGN KEY(Staff_NO) REFERENCES Pilot(Staff_NO),
Constraint pil_flight_fk FOREIGN KEY(Flight_NO) REFERENCES Flight(Flight_NO),
Constraint pilot_flight_pk PRIMARY KEY(Staff_NO,Flight_NO));

--create table for flight_attendant and flight
Create TABLE Flight_Attendant_Flight(
Attendant_ID varchar(20),
Flight_NO varchar(20),
Constraint fliatt_fk FOREIGN KEY(Attendant_ID) REFERENCES Flight_Attendant(Attendant_ID),
Constraint flightatt_flight_fk FOREIGN KEY(Flight_NO) REFERENCES Flight(Flight_NO),
Constraint fliatt_flight_pk PRIMARY KEY(Attendant_ID,Flight_NO));

--insert airline company to table airline_company
INSERT INTO Airline_Company VALUES('EA1709','Echo Airline');
INSERT INTO Airline_Company VALUES('SA1865','Spark Airways');
INSERT INTO Airline_Company VALUES('PA2098','Peak Airways');
INSERT INTO Airline_Company VALUES('CA8760','Core Airways');

--insert random customer
INSERT INTO Customer VALUES('000000001','David','Chan','Jalan Gambir','93000','Kuching','Sarawak','Malaysia');
INSERT INTO Customer VALUES('000000002','Yee Sin','Thean','Jalan Bukit','43000','Kajang','Selangor','Malaysia');
INSERT INTO Customer VALUES('000000003','Richard','Chong','Jalan Satu','92000','Kuching','Sarawak','Malaysia');
INSERT INTO Customer VALUES('000000004','Lebrone','James','Jalan Dua','79000','Petaling Jaya','Selangor','Malaysia');
INSERT INTO Customer VALUES('000000005','Kobi','Bryan','Jalan Tiga','30000','George Town','Penang','Malaysia');
INSERT INTO Customer VALUES('000000006','Thomas','Cruise','Jalan Empat','49000','Ipoh','Perak','Malaysia');
INSERT INTO Customer VALUES('000000007','Johnson','Cena','Jalan Lima','51000','Johor Bahru','Johor','Malaysia');
INSERT INTO Customer VALUES('000000008','Kevin','Durian','Jalan Enam','67000','Kota Kinabalu','Sabah','Malaysia');
INSERT INTO Customer VALUES('000000009','Naruto','Uzumaki','Jalan Tujuh','78900','Konoha Village','Pahang','Malaysia');
INSERT INTO Customer VALUES('000000010','Levi','Ackerman','Jalan Titan','65000','Underground City','Sarawak','Malaysia');

--insert random flight
INSERT INTO Flight VALUES('F000001','EA1709',100,20);
INSERT INTO Flight VALUES('F000002','EA1709',100,30);
INSERT INTO Flight VALUES('F000003','SA1865',90,30);
INSERT INTO Flight VALUES('F000004','SA1865',140,40);
INSERT INTO Flight VALUES('F000005','PA2098',95,32);
INSERT INTO Flight VALUES('F000006','PA2098',100,35);
INSERT INTO Flight VALUES('F000007','CA8760',100,25);
INSERT INTO Flight VALUES('F000008','CA8760',100,35);
INSERT INTO Flight VALUES('F000009','CA8760',90,40);
INSERT INTO Flight VALUES('F000010','SA1865',100,30);

--insert random pilot
INSERT INTO Pilot VALUES('PE0001','EA1709','Jacki','Chan',10,40,45000,'Senior Pilot',39090);
INSERT INTO Pilot VALUES('PE0002','EA1709','Mikael','Tinnason',5,32,20000,'Pilot',12900);
INSERT INTO Pilot VALUES('PE0003','EA1709','William','Smith',20,48,60000,'Senior Pilot',69500);
INSERT INTO Pilot VALUES('PS0001','SA1865','Thomas','Hanks',6,37,35000,'Pilot',18006);
INSERT INTO Pilot VALUES('PS0002','SA1865','John','Depp',1,30,9000,'Pilot',4500);
INSERT INTO Pilot VALUES('PS0003','SA1865','Brad','Pit',2,32,14000,'Pilot',10540);
INSERT INTO Pilot VALUES('PP0001','PA2098','Leonard','DiCaprio',11,43,46000,'Senior Pilot',43880);
INSERT INTO Pilot VALUES('PP0002','PA2098','Morgs','Freeman',7,39,32000,'Senior Pilot',20010);
INSERT INTO Pilot VALUES('PP0003','PA2098','Vegeta','Chan',4,32,20000,'Pilot',15116);
INSERT INTO Pilot VALUES('PC0001','CA8760','Saitama','San',10,43,44000,'Senior Pilot',36590);
INSERT INTO Pilot VALUES('PC0002','CA8760','Yee Shin','Thean',9,40,41000,'Senior Pilot',31088);
INSERT INTO Pilot VALUES('PC0003','CA8760','Mikael','Jordan',2,35,14500,'Pilot',10001);

--insert random flight_attendant
INSERT INTO Flight_Attendant VALUES('E0001','EA1709','Thean Yi Sin','Flight attendant','Jalan Merah','81000','Putrajaya','Selangor','Malaysia',2800)
INSERT INTO Flight_Attendant VALUES('E0002','EA1709','Bhvan Jit Singh','Flight attendant','Jalan Biru','39000','Kuching','Sarawak','Malaysia',3500)
INSERT INTO Flight_Attendant VALUES('E0003','EA1709','Naimur Rahman','Flight purser','Jalan Hijau','47000','Johor Bahru','Johor','Malaysia',5500)
INSERT INTO Flight_Attendant VALUES('E0004','EA1709','Bilaal Frost','Flight stewardess','Jalan Sembilan','81000','Kota Bharu','Kelantan','Malaysia',8500)
INSERT INTO Flight_Attendant VALUES('S0001','SA1865','Colton Weston','Flight steward','Jalan Kucing','33000','Kucing Town','Perak','Malaysia',2800)
INSERT INTO Flight_Attendant VALUES('S0002','SA1865','Aiden Wiley','Flight purser','Jalan Hitam','77600','Hitam','Terengganu','Malaysia',8000)
INSERT INTO Flight_Attendant VALUES('S0003','SA1865','Dion Byrne','Flight purser','Jalan Penyu','94000','Turtle Island','Terengganu','Malaysia',3500)
INSERT INTO Flight_Attendant VALUES('S0004','SA1865','Myles Truong','Flight attendant','Jalan Ayam','13000','Chicken','Penang','Malaysia',12000)
INSERT INTO Flight_Attendant VALUES('P0001','PA2098','Steve Alston','Flight attendant','Jalan Gunung','51000','Kota Kinabulu','Sabah','Malaysia',7500)
INSERT INTO Flight_Attendant VALUES('P0002','PA2098','Teddy Dixon','Flight stewardess','Jalan Epal','90000','Kajang','Selangor','Malaysia',8000)
INSERT INTO Flight_Attendant VALUES('P0003','PA2098','Shea Bray','Flight purser','Jalan Masa','77700','Sandakan','Sabah','Malaysia',7600)
INSERT INTO Flight_Attendant VALUES('P0004','PA2098','Elly Harris','Flight purser','Jalan Monyet','88000','Kluang','Johor','Malaysia',9900)
INSERT INTO Flight_Attendant VALUES('C0001','CA8760','Scarlett Johansson','Flight stewardess','Jalan Syurga','90900','Batu Gajah','Perak','Malaysia',7000)
INSERT INTO Flight_Attendant VALUES('C0002','CA8760','Angelina Jolie','Flight stewardess','Jalan Burung','23000','Serian','Sarawak','Malaysia',2800)
INSERT INTO Flight_Attendant VALUES('C0003','CA8760','Ariana Grande','Flight attendant','Jalan Lembu','45000','Nilai','Negeri Sembilan','Malaysia',4600)
INSERT INTO Flight_Attendant VALUES('C0004','CA8760','Justin Bieber','Flight purser','Jalan Sedih','84000','Maur','Johor','Malaysia',5400)

--add random email address to the customer
INSERT INTO Customer_Email_Address VALUES('000000001','Davidchan@gmail.com');
INSERT INTO Customer_Email_Address VALUES('000000002','yeesin69@gmail.com');
INSERT INTO Customer_Email_Address(Customer_ID) VALUES('000000003');
INSERT INTO Customer_Email_Address VALUES('000000004','LBjames@hotmail.com');
INSERT INTO Customer_Email_Address VALUES('000000005','KobiBryanxx@gmail.com');
INSERT INTO Customer_Email_Address VALUES('000000006','itsmeThomasCruise@hotmail.com');
INSERT INTO Customer_Email_Address VALUES('000000007','JohnsonCena0908@gmail.com');
INSERT INTO Customer_Email_Address VALUES('000000008','KD991020@gmail.com');
INSERT INTO Customer_Email_Address VALUES('000000009','NarutoUzumaki@hotmail.com');
INSERT INTO Customer_Email_Address VALUES('000000010','AttackonLevi@gmail.com');

--add random phone number for the customer
INSERT INTO Customer_Phone_Number VALUES('000000001','01143437879');
INSERT INTO Customer_Phone_Number VALUES('000000002','0123456789');
INSERT INTO Customer_Phone_Number VALUES('000000003','0193216784');
INSERT INTO Customer_Phone_Number(Customer_ID) VALUES('000000004');
INSERT INTO Customer_Phone_Number VALUES('000000005','0162237476');
INSERT INTO Customer_Phone_Number VALUES('000000006','0175342654');
INSERT INTO Customer_Phone_Number VALUES('000000007','0124839143');
INSERT INTO Customer_Phone_Number(Customer_ID) VALUES('000000008');
INSERT INTO Customer_Phone_Number VALUES('000000009','0173273292');
INSERT INTO Customer_Phone_Number VALUES('000000010','01155956383');

--add the phone number to every flight_attendant
INSERT INTO Attendant_Phone_Number VALUES('E0001','0135475493');
INSERT INTO Attendant_Phone_Number VALUES('E0002','01199334243');
INSERT INTO Attendant_Phone_Number VALUES('E0003','0167384724');
INSERT INTO Attendant_Phone_Number VALUES('E0004','0184254123');
INSERT INTO Attendant_Phone_Number VALUES('S0001','01156352246');
INSERT INTO Attendant_Phone_Number VALUES('S0002','0185673535');
INSERT INTO Attendant_Phone_Number VALUES('S0003','0195437563');
INSERT INTO Attendant_Phone_Number VALUES('S0004','0127473824');
INSERT INTO Attendant_Phone_Number VALUES('P0001','0127578295');
INSERT INTO Attendant_Phone_Number VALUES('P0002','01173728425');
INSERT INTO Attendant_Phone_Number VALUES('P0003','0167385724');
INSERT INTO Attendant_Phone_Number VALUES('P0004','0196372857');
INSERT INTO Attendant_Phone_Number VALUES('C0001','0197372741');
INSERT INTO Attendant_Phone_Number VALUES('C0002','0135725835');
INSERT INTO Attendant_Phone_Number VALUES('C0003','0187636123');
INSERT INTO Attendant_Phone_Number VALUES('C0004','0151231568');

--add flight booking for the customer
INSERT INTO Flight_Booking VALUES('BF0000001','F000001','000000001','Sarawak','2021-01-01','2021-03-01','2021-02-28','04:30:00','21:30:00','Economy','Booked',0,1600);
INSERT INTO Flight_Booking VALUES('BF0000002','F000001','000000003','Sarawak','2021-01-02','2021-03-01','2021-02-28','04:30:00','21:30:00','Business','Booked',0,2000);
INSERT INTO Flight_Booking VALUES('BF0000003','F000001','000000010','Sarawak','2021-01-15','2021-03-01','2021-02-28','04:30:00','21:30:00','Business','Canceled',0,0);
INSERT INTO Flight_Booking VALUES('BF0000004','F000002','000000001','Sarawak','2020-10-15','2020-12-16','2021-12-16','19:00:00','14:00:00','Economy','Scratched',0,0);
INSERT INTO Flight_Booking VALUES('BF0000005','F000003','000000002','Selangor','2021-01-01','2021-02-16','2021-02-15','07:00:00','21:00:00','Business','Booked',0,5000);
INSERT INTO Flight_Booking VALUES('BF0000006','F000004','000000004','Selangor','2021-01-11','2021-02-21','2021-02-20','12:00:00','21:00:00','Economy','Booked',0,5500);
INSERT INTO Flight_Booking VALUES('BF0000007','F000005','000000009','Pahang','2021-01-06','2021-02-27','2021-02-27','12:30:00','06:30:00','Business','Canceled',0,0);
INSERT INTO Flight_Booking VALUES('BF0000008','F000006','000000009','Pahang','2021-01-10','2021-03-10','2021-03-10','13:00:00','07:00:00','Business','Scratched',0,0);
INSERT INTO Flight_Booking VALUES('BF0000009','F000007','000000007','Johor','2021-03-01','2021-04-15','2021-04-14','04:00:00','20:00:00','Economy','Booked',3000,0);
INSERT INTO Flight_Booking VALUES('BF0000010','F000007','000000003','Selangor','2021-03-04','2021-04-15','2021-04-14','04:00:00','20:00:00','Business','Booked',3500,0);
INSERT INTO Flight_Booking VALUES('BF0000011','F000008','000000004','Selangor','2021-02-28','2021-04-01','2021-04-01','16:30:00','10:00:00','Business','Canceled',0,0);
INSERT INTO Flight_Booking VALUES('BF0000012','F000009','000000004','Selangor','2021-03-06','2021-04-21','2021-04-21','13:45:00','09:00:00','Economy','Booked',2000,0);
INSERT INTO Flight_Booking VALUES('BF0000013','F000010','000000006','Perak','2021-03-03','2021-05-01','2021-05-01','17:50:00','12:00:00','Business','Canceled',0,0);

--add pilot to the flight
INSERT INTO Pilot_Flight VALUES('PE0001','F000001');
INSERT INTO Pilot_Flight VALUES('PE0002','F000001');
INSERT INTO Pilot_Flight VALUES('PE0001','F000002');
INSERT INTO Pilot_Flight VALUES('PE0003','F000002');
INSERT INTO Pilot_Flight VALUES('PS0002','F000003');
INSERT INTO Pilot_Flight VALUES('PS0003','F000003');
INSERT INTO Pilot_Flight VALUES('PS0001','F000004');
INSERT INTO Pilot_Flight VALUES('PS0003','F000004');
INSERT INTO Pilot_Flight VALUES('PP0001','F000005');
INSERT INTO Pilot_Flight VALUES('PP0002','F000005');
INSERT INTO Pilot_Flight VALUES('PP0002','F000006');
INSERT INTO Pilot_Flight VALUES('PP0003','F000006');
INSERT INTO Pilot_Flight VALUES('PC0001','F000007');
INSERT INTO Pilot_Flight VALUES('PC0003','F000007');
INSERT INTO Pilot_Flight VALUES('PC0002','F000008');
INSERT INTO Pilot_Flight VALUES('PC0003','F000008');
INSERT INTO Pilot_Flight VALUES('PC0001','F000009');
INSERT INTO Pilot_Flight VALUES('PC0002','F000009');
INSERT INTO Pilot_Flight VALUES('PS0001','F000010');
INSERT INTO Pilot_Flight VALUES('PS0002','F000010');

--add the flight_attendant to the flight
INSERT INTO Flight_Attendant_Flight VALUES('E0001','F000001');
INSERT INTO Flight_Attendant_Flight VALUES('E0002','F000001');
INSERT INTO Flight_Attendant_Flight VALUES('E0003','F000001');
INSERT INTO Flight_Attendant_Flight VALUES('E0003','F000002');
INSERT INTO Flight_Attendant_Flight VALUES('E0004','F000002');
INSERT INTO Flight_Attendant_Flight VALUES('S0001','F000003');
INSERT INTO Flight_Attendant_Flight VALUES('S0003','F000003');
INSERT INTO Flight_Attendant_Flight VALUES('S0002','F000004');
INSERT INTO Flight_Attendant_Flight VALUES('S0003','F000004');
INSERT INTO Flight_Attendant_Flight VALUES('S0004','F000004');
INSERT INTO Flight_Attendant_Flight VALUES('P0002','F000005');
INSERT INTO Flight_Attendant_Flight VALUES('P0003','F000005');
INSERT INTO Flight_Attendant_Flight VALUES('P0001','F000006');
INSERT INTO Flight_Attendant_Flight VALUES('P0003','F000006');
INSERT INTO Flight_Attendant_Flight VALUES('P0004','F000006');
INSERT INTO Flight_Attendant_Flight VALUES('C0001','F000007');
INSERT INTO Flight_Attendant_Flight VALUES('C0002','F000007');
INSERT INTO Flight_Attendant_Flight VALUES('C0003','F000007');
INSERT INTO Flight_Attendant_Flight VALUES('C0001','F000008');
INSERT INTO Flight_Attendant_Flight VALUES('C0002','F000008');
INSERT INTO Flight_Attendant_Flight VALUES('C0004','F000008');
INSERT INTO Flight_Attendant_Flight VALUES('C0001','F000009');
INSERT INTO Flight_Attendant_Flight VALUES('C0003','F000009');
INSERT INTO Flight_Attendant_Flight VALUES('C0004','F000009');
INSERT INTO Flight_Attendant_Flight VALUES('S0002','F000010');
INSERT INTO Flight_Attendant_Flight VALUES('S0003','F000010');
INSERT INTO Flight_Attendant_Flight VALUES('S0004','F000010');

--Add age to the pilot
UPDATE Pilot
Set Age=Age-1,Year_of_Experience = Year_of_Experience -1;
