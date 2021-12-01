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


CALL insertFaculty("Jim", "Habermas", "jh0000@g.rit.edu", 130, 140, "ihavenopassword");
CALL insertFaculty("Leon", "West", "lw533@g.rit.edu", 130, 140, "s1v$c86gjil");
CALL insertFaculty("Kristin", "Valentine", "kv6870@g.rit.edu", 150, 150, "*s$9d*");
CALL insertFaculty("Leandro", "Douglas", "ld5126@g.rit.edu", 60, 130, "emz!b%mruo");
CALL insertFaculty("Rory", "Meza", "rm8227@g.rit.edu", 30, 190, "hur76!0n");
CALL insertFaculty("Virginia", "Holden", "vh113@g.rit.edu", 140, 30, "gsnwui");
CALL insertFaculty("Conrad", "Mack", "cm6011@g.rit.edu", 150, 70, "nzy9wl%r");
CALL insertFaculty("Leandro", "Burton", "lb2822@g.rit.edu", 180, 60, "^7zp8r4i5nqp%c");
CALL insertFaculty("Ansley", "Douglas", "ad5817@g.rit.edu", 160, 170, "pekdv7fz");
CALL insertFaculty("Cesar", "Young", "cy5495@g.rit.edu", 200, 120, "4w*lfpa");
CALL insertFaculty("Adonis", "Pitts", "ap2723@g.rit.edu", 60, 70, "n64qpnae");
CALL insertFaculty("Jaida", "Patel", "jp1636@g.rit.edu", 30, 140, "$#a$jfe3n79nn");
CALL insertFaculty("Michael", "Bennett", "mb1378@g.rit.edu", 40, 170, "n5vdgbg");
CALL insertFaculty("Jaida", "Holden", "jh8511@g.rit.edu", 50, 70, "2847rgz&g2u");
CALL insertFaculty("Elianna", "Roberson", "er3386@g.rit.edu", 60, 40, "nn*888y");
CALL insertFaculty("Kristin", "Dominguez", "kd9983@g.rit.edu", 20, 50, "sty8n&if");
CALL insertFaculty("Danna", "Hayes", "dh4664@g.rit.edu", 130, 10, "8n937cy^yj");
CALL insertFaculty("Leon", "Bell", "lb3756@g.rit.edu", 10, 140, "^ujgd93$q&w");
CALL insertFaculty("Dayana", "Taylor", "dt5552@g.rit.edu", 130, 100, "ff^tra");
CALL insertFaculty("Elise", "Orr", "eo1422@g.rit.edu", 190, 80, "i$%zp3%ei");
CALL insertFaculty("Jamison", "Snyder", "js5412@g.rit.edu", 150, 70, "aa07uha!9$2$w");
CALL insertFaculty("Luciano", "Pollard", "lp8070@g.rit.edu", 110, 70, "##w^slulu");
CALL insertFaculty("Cesar", "Burton", "cb7325@g.rit.edu", 50, 140, "8qhbd6h*j2j0");
CALL insertFaculty("Kendal", "Anderson", "ka719@g.rit.edu", 30, 190, "8zlw4#^yzh");
CALL insertFaculty("Sergio", "Shelton", "ss6304@g.rit.edu", 40, 200, "lvrjyvi");
CALL insertFaculty("Elise", "Jennings", "ej4786@g.rit.edu", 170, 110, "6$oyp@");
CALL insertFaculty("Adonis", "Meza", "am6406@g.rit.edu", 60, 190, "bwktp#nrf70");
CALL insertFaculty("Savannah", "Lindsey", "sl8406@g.rit.edu", 50, 10, "p&zyuu@j7p1*%");
CALL insertFaculty("Elliott", "Hawkins", "eh5584@g.rit.edu", 110, 120, "z92o78");
CALL insertFaculty("Regan", "West", "rw558@g.rit.edu", 10, 160, "4^ud55w*%");
CALL insertFaculty("Sergio", "Nolan", "sn6589@g.rit.edu", 50, 190, "l2^nf0t#o");
CALL insertFaculty("Ansley", "Vang", "av6465@g.rit.edu", 90, 130, "9l86db2y4q");
CALL insertFaculty("Rory", "Daniels", "rd1429@g.rit.edu", 180, 60, "g%23^%2ut9");
CALL insertFaculty("Alfredo", "Horn", "ah3695@g.rit.edu", 40, 130, "46@*o$f782");
CALL insertFaculty("Jessica", "Hawkins", "jh6053@g.rit.edu", 200, 50, "ztsqreqpi!h%0!");
CALL insertFaculty("Clinton", "Mack", "cm9379@g.rit.edu", 10, 160, "^5dngb4");
CALL insertFaculty("Ansley", "Duncan", "ad8345@g.rit.edu", 40, 60, "2$8tyrlcbzgv5");
CALL insertFaculty("Abbey", "Melendez", "am6982@g.rit.edu", 170, 120, "04g*ov");
CALL insertFaculty("Taylor", "Cantu", "tc6887@g.rit.edu", 80, 80, "48^7t6mvsk^");
CALL insertFaculty("Adalyn", "Riddle", "ar9764@g.rit.edu", 120, 130, "!wr9tqbj!u");
CALL insertFaculty("Elise", "Phillips", "ep3982@g.rit.edu", 170, 70, "vd90bpg10");
CALL insertFaculty("Bennett", "Mack", "bm5758@g.rit.edu", 190, 30, "!do2w53^48ce$");
CALL insertFaculty("Casey", "Bell", "cb4791@g.rit.edu", 100, 70, "p$u^&8usg0j6u");
CALL insertFaculty("Kendal", "Conley", "kc3366@g.rit.edu", 80, 30, "l40*z4vugj#");
CALL insertFaculty("Catalina", "Dominguez", "cd710@g.rit.edu", 170, 110, "aznvy@rov");
CALL insertFaculty("Jaida", "Daniels", "jd5813@g.rit.edu", 170, 40, "ab8c6*43s8a8bm");
CALL insertFaculty("Taylor", "Patel", "tp4440@g.rit.edu", 80, 100, "n8od9$");
CALL insertFaculty("Casey", "Pollard", "cp8615@g.rit.edu", 170, 110, "iuh^to39ybgij");
CALL insertFaculty("Abbey", "Mueller", "am3541@g.rit.edu", 180, 10, "b*&89nq6u3md");
CALL insertFaculty("Clinton", "Roberson", "cr1311@g.rit.edu", 70, 10, "y@qj82iw9h72r2");
CALL insertFaculty("Hugo", "Anderson", "ha9538@g.rit.edu", 190, 120, "cc8zw4lrfjc");

-- Inserting Abstracted related to faculty, using a literal for the facultyID in this file, java is dynamic
CALL insertAbstractWithAuthors(1, "Learn C and C++ by Samples", "Jim", "Habermas", NULL, NULL);
CALL insertAbstractWithAuthors(2, "C through Design", "George", "Defenbaugh", "Richard", "Smedley");
CALL insertAbstractWithAuthors(1, "Introduction to Computing and Programming in PYTHON - A Multimedia Approach", "Barbara", "Ericson", NULL, NULL);
CALL insertAbstractWithAuthors(3, "Data Structures and Program Design Using Java : A Self-Teaching Introduction", "D.", "Malhotra", "N.", "Malhotra");
CALL insertAbstractWithAuthors(4, "Exploring C++ 11", "Ray", "Lischner", NULL, NULL);
CALL insertAbstractWithAuthors(5, "Java Program Design: Principles, Polymorphism, and Patterns", "Edward", "Sciore", NULL, NULL);
CALL insertAbstractWithAuthors(6, "Practical C++ Design", "Adam", "Singer", NULL, NULL);
CALL insertAbstractWithAuthors(7, "Pro Python 3", "J.", "Browning", "Marty", "Alchin");
CALL insertAbstractWithAuthors(8, "Java: The Good Parts", "Jim", "Waldo", NULL, NULL);
CALL insertAbstractWithAuthors(8, "Advanced Algorithms and Data Structures", "Marcello", "Rocca", NULL, NULL);

CALL insertStudent("Regan", "Suarez", "rs404@g.rit.edu");
CALL insertStudent("Elise", "Holden", "eh6257@g.rit.edu");
CALL insertStudent("Kristin", "Bennett", "kb5499@g.rit.edu");
CALL insertStudent("Abel", "Bell", "ab6815@g.rit.edu");
CALL insertStudent("Ansley", "Duncan", "ad6626@g.rit.edu");
CALL insertStudent("Deven", "Conley", "dc887@g.rit.edu");
CALL insertStudent("Sergio", "Humphrey", "sh3831@g.rit.edu");
CALL insertStudent("Kamryn", "Shelton", "ks6501@g.rit.edu");
CALL insertStudent("Elliott", "Pitts", "ep1121@g.rit.edu");
CALL insertStudent("Leon", "Rich", "lr1386@g.rit.edu");
CALL insertStudent("Max", "Pierce", "mp5285@g.rit.edu");
CALL insertStudent("Jamison", "Bennett", "jb4917@g.rit.edu");
CALL insertStudent("Jamison", "Daniels", "jd2940@g.rit.edu");
CALL insertStudent("Savannah", "Mack", "sm6585@g.rit.edu");
CALL insertStudent("Casey", "Anderson", "ca3937@g.rit.edu");
CALL insertStudent("Joel", "Daniels", "jd7886@g.rit.edu");
CALL insertStudent("Savannah", "Everett", "se5362@g.rit.edu");
CALL insertStudent("Adonis", "Hayes", "ah139@g.rit.edu");
CALL insertStudent("Theresa", "Cantu", "tc1686@g.rit.edu");
CALL insertStudent("Kamryn", "Nolan", "kn9316@g.rit.edu");
CALL insertStudent("Kimberly", "Horn", "kh5360@g.rit.edu");
CALL insertStudent("Adonis", "Anderson", "aa4549@g.rit.edu");
CALL insertStudent("Luciano", "Pierce", "lp3468@g.rit.edu");
CALL insertStudent("Catalina", "Rich", "cr5119@g.rit.edu");
CALL insertStudent("Edgar", "Jennings", "ej7333@g.rit.edu");
CALL insertStudent("Juliana", "Holder", "jh959@g.rit.edu");
CALL insertStudent("Elise", "Parker", "ep1639@g.rit.edu");
CALL insertStudent("Abel", "Anderson", "aa7688@g.rit.edu");
CALL insertStudent("Savannah", "Holder", "sh8170@g.rit.edu");
CALL insertStudent("Kimberly", "Holden", "kh8025@g.rit.edu");
CALL insertStudent("Conrad", "Phillips", "cp5470@g.rit.edu");
CALL insertStudent("Dangelo", "Parker", "dp2544@g.rit.edu");
CALL insertStudent("Clinton", "Snyder", "cs1953@g.rit.edu");
CALL insertStudent("Adalyn", "Nolan", "an8697@g.rit.edu");
CALL insertStudent("Max", "Roberson", "mr3865@g.rit.edu");
CALL insertStudent("Sergio", "Snyder", "ss7887@g.rit.edu");
CALL insertStudent("Abbey", "Holden", "ah3609@g.rit.edu");
CALL insertStudent("Adalyn", "Rich", "ar4559@g.rit.edu");
CALL insertStudent("Max", "Douglas", "md7105@g.rit.edu");
CALL insertStudent("Moses", "Humphrey", "mh6172@g.rit.edu");
CALL insertStudent("Elise", "West", "ew2194@g.rit.edu");
CALL insertStudent("Elianna", "Daniels", "ed8160@g.rit.edu");
CALL insertStudent("Savannah", "Roberson", "sr3446@g.rit.edu");
CALL insertStudent("Joel", "Vang", "jv6057@g.rit.edu");
CALL insertStudent("Triston", "Roberson", "tr6377@g.rit.edu");
CALL insertStudent("Juliana", "Anderson", "ja8520@g.rit.edu");
CALL insertStudent("Kamryn", "Burton", "kb9530@g.rit.edu");
CALL insertStudent("Luciano", "Rich", "lr4460@g.rit.edu");
CALL insertStudent("Elianna", "Shelton", "es4452@g.rit.edu");
CALL insertStudent("Rory", "Cantu", "rc5606@g.rit.edu");