SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `WSO2CDM` DEFAULT CHARACTER SET latin1 ;
USE `WSO2CDM` ;

-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_DEVICE_TYPE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_DEVICE_TYPE` (
  `ID` INT(11) NOT NULL ,
  `NAME` VARCHAR(300) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_DEVICE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_DEVICE` (
  `ID` VARCHAR(20) NOT NULL ,
  `DESCRIPTION` TEXT NULL DEFAULT NULL ,
  `NAME` VARCHAR(100) NULL DEFAULT NULL ,
  `DATE_OF_ENROLLMENT` BIGINT(20) NULL DEFAULT NULL ,
  `DATE_OF_LAST_UPDATE` BIGINT(20) NULL DEFAULT NULL ,
  `OWNERSHIP` VARCHAR(45) NULL DEFAULT NULL ,
  `STATUS` VARCHAR(15) NULL DEFAULT NULL ,
  `DEVICE_TYPE_ID` INT(11) NULL DEFAULT NULL ,
  `DEVICE_IDENTIFICATION` VARCHAR(300) NULL DEFAULT NULL ,
  `OWNER` VARCHAR(45) NULL DEFAULT NULL ,
  `TENANT_ID` INT(11) NULL DEFAULT '0' ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_DM_DEVICE_DM_DEVICE_TYPE2` (`DEVICE_TYPE_ID` ASC) ,
  CONSTRAINT `fk_DM_DEVICE_DM_DEVICE_TYPE2`
    FOREIGN KEY (`DEVICE_TYPE_ID` )
    REFERENCES `WSO2CDM`.`DM_DEVICE_TYPE` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_PROFILE`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_PROFILE` (
  `ID` INT NOT NULL AUTO_INCREMENT ,
  `PROFILE_NAME` VARCHAR(45) NOT NULL ,
  `TENANT_ID` INT NOT NULL ,
  `CREATED_TIME` DATETIME NOT NULL ,
  `UPDATED_TIME` DATETIME NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_POLICY`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_POLICY` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `NAME` VARCHAR(45) NULL DEFAULT NULL ,
  `TENANT_ID` INT(11) NOT NULL ,
  `PROFILE_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `FK_DM_PROFILE_DM_POLICY` (`PROFILE_ID` ASC) ,
  CONSTRAINT `FK_DM_PROFILE_DM_POLICY`
    FOREIGN KEY (`PROFILE_ID` )
    REFERENCES `WSO2CDM`.`DM_PROFILE` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_DEVICE_POLICY`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_DEVICE_POLICY` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `DEVICE_ID` INT(11) NOT NULL ,
  `POLICY_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `FK_POLICY_DEVICE_POLICY` (`POLICY_ID` ASC) ,
  CONSTRAINT `FK_POLICY_DEVICE_POLICY`
    FOREIGN KEY (`POLICY_ID` )
    REFERENCES `WSO2CDM`.`DM_POLICY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_DEVICE_TYPE_POLICY`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_DEVICE_TYPE_POLICY` (
  `ID` INT(11) NOT NULL ,
  `DEVICE_TYPE_ID` INT(11) NOT NULL ,
  `POLICY_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `FK_DEVICE_TYPE_POLICY` (`POLICY_ID` ASC) ,
  INDEX `FK_DEVICE_TYPE_POLICY_DEVICE_TYPE` (`DEVICE_TYPE_ID` ASC) ,
  CONSTRAINT `FK_DEVICE_TYPE_POLICY`
    FOREIGN KEY (`POLICY_ID` )
    REFERENCES `WSO2CDM`.`DM_POLICY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEVICE_TYPE_POLICY_DEVICE_TYPE`
    FOREIGN KEY (`DEVICE_TYPE_ID` )
    REFERENCES `WSO2CDM`.`DM_DEVICE_TYPE` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_FEATURES`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_FEATURES` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `NAME` VARCHAR(256) NOT NULL ,
  `CODE` VARCHAR(45) NULL DEFAULT NULL ,
  `DESCRIPTION` TEXT NULL DEFAULT NULL ,
  `EVALUVATION_RULE` VARCHAR(60) NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_POLICY_FEATURES`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_POLICY_FEATURES` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT ,
  `PROFILE_ID` INT(11) NOT NULL ,
  `FEATURE_ID` INT(11) NOT NULL ,
  `CONTENT` BLOB NULL DEFAULT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_DM_POLICY_FEATURES_DM_FEATURES1` (`FEATURE_ID` ASC) ,
  INDEX `FK_DM_PROFILE_DM_POLICY_FEATURES` (`PROFILE_ID` ASC) ,
  CONSTRAINT `fk_DM_POLICY_FEATURES_DM_FEATURES1`
    FOREIGN KEY (`FEATURE_ID` )
    REFERENCES `WSO2CDM`.`DM_FEATURES` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DM_PROFILE_DM_POLICY_FEATURES`
    FOREIGN KEY (`PROFILE_ID` )
    REFERENCES `WSO2CDM`.`DM_PROFILE` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_ROLE_POLICY`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_ROLE_POLICY` (
  `ID` INT(11) NOT NULL ,
  `ROLE_NAME` VARCHAR(45) NOT NULL ,
  `POLICY_ID` INT(11) NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `FK_ROLE_POLICY_POLICY` (`POLICY_ID` ASC) ,
  CONSTRAINT `FK_ROLE_POLICY_POLICY`
    FOREIGN KEY (`POLICY_ID` )
    REFERENCES `WSO2CDM`.`DM_POLICY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_LOCATION`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_LOCATION` (
  `LAT` VARCHAR(45) NOT NULL ,
  `LONG` VARCHAR(45) NOT NULL ,
  `POLICY_ID` INT(11) NOT NULL ,
  INDEX `FK_DM_POLICY_DM_LOCATION` (`POLICY_ID` ASC) ,
  CONSTRAINT `FK_DM_POLICY_DM_LOCATION`
    FOREIGN KEY (`POLICY_ID` )
    REFERENCES `WSO2CDM`.`DM_POLICY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `WSO2CDM`.`DM_TIME`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `WSO2CDM`.`DM_TIME` (
  `STARTING_TIME` DATETIME NOT NULL ,
  `ENDING_TIME` DATETIME NOT NULL ,
  `POLICY_ID` INT(11) NOT NULL ,
  INDEX `FK_DM_POLICY_DM_TIME` (`POLICY_ID` ASC) ,
  CONSTRAINT `FK_DM_POLICY_DM_TIME`
    FOREIGN KEY (`POLICY_ID` )
    REFERENCES `WSO2CDM`.`DM_POLICY` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
