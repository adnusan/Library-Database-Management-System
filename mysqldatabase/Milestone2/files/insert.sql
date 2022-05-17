 -- Script name: insert.sql
   -- Author:      Nusan Adhikari
   -- Purpose:     insert sample data to test the integrity of this database system
   
   -- the database used to insert the data into.
SET SQL_SAFE_UPDATES = 0; 
USE LibraryManagementDB;

-- User table insert
INSERT INTO user (user_id, first_name, last_name, middle_name, email, password, gender, phone_number) 
	VALUES (111, 'Nusan', 'Adhikari', 'M','nusan14@gmail.com', 'password','M','4154154151'), 
	(112, 'Nima', 'Lama', 'M','eaxmple1@gmail.com', 'password1','F','4154254151'),
	(113, 'John', 'Musk', 'M','eaxmple11@gmail.com', 'password12','M','5154254151');

-- Registered User insert
INSERT INTO registered_member (registered_member_id, user_id, gov_id, registered_date) 
	VALUES (811, 111, '987456', '2021-04-19'), (812, 112, '321654', '2021-04-18'),(813, 113, '789123', '2020-08-9');

-- Role table insert
INSERT INTO roles (role_id,name, description ) 
	VALUES (211,'General User', 'General user can only use devices inside library.'),
    (212,'Employee', 'Employee can edit books, subscription'),
    (213,'Registered Member', 'Registered Member can borrow books and use library devices.');
    
-- has_roles table insert
INSERT INTO has_roles (roles_role_id, user_user_id) VALUES (211,111),(212,112),(213,113);

-- librarian table insert
INSERT INTO librarian (librarian_id, registered_member_id, title, ssn, hire_date, wage) VALUES (881, 811, 'employee', '132456789', '2012-1-1', 16.00),
	(882, 812, 'janitor', '123456987', '2020-04-8', 14.00), (883, 813, 'admin', '789456123', '2020-05-9', 14.56);

-- Address table insert
INSERT INTO address (address_id,street,city,state,apt,zip_code,type)
	VALUES(311,'123 example st','San Francisco','CA','','94511','billing'),
    (312,'1234 example st','San Francisc','CA','','94512','shipping'),
    (313,'12345 example st','San Francis','CA','','94513','mailing');

-- member_address table insert
INSERT INTO member_address (registered_member_id,address_id) VALUES (811,311),(812,312),(813,313);

-- Author table insert
INSERT INTO author (author_id,first_name_author,last_name_author,dob,author_info,death,gender,country)
	VALUES(411,'Laxmi','Prasad','1969-04-10','great poet','1999-12-6','M','Nepal'),
	(412,'Vaxo','Lama','1960-04-10','great poet','1991-12-6','F','USA'),
	(413,'Bhanu','Lama','1970-04-10','great poet','2001-12-6','M','Canada');
            
-- Category table insert
INSERT INTO category (category_id, cateogry_name) VALUES (511, 'Comic'), (512, 'Horror'), (513, 'Romance');

-- Stored table insert
INSERT INTO storage (stored_id, building, floor, rack_row, rack_num) VALUES ('611', 'Main', '5', 'D', '20'),('612', 'Right', '2', 'D', '1'),('613', 'Left', '7', 'D', '5');

-- Book table insert
INSERT INTO book (book_id, title, categories_categories_id, pub_date, copies_quantity,description,book_price,language,stored_stored_id)
	VALUES(711,'How To Fly',511,'2000-10-10', 50, 'book about diet', 29.99, 'english',611), 
	(712,'Hunt',512,'1979-10-10', 98, 'horror story', 25.99, 'english',612),
	(713,'Ursala',513,'1980-10-10', 5, 'werewolf story', 9.99, 'english',613); 
    
-- book_author table insert
INSERT INTO book_author (book_id, author_id) VALUES (711,411),(712,412),(713,413);

-- borrows table insert
INSERT INTO borrows (borrows_id, book_id, registered_member_id, issue_date) VALUES (911, 711, 811, '2021-4-19'), (912, 712, 812, '2021-04-18'),
	(913, 713, 813, '2021-04-10');

-- crypto table insert
INSERT INTO crypto (crypto_id, type, wallet_id) VALUES (1001, 'bitcoin', 'dwe1798'), (1002, 'eth', 'hio87897984'), (1003, 'bn', 'jkopi78945645');

-- payment_card table insert
INSERT INTO payment_card (payment_card_id, type, card_number, cvv, zip_code) 
	VALUES (2001, 'debit', '12345678912345', '369', '91111'),(2003, 'credit', '78945612332165', '123', '92222'),(2004, 'visa', '7894561236545', '899', '93333');

-- paypal table insert
INSERT INTO paypal (paypal_id, paypal_account) VALUES (3001, '918918918'),(3002, '999999999'),(3003, 'snuiqwhediu798');

-- payment_type table insert
INSERT INTO payment_type (payment_type_id, crypto_crypto_id) VALUES (4001, 1001);
INSERT INTO payment_type (payment_type_id, payment_card_payment_card_id) VALUES (4002, 2001);
INSERT INTO payment_type (payment_type_id, paypal_paypal_id) VALUES (4003, 3001);

-- premium_member table insert
INSERT INTO premium_member (premium_member_id, title, start_date, renewal_price) VALUES (90001, 'premium', '2021-04-10', 10.99),
	(90002, 'premium', '2021-1-1', 8.99), (90003, 'premium', '2021-4-18', 10.99);
    
-- subscription table insert
INSERT INTO subscription (subscription_id, registered_member_id, premium_member_id, subscription_user_id, status) VALUES (50001, 811, 90001, 111, 'active'),
	(50002, 812, 90002, 112, 'active'),(50003, 813, 90003, 113, 'expired');

-- device table insert
INSERT INTO device (device_id, `device_name`, `device_type`, `device_price`) VALUES ('1234', 'printer', 'print', '0.99'), (1235, 'fax', 'fax', '2.33'), (1233, 'computer', 'computer', '5.99');

-- default_payment table insert
INSERT INTO default_payment (subscription_subscription_id, payment_type_payment_type_id) VALUES (50001, 4001),(50002, 4002),(50003, 4003);

-- fine table insert
INSERT INTO fine (fine_id, fine_date, fine_amount, borrows_id) VALUES (9111, '2021-04-19', '5.99', 911), (9222, '2021-4-17', '5.99', 912), (9333, '2021-4-10', '1.99', 913);

-- has_permission table insert
INSERT INTO has_permission (permission_id, book_book_id, permission_type, permission_description) VALUES (881, 711, 'edit', 'can edit book');
INSERT INTO has_permission (permission_id, `permission_type`, `subscription_subscription_id`) VALUES (882, 'cancel membership', 50001);
INSERT INTO has_permission (permission_id, book_book_id, permission_type, permission_description) VALUES (883,712,'remove', 'remove book');


-- invoice table insert
INSERT INTO invoice (invoice_id, user_user_id, borrows_id, librarian_librarian_id) VALUES (123456, 111, 911, 881),(123455, 112, 912, 882),(123457, 113, 913, 883);

-- reserve_pickup table insert
INSERT INTO reserve_pickup (reserve_pickup_id, premium_member_id,borrows_borrows_id, reservation_date, status) VALUES (3333, 90001, 911, '2020-4-9', 'pending'),
	(3332, 90002, 912, '2020-4-9', 'filled'),(3331, 90003, 913, '2020-4-9', 'pending');
    
-- user_payment table insert
INSERT INTO user_payment (payment_type_payment_type_id,user_user_id) VALUES (4001,111),(4002,112),(4003,113);

-- user_used_device
INSERT INTO user_used_device(user_user_id,device_device_id) VALUES (111,1234),(112,1235),(113,1233);

-- notification table insert
INSERT INTO notification (notification_id, notification_message) VALUES (7001, 'due soon'), (7002, 'past due'), (7003, 'new book available');

-- receives_notification table insert
INSERT INTO receives_notification (premium_member_premium_member_id,notification_notification_id) VALUES (90001,7001),(90002,7002),(90003,7003);

-- publisher table insert
INSERT INTO publisher (publisher_id, book_book_id, name, location, established_date) VALUES (6001, 711, 'Pearson', 311, '2013-1-1'),
(6002, 712, 'Wolters Kluwer', 312, '1990-9-1'),(6003, 713, 'Reed', 313, '2003-8-15');



