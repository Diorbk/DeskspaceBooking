----------------------------
create schema if not exists `co-working-space` default character set utf8 ;
use `co-working-space` ;


-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- table `co-working-space`.`Site`
create table if not exists `co-working-space`.`Site` (
  `SiteID` int not null auto_increment,
  `SiteName` varchar(45) null,
  `DeskCapacity` int not null,
  `MeetingRoomCapacity` int not null,
  `Address1` varchar(45) not null,
  `Address2` varchar(45) not null,
  `Postcode` varchar(45) not null,
  primary key (`SiteID`));
  


-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- table `co-working-space`.`Desk`
create table if not exists `co-working-space`.`Desk` (
  `SiteID` int not null,
  `DeskID` int not null auto_increment,
	primary key (`DeskID`),
    foreign key (`SiteID`)
    references `co-working-space`.`Site` (`SiteID`));


  
create table if not exists `co-working-space`.`CustomerType` (
  `CustomerTypeID` int not null auto_increment,
  `TypeName` varchar(45) not null,
  `Price` int not null,
	primary key (`CustomerTypeID`));



-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- table `co-working-space`.`Customer`
create table if not exists `co-working-space`.`Customer` (
  `CustomerID` int not null auto_increment,
  `Forename` varchar(45) not null,
  `Surname` varchar(45) not null,
  `Email` varchar(45) not null,
  `PhoneNumber` int not null,
  `CustomerTypeID` int not null,
  `BeverageSubscription` tinyint not null,
primary key (`CustomerID`),
foreign key (`CustomerTypeID`)
references `co-working-space`.`CustomerType` (`CustomerTypeID`));
    
-- beverage subscription 1 = the member has a subscription 
-- beverage subscription 0 = the member doesnt have a subscription



-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- table `co-working-space`.`Booking`
create table if not exists `co-working-space`.`Booking` (
  `BookingID` int not null auto_increment,
  `CustomerID` int not null,
  `DeskID` int not null,
  `StartDate` date not null,
  `EndDate` date not null,
  primary key (`BookingID`),
    foreign key (`CustomerID`)
    references `co-working-space`.`Customer` (`CustomerID`));



-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- table `co-working`.`MeetingRoom`
create table if not exists `co-working-space`.`MeetingRoom` (
  `SiteID` int not null auto_increment,
  `MeetingRoomID` int not null,
  `MeetingRoomName` varchar(45) not null,
  primary key (`MeetingRoomID`),
  constraint `rooms for meeting`
    foreign key (`SiteID`)
    references `co-working-space`.`Site` (`SiteID`));



-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- table `co-working`.`MeetingRoomBooking`
create table if not exists `co-working-space`.`MeetingRoomBooking` (
  `CustomerID` int not null auto_increment,
  `Date` date not null,
  `StartTime` time not null,
  `EndTime` time not null,
  `MeetingRoomID` int not null,
  foreign key(`CustomerID`)
  references `co-working-space`.`Customer`(`CustomerID`),
    foreign key (`MeetingRoomID`)
    references `co-working-space`.`MeetingRoom` (`MeetingRoomID`));


-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- Populating the table with sample data

 insert into CustomerType
 values
 (1,"part-time",120),
 (2,"full-time",250),
 (3,"daily-rate",20);
 
insert into Site
values
(1,"northwestcardiff",45,2,"12 groove street","Cardiff","W5 2AE"),
(2,"northcardiff",30,2,"12 groove street","Cardiff","W5 2AE");

insert into Customer ()
values 
(1,"jason","pinnock","ffff@tuta.io",00,2,1),
(2,"latifa", "dembol","gggg@gmail.com",11,1,0),
(3,"jack","richards","hhhh@outlook.com",22,1,0),
(4,"samuel","atkins","jjjj@yahoo.com",33,1,0),
(5,"saira","noordin","kkkk@protonmail.com",44,2,1),
(6,"tamin","alzar","llll@gmail.com",55,2,1),
(7,"jayden","landa","aaaa@outlook.com",66,2,1);

insert into desk(SiteID)
values 
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),

(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),(2),
(2),(2),(2),(2),(2),(2),(2); 

 insert into MeetingRoom
 values 
 (1,1,"Tvernic room"),
 (1,2,"Botvinik room"),
 (2,3,"Staford room"),
 (2,4,"Queens room");
 

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- Procedure for desk booking
delimiter // 
//
create procedure `MakeBooking` (
in CustomerID int, DeskID int, StartDate date, EndDate date
)
begin 
	start transaction; 
		insert into Booking
        (CustomerID,DeskID,StartDate,EndDate)
		values 
        (CustomerID,DeskID,StartDate,EndDate);
        commit;
end//
delimiter ;

-- <<<<<<<<<<<<<<<
-- tests
select * from Booking;
-- this will show all the bookings that have been made

call MakeBooking (4,6,20220512,20220512);
-- this will make a booking for the customerID of 4 for the deskID of 6 for 1 day in 12th of may

call MakeBooking (1,2,20220601,20220603);
-- this will make a booking for the customerID of 1 for the deskID of 2 for 3 days from

select * from Booking where CustomerID = 2;
-- this will show the bookings that is in the row for the CustomerID of 2


-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- Procedure for adding customer
delimiter //
//
create procedure `addCustomer` (
in Forename varchar(45), Surname varchar(45), Email varchar(45), PhoneNumber int, CustomerTypeID int,
BeverageSubscription tinyint
)
begin 
declare exit handler for 1062
begin
	select "can't add a user that already exists.";
    rollback;
end;
	start transaction; 
		insert into Customer
        (Forename,Surname,Email,PhoneNumber,CustomerTypeID,BeverageSubscription)
		values 
        (Forename,Surname,Email,PhoneNumber,CustomerTypeID,BeverageSubscription);
        commit;
end//
delimiter ;

-- <<<<<<<<<<<<
-- tests
select * from Customer;
-- this will display all the customers that are in the table 

call addCustomer ("Diyorbek", "Sanaqulov", "qqqq@tuta.com",076,2,1);
-- this will create a new user with the name of darragh smith and give him a unique userid 

select * from Customer where CustomerID = 8;
-- this will return all the users with the userid of 8

select * from Customer ;
-- this will show that the new user has been added


-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- Procedure to add and remove beverage subscription
delimiter ££
££
	create procedure `MaintainSubscriptions`(
	in InputID int, answer int	
	)
	begin 
		start transaction;
			if answer = 0 then
				update Customer
				set BeverageSubscription = 0
				where CustomerID = InputID;
			else if answer = 1 then
				update Customer
				set BeverageSubscription = 1
				where CustomerID = InputID;
			else
				select "please enter a valid input (1-0)";
			end if;
          end if;
        commit;
    end ££
    delimiter ;

  
-- <<<<<<<<<<
-- tests 
select * from Customer where CustomerID = 4;
-- this will return all members that have an id of 7 

 call MaintainSubscriptions (4,0) ;
 -- this will update all the rows which consist of a userid of 4 with no beverage subscription
		
select * from Customer where CustomerID = 4;
-- this will show that customer 7 now has a beverage subscription 


-- <<<<<<<<<<<<<<<<<<<<
-- tests - must fail
select * from Customer where CustomerTypeID = "1";
-- this again will present all part time users

select * from Customer where CustomerID = 44;
-- this will show no customer as there is no customer with id of 44


-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- Procedure to change customer Type
delimiter >>
>>
create procedure `ChangeToFullTimeMember` (
in UserInputID int
)
begin 
start transaction;
update Customer
set CustomerTypeID = 2
where UserInputID = CustomerID ;
commit;
end >>
delimiter ; 

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- tests
select * from CustomerType;
-- this will show all customer Types

select * from Customer where CustomerTypeID = 2;
-- this will show all the rows in the customers table that are full-time members

call ChangeToFullTimeMember (2);
-- this will change the customer to full-time member

select * from Customer where CustomerID = 2;
-- this will show the updated information


-- <<<<<<<<<<<<
-- tests - must fail

select * from Customer where CustomerTypeID = "2";
-- this will show all full time members

call ChangeToFullTimeMember(11);
-- this will affect 0 rows

select * from Customer where CustomerID = 11;
-- this will return an empty table as there is no customer with the id of 11

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- Procedure to add beverage subscription
delimiter %%
%%
create procedure `AddBeverageSubscription`(
in InputID int
)
begin 
declare BeverageSubscription tinyint;
start transaction;
select BeverageSubscription from Customer where CustomerID = InputID into BeverageSubscription; 
if BeverageSubscription = 0 then 
	update Customer 
	set coffeesubscription = 1
	where CustomerID = InputID;
elseif BeverageSubscription = 1 then 
	select " the user already has a beverage subscription";
end if;
commit;
end %%
delimiter ;

-- <<<<<<<<<
-- tests 

select * from Customer where BeverageSubscription = 0;
-- this will show all the customers that don't have a beverage subscription 

call AddBeverageSubscription (3);
-- this will add the customerID of 3 with a beverage subscription

select * from Customer where CustomerID = 3;
-- this will show the updated information

-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- Remove beverage subscription procedure
delimiter //
//
create procedure `RemoveBeverageSubscription`(
in InputID int
)
begin 
declare BeverageSubscription tinyint;
start transaction;
select BeverageSubscription from Customer where CustomerID = InputID into BeverageSubscription; 
if BeverageSubscription = 1 then 
	update Customer 
	set coffeesubscription = 0
	where CustomerID = InputID;
elseif BeverageSubscription = 0 then 
	select " you havent got a coffee subscription to cancel";
end if;
commit;
end //
delimiter ;

-- <<<<<<<<<<<<
-- tests

select * from Customer where CustomerID = 5;
-- this will show the rows which consists with the customerID of 5

call RemoveBeverageSubscription (5);
-- this will cancel the beverage subscription for the customerid of 4

select * from Customer where CustomerID = 5;
-- this will now show that the customerid of 4 has canceled its beverage subscription


-- <<<<<<<<<
-- tests 

select * from Customer where CustomerID = 3;
-- this will return data for customer id of 2

call RemoveBeverageSubscription (3);
-- the customer id of 3 does not have a beverage subscription

select * from Customer where CustomerID = 2; 
-- this will clearly show that the user doesnt have a beverage subscription.
 
 
 delimiter //
 create procedure CancelBooking( in UserInputID int)
 begin
 
 delete from Booking where CustomerID = UserInputID and curdate() < StartDate;
 end //
 delimiter ; 
 
select * from Booking where CustomerID = 2;
 
call CancelBooking (2);

select * from Booking where CustomerID = 3;

call CancelBooking (3);
 
 
delimiter //
create trigger CheckCustomerExists before insert on Customer for each row 
begin 
if new.CustomerID not in (select CustomerID from Customer ) then
	signal sqlstate value '45000'
	set message_text = 'the user does not exist, please try again';
    end if;
    end //
    delimiter ;