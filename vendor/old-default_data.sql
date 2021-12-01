DROP PROCEDURE IF EXISTS insertUser;
DROP PROCEDURE IF EXISTS insertFaculty;
DROP PROCEDURE IF EXISTS insertStudent;
DROP PROCEDURE IF EXISTS insertAbstractWithAuthors;
DROP PROCEDURE IF EXISTS insertKeyword;
DROP PROCEDURE IF EXISTS insertStudentKeyword;

DELIMITER $$

-- To be called by insertFaculty & insertStudent only!
CREATE PROCEDURE insertUser(
  IN firstName VARCHAR(65),
  IN lastName VARCHAR(65),
  IN email VARCHAR(100),
  IN userType TINYINT,
  OUT id INT
)
BEGIN
  -- Insert User
  INSERT 
    INTO User (FirstName, LastName, Email, UserType) 
      VALUES (firstName, lastName, email, userType);

  -- Out the id so callers can use
  SET id = @@identity;
END $$

-- Insert a Faculty and the backing User record
CREATE PROCEDURE insertFaculty(
  IN firstName VARCHAR(65),
  IN lastName VARCHAR(65),
  IN email VARCHAR(100),
  IN buildingNumber INT,
  IN officeNumber INT,
  IN password VARCHAR(100)
)
BEGIN
  -- Call insert for User and capture the id for the user
  CALL insertUser(firstName, lastName, email, 0, @id);

  INSERT
    INTO Faculty
      VALUES (@id, buildingNumber, officeNumber, password);

END $$

-- Insert a Student and the backing User record
CREATE PROCEDURE insertStudent(
  IN firstName VARCHAR(65),
  IN lastName VARCHAR(65),
  IN email VARCHAR(100)
)
BEGIN
  -- Call insert for User and capture the id for the user
  CALL insertUser(firstName, lastName, email, 1, @id);

  INSERT
    INTO Student
      VALUES (@id);

END $$

-- Inserts an abstract and must take atleast one author in the *first* author params. 
-- Adding a second author  via the *second* author params is optional.
CREATE PROCEDURE insertAbstractWithAuthors(
  IN facultyID INT,
  IN title VARCHAR(150),
  IN firstAuthorFirstName VARCHAR(65),
  IN firstAuthorLastName VARCHAR(65),
  IN secondAuthorFirstName VARCHAR(65),
  IN secondAuthorLastName VARCHAR(65)
)
BEGIN
  INSERT INTO Abstract (Title) 
    VALUES (title);
  SET @abID = @@identity;
  UPDATE Abstract 
    SET fileName = CONCAT("abstract-", @abID)
      WHERE AbstractID = @abID;

  INSERT INTO Author (FirstName, LastName) 
    VALUES(firstAuthorFirstName, firstAuthorLastName);
  SET @authID = @@identity;

  INSERT INTO AuthorAbstract 
    VALUES (@abID, @authID);

  -- Insert second Author if the values are not null
  IF !ISNULL(secondAuthorFirstName) THEN
    INSERT INTO Author (FirstName, LastName) 
      VALUES(secondAuthorFirstName, secondAuthorLastName);
    SET @authID = @@identity;
    INSERT INTO AuthorAbstract 
      VALUES (@abID, @authID);
  END IF;

  -- Insert UserAbstract
  INSERT INTO UserAbstract
    VALUES (facultyID, @abID);
END $$

-- Insert Keywords
CREATE PROCEDURE insertKeyword(
  IN Name VARCHAR(45),
  OUT keywordID INT
)
BEGIN
  INSERT INTO keyword (Name) 
  VALUES (Name);
  -- Out the id so callers can use
  SET @keywordID = @@identity;
END $$

-- Inserts student keywords
CREATE PROCEDURE insertStudentKeyword(
  IN UserID INT,
  IN Name VARCHAR(45)
)
BEGIN
  CALL insertKeyword(Name, @keywordID);
  
  -- Insert studentKeyword
  INSERT INTO studentkeyword
    VALUES (UserID, @keywordID);
END $$

DELIMITER ;
