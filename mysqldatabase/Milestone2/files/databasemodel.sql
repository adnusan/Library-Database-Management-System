-- MySQL Workbench Forward Engineering
SET SQL_SAFE_UPDATES = 0; 
USE LibraryManagementDB;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema LibraryManagementDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LibraryManagementDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LibraryManagementDB`;
CREATE SCHEMA IF NOT EXISTS `LibraryManagementDB` DEFAULT CHARACTER SET utf8 ;
USE `LibraryManagementDB` ;

-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`user` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `gender` VARCHAR(1) NULL COMMENT 'M=Male\nF=Female',
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`address` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  `apt` VARCHAR(10) NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL COMMENT 'holds address type example: billing/shipping/mailing address',
  PRIMARY KEY (`address_id`),
  UNIQUE INDEX `address_id_UNIQUE` (`address_id` ASC) VISIBLE,
  INDEX `idx_city` (`city` ASC) INVISIBLE,
  INDEX `idx_state` (`state` ASC) INVISIBLE,
  INDEX `idx_zip` (`zip_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`category` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `cateogry_name` VARCHAR(45) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`storage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`storage` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`storage` (
  `stored_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `building` VARCHAR(45) NULL,
  `floor` VARCHAR(45) NULL,
  `rack_row` VARCHAR(45) NULL,
  `rack_num` VARCHAR(45) NULL,
  PRIMARY KEY (`stored_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`book` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`book` (
  `book_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `categories_categories_id` INT NULL,
  `pub_date` VARCHAR(45) NULL,
  `copies_quantity` INT NULL,
  `description` MEDIUMTEXT NULL,
  `book_price` DECIMAL(15,2) NULL,
  `language` VARCHAR(45) NULL,
  `stored_stored_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`),
  UNIQUE INDEX `book_id_UNIQUE` (`book_id` ASC) VISIBLE,
  INDEX `idx_title` (`title` ASC) VISIBLE,
  INDEX `fk_book_categories1_idx` (`categories_categories_id` ASC) VISIBLE,
  INDEX `fk_book_stored1_idx` (`stored_stored_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_categories1`
    FOREIGN KEY (`categories_categories_id`)
    REFERENCES `LibraryManagementDB`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE SET NULL,
  CONSTRAINT `fk_book_stored1`
    FOREIGN KEY (`stored_stored_id`)
    REFERENCES `LibraryManagementDB`.`storage` (`stored_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`registered_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`registered_member` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`registered_member` (
  `registered_member_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `gov_id` VARCHAR(45) NOT NULL,
  `registered_date` VARCHAR(45) NULL,
  PRIMARY KEY (`registered_member_id`, `user_id`),
  UNIQUE INDEX `gov_id_UNIQUE` (`gov_id` ASC) VISIBLE,
  INDEX `FK_user_id_idx` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  UNIQUE INDEX `registered_member_id_UNIQUE` (`registered_member_id` ASC) VISIBLE,
  CONSTRAINT `FK_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `LibraryManagementDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`member_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`member_address` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`member_address` (
  `registered_member_id` INT NOT NULL,
  `address_id` INT NULL,
  INDEX `FK_address_id_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `FK_registered_member_id`
    FOREIGN KEY (`registered_member_id`)
    REFERENCES `LibraryManagementDB`.`registered_member` (`registered_member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `LibraryManagementDB`.`address` (`address_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`author` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`author` (
  `author_id` INT NOT NULL AUTO_INCREMENT,
  `first_name_author` VARCHAR(45) NULL,
  `last_name_author` VARCHAR(45) NULL,
  `dob` DATE NULL,
  `author_info` TEXT NULL,
  `death` DATE NULL,
  `gender` VARCHAR(1) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`author_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`book_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`book_author` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`book_author` (
  `book_id` INT NOT NULL,
  `author_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `author_id`),
  INDEX `FK_author_id_idx` (`author_id` ASC) VISIBLE,
  CONSTRAINT `FK_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `LibraryManagementDB`.`book` (`book_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_author_id`
    FOREIGN KEY (`author_id`)
    REFERENCES `LibraryManagementDB`.`author` (`author_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`subscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`subscription` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`subscription` (
  `subscription_id` INT NOT NULL AUTO_INCREMENT,
  `registered_member_id` INT NOT NULL,
  `premium_member_id` INT NOT NULL,
  `subscription_user_id` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  INDEX `FK_premium_member_id_idx` (`premium_member_id` ASC) VISIBLE,
  PRIMARY KEY (`subscription_id`),
  INDEX `fk_subs_user_id_idx` (`subscription_user_id` ASC) VISIBLE,
  UNIQUE INDEX `subscription_id_UNIQUE` (`subscription_id` ASC) VISIBLE,
  CONSTRAINT `FK_register_member_id`
    FOREIGN KEY (`registered_member_id`)
    REFERENCES `LibraryManagementDB`.`registered_member` (`registered_member_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_premium_member_id`
    FOREIGN KEY (`premium_member_id`)
    REFERENCES `LibraryManagementDB`.`premium_member` (`premium_member_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subs_user_id`
    FOREIGN KEY (`subscription_user_id`)
    REFERENCES `LibraryManagementDB`.`registered_member` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`premium_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`premium_member` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`premium_member` (
  `premium_member_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL DEFAULT 'Premium member' COMMENT 'role = premium member',
  `start_date` VARCHAR(45) NULL,
  `renewal_price` DECIMAL(15,2) NULL,
  `premium_user_id` INT NULL,
  PRIMARY KEY (`premium_member_id`),
  INDEX `user_id_idx` (`premium_user_id` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`premium_user_id`)
    REFERENCES `LibraryManagementDB`.`subscription` (`subscription_user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`librarian`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`librarian` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`librarian` (
  `librarian_id` INT NOT NULL,
  `registered_member_id` INT NOT NULL,
  `title` VARCHAR(45) NULL COMMENT 'list of things librarian role could do.',
  `ssn` VARCHAR(45) NOT NULL,
  `hire_date` DATE NULL,
  `wage` DECIMAL(15,2) NULL,
  PRIMARY KEY (`librarian_id`, `registered_member_id`),
  INDEX `fk_librarian_registered_member1_idx` (`registered_member_id` ASC) VISIBLE,
  CONSTRAINT `fk_librarian_registered_member1`
    FOREIGN KEY (`registered_member_id`)
    REFERENCES `LibraryManagementDB`.`registered_member` (`registered_member_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`roles` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`roles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL COMMENT 'name of roles',
  `description` MEDIUMTEXT NULL COMMENT 'describe what actions this roles can perform',
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`has_roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`has_roles` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`has_roles` (
  `roles_role_id` INT NULL,
  `user_user_id` INT NOT NULL,
  INDEX `fk_has_roles_roles1_idx` (`roles_role_id` ASC) VISIBLE,
  INDEX `fk_has_roles_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_has_roles_roles1`
    FOREIGN KEY (`roles_role_id`)
    REFERENCES `LibraryManagementDB`.`roles` (`role_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_has_roles_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `LibraryManagementDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`has_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`has_permission` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`has_permission` (
  `permission_id` INT NOT NULL,
  `book_book_id` INT NULL,
  `permission_type` VARCHAR(45) NULL COMMENT 'actions like edit, add, update, block, remove books / users',
  `permission_description` TINYTEXT NULL COMMENT 'describes what this action_title can do',
  `subscription_subscription_id` INT NULL,
  PRIMARY KEY (`permission_id`),
  INDEX `fk_has_permission_book1_idx` (`book_book_id` ASC) VISIBLE,
  INDEX `fk_has_permission_subscription1_idx` (`subscription_subscription_id` ASC) VISIBLE,
  CONSTRAINT `FK_librarian_id`
    FOREIGN KEY (`permission_id`)
    REFERENCES `LibraryManagementDB`.`librarian` (`librarian_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_has_permission_book1`
    FOREIGN KEY (`book_book_id`)
    REFERENCES `LibraryManagementDB`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_has_permission_subscription1`
    FOREIGN KEY (`subscription_subscription_id`)
    REFERENCES `LibraryManagementDB`.`subscription` (`subscription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`publisher` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`publisher` (
  `publisher_id` INT NOT NULL,
  `book_book_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `location` INT NULL,
  `established_date` DATE NULL,
  PRIMARY KEY (`publisher_id`),
  INDEX `FK_publisher_address_idx` (`location` ASC) VISIBLE,
  INDEX `fk_publisher_book1_idx` (`book_book_id` ASC) VISIBLE,
  CONSTRAINT `FK_publisher_address`
    FOREIGN KEY (`location`)
    REFERENCES `LibraryManagementDB`.`address` (`address_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_publisher_book1`
    FOREIGN KEY (`book_book_id`)
    REFERENCES `LibraryManagementDB`.`book` (`book_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`borrows`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`borrows` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`borrows` (
  `borrows_id` INT NOT NULL AUTO_INCREMENT,
  `book_id` INT NOT NULL,
  `registered_member_id` INT NOT NULL,
  `issue_date` DATE NULL,
  `returned_date` VARCHAR(45) NULL,
  PRIMARY KEY (`borrows_id`),
  INDEX `fk_rent_book_id_idx` (`book_id` ASC) VISIBLE,
  INDEX `fk_borrows_premium_member1_idx` (`registered_member_id` ASC) VISIBLE,
  CONSTRAINT `fk_rent_book_id`
    FOREIGN KEY (`book_id`)
    REFERENCES `LibraryManagementDB`.`book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_borrows_premium_member1`
    FOREIGN KEY (`registered_member_id`)
    REFERENCES `LibraryManagementDB`.`registered_member` (`registered_member_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`reserve_pickup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`reserve_pickup` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`reserve_pickup` (
  `reserve_pickup_id` INT NOT NULL AUTO_INCREMENT,
  `premium_member_id` INT NOT NULL,
  `borrows_borrows_id` INT NOT NULL,
  `reservation_date` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL COMMENT 'holds reservation status like fulfilled, processing, etc.',
  PRIMARY KEY (`reserve_pickup_id`, `premium_member_id`),
  INDEX `fk_reserve_pickup_premium_member1_idx` (`premium_member_id` ASC) VISIBLE,
  INDEX `fk_reserve_pickup_borrows1_idx` (`borrows_borrows_id` ASC) VISIBLE,
  CONSTRAINT `fk_reserve_pickup_premium_member1`
    FOREIGN KEY (`premium_member_id`)
    REFERENCES `LibraryManagementDB`.`premium_member` (`premium_member_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reserve_pickup_borrows1`
    FOREIGN KEY (`borrows_borrows_id`)
    REFERENCES `LibraryManagementDB`.`borrows` (`borrows_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`fine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`fine` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`fine` (
  `fine_id` INT NOT NULL,
  `finecol` VARCHAR(45) NULL,
  `fine_date` DATE NULL,
  `fine_amount` DECIMAL(15,2) NULL,
  `borrows_id` INT NULL,
  PRIMARY KEY (`fine_id`),
  INDEX `fk_fine_borrow_id_idx` (`borrows_id` ASC) VISIBLE,
  CONSTRAINT `fk_fine_borrow_id`
    FOREIGN KEY (`borrows_id`)
    REFERENCES `LibraryManagementDB`.`borrows` (`borrows_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`payment_card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`payment_card` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`payment_card` (
  `payment_card_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL COMMENT 'debit or credit',
  `card_number` VARCHAR(45) NULL,
  `cvv` INT(4) NULL,
  `zip_code` VARCHAR(45) NULL,
  PRIMARY KEY (`payment_card_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`paypal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`paypal` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`paypal` (
  `paypal_id` INT NOT NULL AUTO_INCREMENT,
  `paypal_account` VARCHAR(45) NULL,
  PRIMARY KEY (`paypal_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`crypto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`crypto` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`crypto` (
  `crypto_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL COMMENT 'type of crypto',
  `wallet_id` VARCHAR(150) NULL,
  PRIMARY KEY (`crypto_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`payment_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`payment_type` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`payment_type` (
  `payment_type_id` INT NOT NULL AUTO_INCREMENT,
  `crypto_crypto_id` INT NULL,
  `payment_card_payment_card_id` INT NULL,
  `paypal_paypal_id` INT NULL,
  PRIMARY KEY (`payment_type_id`),
  INDEX `fk_patment_type_crypto1_idx` (`crypto_crypto_id` ASC) VISIBLE,
  INDEX `fk_patment_type_payment_card1_idx` (`payment_card_payment_card_id` ASC) VISIBLE,
  INDEX `fk_patment_type_paypal1_idx` (`paypal_paypal_id` ASC) VISIBLE,
  CONSTRAINT `fk_patment_type_crypto1`
    FOREIGN KEY (`crypto_crypto_id`)
    REFERENCES `LibraryManagementDB`.`crypto` (`crypto_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_patment_type_payment_card1`
    FOREIGN KEY (`payment_card_payment_card_id`)
    REFERENCES `LibraryManagementDB`.`payment_card` (`payment_card_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_patment_type_paypal1`
    FOREIGN KEY (`paypal_paypal_id`)
    REFERENCES `LibraryManagementDB`.`paypal` (`paypal_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`user_payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`user_payment` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`user_payment` (
  `payment_type_payment_type_id` INT NULL,
  `user_user_id` INT NOT NULL,
  INDEX `fk_registered_member_payment_payment_type1_idx` (`payment_type_payment_type_id` ASC) VISIBLE,
  INDEX `fk_user_payment_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_registered_member_payment_payment_type1`
    FOREIGN KEY (`payment_type_payment_type_id`)
    REFERENCES `LibraryManagementDB`.`payment_type` (`payment_type_id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_payment_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `LibraryManagementDB`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`notification` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`notification` (
  `notification_id` INT NOT NULL AUTO_INCREMENT,
  `notification_message` TINYTEXT NULL,
  PRIMARY KEY (`notification_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`receives_notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`receives_notification` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`receives_notification` (
  `premium_member_premium_member_id` INT NOT NULL,
  `notification_notification_id` INT NOT NULL,
  INDEX `fk_receives_notification_premium_member1_idx` (`premium_member_premium_member_id` ASC) VISIBLE,
  INDEX `fk_receives_notification_notification1_idx` (`notification_notification_id` ASC) VISIBLE,
  CONSTRAINT `fk_receives_notification_premium_member1`
    FOREIGN KEY (`premium_member_premium_member_id`)
    REFERENCES `LibraryManagementDB`.`premium_member` (`premium_member_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_receives_notification_notification1`
    FOREIGN KEY (`notification_notification_id`)
    REFERENCES `LibraryManagementDB`.`notification` (`notification_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`device` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`device` (
  `device_id` INT NOT NULL AUTO_INCREMENT,
  `device_name` VARCHAR(45) NULL,
  `device_type` VARCHAR(45) NULL,
  `device_price` DECIMAL(15,2) NULL,
  PRIMARY KEY (`device_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`user_used_device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`user_used_device` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`user_used_device` (
  `user_user_id` INT NOT NULL,
  `device_device_id` INT NOT NULL,
  INDEX `fk_user_used_device_user1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `fk_user_used_device_device1_idx` (`device_device_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_used_device_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `LibraryManagementDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_used_device_device1`
    FOREIGN KEY (`device_device_id`)
    REFERENCES `LibraryManagementDB`.`device` (`device_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`default_payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`default_payment` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`default_payment` (
  `subscription_subscription_id` INT NOT NULL,
  `payment_type_payment_type_id` INT NOT NULL,
  PRIMARY KEY (`subscription_subscription_id`, `payment_type_payment_type_id`),
  INDEX `fk_default_payment_subscription1_idx` (`subscription_subscription_id` ASC) VISIBLE,
  INDEX `fk_default_payment_payment_type1_idx` (`payment_type_payment_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_default_payment_subscription1`
    FOREIGN KEY (`subscription_subscription_id`)
    REFERENCES `LibraryManagementDB`.`subscription` (`subscription_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_default_payment_payment_type1`
    FOREIGN KEY (`payment_type_payment_type_id`)
    REFERENCES `LibraryManagementDB`.`payment_type` (`payment_type_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LibraryManagementDB`.`invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LibraryManagementDB`.`invoice` ;

CREATE TABLE IF NOT EXISTS `LibraryManagementDB`.`invoice` (
  `invoice_id` INT NOT NULL AUTO_INCREMENT,
  `user_user_id` INT NOT NULL,
  `borrows_id` INT NOT NULL,
  `librarian_librarian_id` INT NOT NULL,
  `amount` DECIMAL(18,2),
  PRIMARY KEY (`invoice_id`),
  INDEX `fk_invoice_user1_idx` (`user_user_id` ASC) VISIBLE,
  INDEX `fk_invoice_borrows1_idx` (`borrows_id` ASC) VISIBLE,
  INDEX `fk_invoice_librarian1_idx` (`librarian_librarian_id` ASC) VISIBLE,
  CONSTRAINT `fk_invoice_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `LibraryManagementDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_borrows1`
    FOREIGN KEY (`borrows_id`)
    REFERENCES `LibraryManagementDB`.`borrows` (`borrows_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_librarian1`
    FOREIGN KEY (`librarian_librarian_id`)
    REFERENCES `LibraryManagementDB`.`librarian` (`librarian_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
