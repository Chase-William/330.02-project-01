CREATE DATABASE IF NOT EXISTS `facultyResearch` DEFAULT CHARACTER SET utf8 ;
USE `facultyResearch` ;

-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `User` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(100) NULL,
  `LastName` VARCHAR(65) NULL,
  `FirstName` VARCHAR(65) NULL,
  `UserType` TINYINT NOT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Student` (
  `UserID` INT NOT NULL,
  PRIMARY KEY (`UserID`),
  CONSTRAINT `Student_User_fk`
    FOREIGN KEY (`UserID`)
    REFERENCES `User` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `Faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Faculty` (
  `UserID` INT NOT NULL,
  `BuildingNumber` INT NULL,
  `OfficeNumber` INT NULL,
  `Password` VARCHAR(100) NOT NULL,  
  PRIMARY KEY (`UserID`),
  CONSTRAINT `Professor_User1_fk`
    FOREIGN KEY (`UserID`)
    REFERENCES `User` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `Abstract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Abstract` (
  `AbstractID` INT NOT NULL,
  `Title` VARCHAR(65) NOT NULL,
  `FileName` VARCHAR(250) NULL UNIQUE,
  PRIMARY KEY (`AbstractID`))
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `UserAbstract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UserAbstract` (
  `UserID` INT NOT NULL,
  `AbstractID` INT NOT NULL,
  CONSTRAINT `fk_UserAbstract_User1`
    FOREIGN KEY (`UserID`)
    REFERENCES `User` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `UserAbstract_Abstract_fk`
    FOREIGN KEY (`AbstractID`)
    REFERENCES `Abstract` (`AbstractID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Author` (
  `AuthorID` INT NOT NULL,
  `FirstName` VARCHAR(65) NOT NULL,
  `LastName` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`AuthorID`))
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `AuthorAbstract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AuthorAbstract` (
  `AbstractID` INT NOT NULL,
  `AuthorID` INT NOT NULL,
  CONSTRAINT `AuthorAbstract_Abstract_fk`
    FOREIGN KEY (`AbstractID`)
    REFERENCES `Abstract` (`AbstractID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `AuthorAbstract_Author_fk`
    FOREIGN KEY (`AuthorID`)
    REFERENCES `Author` (`AuthorID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `Keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Keyword` (
  `KeywordID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`KeywordID`))
ENGINE = InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------------
-- Table `StudentKeyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `StudentKeyword` (
  `UserID` INT NOT NULL,
  `KeywordID` INT NOT NULL,
  CONSTRAINT `StudentKeyword_Student_fk`
    FOREIGN KEY (`UserID`)
    REFERENCES `Student` (`UserID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `StudentKeyword_Keyword_fk`
    FOREIGN KEY (`KeywordID`)
    REFERENCES `Keyword` (`KeywordID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8;