
-- Author: Nusan Adhikari
SET SQL_SAFE_UPDATES = 0; 
USE LibraryManagementDB;

-- Trigger to automatically update registered date to current date
CREATE TRIGGER register_user
BEFORE INSERT 
ON registered_member
FOR EACH ROW
SET new.registered_date = date_format(now(), '%y %m %d');

-- Trigger to automatically decrease total qunatity from book inventory when user borrows a book
CREATE TRIGGER update_copies AFTER INSERT ON borrows
FOR EACH ROW
UPDATE BOOK SET copies_quantity = (copies_quantity - 1)
WHERE book_id = new.book_id;


-- Testing inserts
-- INSERT INTO book (book_id, title, categories_categories_id, pub_date, copies_quantity,description,book_price,language,stored_stored_id) VALUES(761,'How To Fly',511,'2000-10-10', 50, 'book about diet', 29.99, 'english',611);
-- INSERT INTO borrows (borrows_id, book_id, registered_member_id, issue_date) VALUES (919, 711, 811, '2021-4-19');