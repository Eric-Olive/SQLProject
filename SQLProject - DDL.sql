-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Person` (
  `idPerson` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `phoneNumber` VARCHAR(45) NULL,
  `unccEmail` VARCHAR(45) NULL,
  PRIMARY KEY (`idPerson`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Restaurant` (
  `idRestaurant` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `phoneNumber` VARCHAR(45) NULL,
  PRIMARY KEY (`idRestaurant`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `idItem` INT NOT NULL,
  `idRestaurant` INT NOT NULL,
  `dish` VARCHAR(45) NULL,
  `calories` VARCHAR(45) NULL,
  PRIMARY KEY (`idItem`, `idRestaurant`),
  INDEX `fk_Item_Restaurant1_idx` (`idRestaurant` ASC) VISIBLE,
  CONSTRAINT `fk_Item_Restaurant1`
    FOREIGN KEY (`idRestaurant`)
    REFERENCES `mydb`.`Restaurant` (`idRestaurant`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`PaymentMethod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PaymentMethod` (
  `idPaymentMethod` INT NOT NULL,
  `cardNumber` VARCHAR(45) NULL,
  `expirationDate` VARCHAR(45) NULL,
  PRIMARY KEY (`idPaymentMethod`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`DeliveryLocation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DeliveryLocation` (
  `idDeliveryLocation` INT NOT NULL,
  `location` VARCHAR(45) NULL,
  `deliveryDateTime` DATETIME(1) NULL,
  PRIMARY KEY (`idDeliveryLocation`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `idOrder` INT NOT NULL,
  `idItem` INT NOT NULL,
  `idPaymentMethod` INT NOT NULL,
  `idDeliveryLocation` INT NOT NULL,
  `contents` VARCHAR(45) NULL,
  `totalPrice` DECIMAL(4,2) NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`idOrder`, `idItem`, `idPaymentMethod`, `idDeliveryLocation`),
  INDEX `fk_Order_Item1_idx` (`idItem` ASC) VISIBLE,
  INDEX `fk_Order_PaymentMethod1_idx` (`idPaymentMethod` ASC) VISIBLE,
  INDEX `fk_Order_DeliveryLocation1_idx` (`idDeliveryLocation` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Item1`
    FOREIGN KEY (`idItem`)
    REFERENCES `mydb`.`Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_PaymentMethod1`
    FOREIGN KEY (`idPaymentMethod`)
    REFERENCES `mydb`.`PaymentMethod` (`idPaymentMethod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_DeliveryLocation1`
    FOREIGN KEY (`idDeliveryLocation`)
    REFERENCES `mydb`.`DeliveryLocation` (`idDeliveryLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`Favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Favorites` (
  `idFavorites` INT NOT NULL,
  `idItem` INT NULL,
  `idPerson` INT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idFavorites`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `mydb`.`PersonOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PersonOrder` (
  `idPerson` INT NOT NULL,
  `idOrder` INT NOT NULL,
  `personType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPerson`, `idOrder`, `personType`),
  INDEX `fk_PersonOrder_Person_idx` (`idPerson` ASC) VISIBLE,
  INDEX `fk_PersonOrder_Order1_idx` (`idOrder` ASC) VISIBLE,
  CONSTRAINT `fk_PersonOrder_Person`
    FOREIGN KEY (`idPerson`)
    REFERENCES `mydb`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PersonOrder_Order1`
    FOREIGN KEY (`idOrder`)
    REFERENCES `mydb`.`Order` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
