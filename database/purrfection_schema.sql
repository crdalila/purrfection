-- MySQL Script generated by MySQL Workbench
-- Tue Apr  8 13:49:35 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema purrfection
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `purrfection` ;

-- -----------------------------------------------------
-- Schema purrfection
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `purrfection` DEFAULT CHARACTER SET utf8 ;
USE `purrfection` ;

-- -----------------------------------------------------
-- Table `purrfection`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `purrfection`.`user` ;

CREATE TABLE IF NOT EXISTS `purrfection`.`user` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(128) NOT NULL,
  `password` VARCHAR(80) NOT NULL,
  `role` ENUM('client', 'caretaker') NOT NULL DEFAULT 'client',
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `purrfection`.`cat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `purrfection`.`cat` ;

CREATE TABLE IF NOT EXISTS `purrfection`.`cat` (
  `cat_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `age` INT UNSIGNED NOT NULL,
  `neuter` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `comments` VARCHAR(255) NULL,
  `special_needs` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `breed` VARCHAR(45) NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `image` VARCHAR(300) NULL,
  PRIMARY KEY (`cat_id`),
  INDEX `fk_cat_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_cat_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `purrfection`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `purrfection`.`appointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `purrfection`.`appointment` ;

CREATE TABLE IF NOT EXISTS `purrfection`.`appointment` (
  `appoinment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `description` VARCHAR(255) NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`appoinment_id`),
  INDEX `fk_appointment_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `purrfection`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `purrfection`.`cat_has_appointment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `purrfection`.`cat_has_appointment` ;

CREATE TABLE IF NOT EXISTS `purrfection`.`cat_has_appointment` (
  `appoinment_id` INT UNSIGNED NOT NULL,
  `cat_id` INT UNSIGNED NOT NULL,
  INDEX `fk_cat_has_appointment_appointment1_idx` (`appoinment_id` ASC) VISIBLE,
  INDEX `fk_cat_has_appointment_cat1_idx` (`cat_id` ASC) VISIBLE,
  CONSTRAINT `fk_cat_has_appointment_appointment1`
    FOREIGN KEY (`appoinment_id`)
    REFERENCES `purrfection`.`appointment` (`appoinment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cat_has_appointment_cat1`
    FOREIGN KEY (`cat_id`)
    REFERENCES `purrfection`.`cat` (`cat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
