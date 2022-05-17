SET SQL_SAFE_UPDATES = 0; 
-- Script name: tests.sql
-- Author:      Jose Ortiz
-- Purpose:     test the integrity of this database system
       
-- the database used to insert the data into.
USE LibraryManagementDB;

-- 1. Testing User table
-- DELETE FROM user WHERE first_name = 'Nusan'; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`registered_member`, CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE RESTRICT)
-- UPDATE user SET user_id = 4 WHERE first_name = 'Nima'; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`registered_member`, CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE RESTRICT)


-- 2. Testing book table
-- DELETE FROM book WHERE title = 'Hunt'; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`has_permission`, CONSTRAINT `fk_has_permission_book1` FOREIGN KEY (`book_book_id`) REFERENCES `book` (`book_id`))

UPDATE book SET title = 'Hunter' WHERE title = 'Hunt';

-- 3. Address table test
DELETE FROM address WHERE zip_code = '94511';
UPDATE address SET state = 'WA' WHERE state = 'CA';

-- 4. author table test
DELETE FROM author WHERE first_name_author = 'Vaxo';
UPDATE author SET last_name_author = 'Rana' WHERE last_name_author = 'Lama';

-- 5. book_author test
DELETE FROM book_author WHERE book_id = 711;
UPDATE book_author SET book_id = 713 WHERE book_id = 712;

-- 6 borrows testing
-- DELETE FROM borrows WHERE borrows_id = 911; --Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`has_permission`, CONSTRAINT `fk_has_permission_book1` FOREIGN KEY (`book_book_id`) REFERENCES `book` (`book_id`))

UPDATE borrows SET book_id = 711 WHERE book_id = 712;

-- 7. category testing
-- DELETE FROM category WHERE category_id = 512; -- Error Code: 1054. Unknown column 'book_id' in 'where clause' --Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`book`, CONSTRAINT `fk_book_categories1` FOREIGN KEY (`categories_categories_id`) REFERENCES `category` (`category_id`) ON UPDATE SET NULL)


UPDATE category SET category_id = 500 WHERE category_id = 511;

-- 8. crypto table
DELETE FROM crypto WHERE crypto_id = 1001;
UPDATE crypto SET crypto_id = 10011 WHERE crypto_id = 1002;

-- 9. default_payment test
DELETE FROM default_payment WHERE payment_type_payment_type_id = 50001;
UPDATE default_payment SET payment_type_payment_type_id = 190011 WHERE payment_type_payment_type_id = 50002;

-- 10 device test
-- DELETE FROM device WHERE device_id = 1233; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`user_used_device`, CONSTRAINT `fk_user_used_device_device1` FOREIGN KEY (`device_device_id`) REFERENCES `device` (`device_id`))
-- UPDATE device SET device_id = 190011 WHERE device_id = 1233; Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`user_used_device`, CONSTRAINT `fk_user_used_device_device1` FOREIGN KEY (`device_device_id`) REFERENCES `device` (`device_id`))

-- 11. fine table test
DELETE FROM fine WHERE fine_id = 9111;
UPDATE fine SET fine_id = 91011 WHERE fine_id = 9222;

-- 12 has_permission test
DELETE FROM has_permission WHERE permission_id = 881;
-- UPDATE has_permission SET permission_id = 99011 WHERE permission_id = 882; -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`librarymanagementdb`.`has_permission`, CONSTRAINT `FK_librarian_id` FOREIGN KEY (`permission_id`) REFERENCES `librarian` (`librarian_id`) ON DELETE CASCADE ON UPDATE CASCADE)

-- 13 has_roles test
DELETE FROM has_roles WHERE roles_role_id = 211;
-- UPDATE has_roles SET roles_roles_id = 90011 WHERE roles_role_id = 212; -- Error Code: 1054. Unknown column 'roles_roles_id' in 'field list'

-- 14 invoice table test
DELETE FROM invoice WHERE invoice_id = 123455;
UPDATE invoice SET invoice_id = 1223456 WHERE invoice_id = 123456;

-- 15 librarian test
-- DELETE FROM librarian WHERE librarian_id = 881; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`invoice`, CONSTRAINT `fk_invoice_librarian1` FOREIGN KEY (`librarian_librarian_id`) REFERENCES `librarian` (`librarian_id`))
UPDATE  librarian SET librarian_id  = 12263456 WHERE librarian_id = 882;

-- 16 member_address test
DELETE FROM member_address WHERE registered_member_id = 811;
-- UPDATE  member_address SET registered_member_id  = 13263456 WHERE registered_member_id = 812; -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`librarymanagementdb`.`member_address`, CONSTRAINT `FK_registered_member_id` FOREIGN KEY (`registered_member_id`) REFERENCES `registered_member` (`registered_member_id`))

-- 17 notification test
-- DELETE FROM notificatiion WHERE notification_id = 7001; -- Error Code: 1146. Table 'librarymanagementdb.notificatiion' doesn't exist
-- UPDATE notification SET notification_id = 1923456 WHERE notification_id = 7002; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`receives_notification`, CONSTRAINT `fk_receives_notification_notification1` FOREIGN KEY (`notification_notification_id`) REFERENCES `notification` (`notification_id`))

-- 18. payment_card
DELETE FROM payment_card WHERE payment_card_id = 2001;
UPDATE payment_card SET payment_card_id = 12723456 WHERE payment_card_id = 2002;

-- 19 payment_type test
-- DELETE FROM payment_type WHERE payment_type_id = 4001; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`default_payment`, CONSTRAINT `fk_default_payment_payment_type1` FOREIGN KEY (`payment_type_payment_type_id`) REFERENCES `payment_type` (`payment_type_id`))

-- UPDATE payment_type SET payment_type_id = 10723456 WHERE payment_type_id = 4002; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`default_payment`, CONSTRAINT `fk_default_payment_payment_type1` FOREIGN KEY (`payment_type_payment_type_id`) REFERENCES `payment_type` (`payment_type_id`))

-- 20 paypal
-- DELETE FROM paypal WHERE paypal_id = 3001; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`payment_type`, CONSTRAINT `fk_patment_type_paypal1` FOREIGN KEY (`paypal_paypal_id`) REFERENCES `paypal` (`paypal_id`) ON UPDATE CASCADE)
UPDATE paypal SET paypal_id = 178723456 WHERE paypal_id = 3002;

-- 21 storage test
-- DELETE FROM storage WHERE stored_id = 611; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`book`, CONSTRAINT `fk_book_stored1` FOREIGN KEY (`stored_stored_id`) REFERENCES `storage` (`stored_id`) ON UPDATE CASCADE)
UPDATE storage SET stored_id = 198723456 WHERE stored_id = 612;

-- 22 registered_member
-- DELETE FROM registered_member WHERE registered_member_id = 811; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`default_payment`, CONSTRAINT `fk_default_payment_subscription1` FOREIGN KEY (`subscription_subscription_id`) REFERENCES `subscription` (`subscription_id`))
-- UPDATE registered_member SET registered_member_id = 129723456 WHERE registered_member_id = 812; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`librarymanagementdb`.`subscription`, CONSTRAINT `FK_register_member_id` FOREIGN KEY (`registered_member_id`) REFERENCES `registered_member` (`registered_member_id`) ON DELETE CASCADE)

-- 23 user_used_device
DELETE FROM user_used_device WHERE user_user_id = 111;
-- UPDATE user_used_device SET user_user_id = 127283456 WHERE user_user_id = 112; -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`librarymanagementdb`.`user_used_device`, CONSTRAINT `fk_user_used_device_user1` FOREIGN KEY (`user_user_id`) REFERENCES `user` (`user_id`))

