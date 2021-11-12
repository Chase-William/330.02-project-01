DROP PROCEDURE IF EXISTS insertUser;
DROP PROCEDURE IF EXISTS insertFaculty;
DROP PROCEDURE IF EXISTS insertStudent;

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

DELIMITER ;

CALL insertFaculty("Quoc", "Roth", "******@g.rit.edu", 10, 20, "mypassword");
CALL insertStudent("Rachel", "Nhan", "*****@g.rit.edu");