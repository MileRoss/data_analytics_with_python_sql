-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema auto_shop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema auto_shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `auto_shop` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `auto_shop` ;

-- -----------------------------------------------------
-- Table `auto_shop`.`cars`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_shop`.`cars` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `auto_shop`.`cars` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `VIN` VARCHAR(45) NOT NULL,
  `manufacturer` VARCHAR(45) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `year` YEAR(4) NOT NULL,
  `color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `VIN_UNIQUE` ON `auto_shop`.`cars` (`VIN` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `auto_shop`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_shop`.`customers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `auto_shop`.`customers` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `customer_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100),
  `address` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state_province` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `zip_postal_code` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `customer ID_UNIQUE` ON `auto_shop`.`customers` (`customer_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `email_UNIQUE` ON `auto_shop`.`customers` (`email` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `auto_shop`.`salespersons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_shop`.`salespersons` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `auto_shop`.`salespersons` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `staff_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `store` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `staff ID_UNIQUE` ON `auto_shop`.`salespersons` (`staff_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `auto_shop`.`invoices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `auto_shop`.`invoices` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `auto_shop`.`invoices` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `invoice_id` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `car_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `salesperson_id` INT NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `car`
    FOREIGN KEY (`car_id`)
    REFERENCES `auto_shop`.`cars` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `auto_shop`.`customers` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `salesperson`
    FOREIGN KEY (`salesperson_id`)
    REFERENCES `auto_shop`.`salespersons` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `invoice ID_UNIQUE` ON `auto_shop`.`invoices` (`invoice_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `customer_idx` ON `auto_shop`.`invoices` (`customer_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `car_idx` ON `auto_shop`.`invoices` (`car_id` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `salesperson_idx` ON `auto_shop`.`invoices` (`salesperson_id` ASC) VISIBLE;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
