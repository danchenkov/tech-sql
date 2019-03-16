USE db_zoo;

DROP DATABASE db_lms;
CREATE DATABASE db_lms;
USE db_lms;

ALTER TABLE BOOK_AUTHORS DROP CONSTRAINT IF EXISTS fk_BA_BookID;
ALTER TABLE BOOK_COPIES DROP CONSTRAINT IF EXISTS fk_BC_BookID;
ALTER TABLE BOOK_COPIES DROP CONSTRAINT IF EXISTS fk_BC_BranchID;
ALTER TABLE BOOK_LOANS DROP CONSTRAINT IF EXISTS fk_BL_BookID;
ALTER TABLE BOOK_LOANS DROP CONSTRAINT IF EXISTS fk_BL_BranchID;
ALTER TABLE BOOK_LOANS DROP CONSTRAINT IF EXISTS fk_BL_CardNo;

DROP TABLE IF EXISTS LIBRARY_BRANCH;
DROP TABLE IF EXISTS BOOK_COPIES;
DROP TABLE IF EXISTS BOOKS;
DROP TABLE IF EXISTS BOOK_LOANS;
DROP TABLE IF EXISTS PUBLISHER;
DROP TABLE IF EXISTS BOOK_AUTHORS;
DROP TABLE IF EXISTS BORROWER;

DROP PROCEDURE IF EXISTS uspCopiesOfTitlesInBranch;
DROP PROCEDURE IF EXISTS uspCopiesOfTitlesByBranch;
DROP PROCEDURE IF EXISTS uspNamesOfBorrowersWithoutBooks;

CREATE TABLE LIBRARY_BRANCH (
	BranchID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	BranchName VARCHAR(64),
	Address VARCHAR(256)
);

CREATE TABLE BOOKS (
	BookID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Title VARCHAR(512),
	PublisherName VARCHAR(256)
);

CREATE TABLE BOOK_COPIES (
	BookID INT NOT NULL,
	BranchID INT NOT NULL,
	Number_Of_Copies INT,
	CONSTRAINT fk_BC_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID),
	CONSTRAINT fk_BC_BranchID FOREIGN KEY (BranchID) REFERENCES LIBRARY_BRANCH(BranchID)
);

CREATE TABLE PUBLISHER (
	PublisherName VARCHAR(256) PRIMARY KEY,
	Address TEXT,
	Phone VARCHAR(32)
);

CREATE TABLE BOOK_AUTHORS (
	BookID INT NOT NULL UNIQUE,
	AuthorName VARCHAR(64),
	CONSTRAINT fk_BA_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID)
);

CREATE TABLE BORROWER (
	CardNo INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(128),
	Address TEXT,
	Phone VARCHAR(32)
);

CREATE TABLE BOOK_LOANS (
	BookID INT NOT NULL,
	BranchID INT NOT NULL,
	CardNo INT NOT NULL,
	DateOut DATE,
	DateDue DATE,
	CONSTRAINT fk_BL_BookID FOREIGN KEY (BookID) REFERENCES BOOKS(BookID),
	CONSTRAINT fk_BL_BranchID FOREIGN KEY (BranchID) REFERENCES LIBRARY_BRANCH(BranchID),
	CONSTRAINT fk_BL_CardNo FOREIGN KEY (CardNo) REFERENCES BORROWER(CardNo)
);

-- There is a book called 'The Lost Tribe' found in the 'Sharpstown' branch.
INSERT INTO LIBRARY_BRANCH (BranchName, Address) VALUES ('Sharpstown', '865 Henry St., Leesburg, VA 20175');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('The Lost Tribe', 'Gold Label Publications');

-- There is a library branch called 'Sharpstown' and one called 'Central'.
INSERT INTO LIBRARY_BRANCH (BranchName, Address) VALUES ('Central', '881 Rockaway St., Collegeville, PA 19426');

-- There are at least 4 branches in the LIBRARY_BRANCH table.
INSERT INTO LIBRARY_BRANCH (BranchName, Address) VALUES ('Brilliance', '864 Manor Ave., Onalaska, WI 54650');
INSERT INTO LIBRARY_BRANCH (BranchName, Address) VALUES ('Dumb Reader', '81 East Devon Road, Cape Coral, FL 33904');

-- There are at least 20 books in the BOOK table.
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Amusing the Immortals', 'Press Brake Tool & Supply');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Descendant without Time', 'Sunstone Foundation');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Sailing into the Ocean', 'Louis Neibauer CO Inc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Dogs of the Solstice', 'Wastepaper Is My Bag');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Goal of Earth', 'Highline Times');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Curse of Glory', 'Long Island Boating World');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Spawn and Dream', 'Senior Publication-Free Snrty');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Perfection of the Banished', 'Fry Multimedia');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Blinded by the South', 'Nmp Information Svc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Butcher of the Nation', 'Bob Bratten');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('The Revolt and the Fire', 'Mediachef');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Blinded in the Mist', 'Dreamscapes');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Phantoms of the End', 'Grand Rapids Harley Owners Group');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Well of Path', 'Stephen Computer Svc Inc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Hunter of Dawn', 'City Social Inc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('A Glass Chased', 'Inside Prospects');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Blacksmiths and Giants', 'Onlinepublishers');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Robots of the Plague', 'Kris Limaye');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Slaves and Assassins', 'Equipment Controls');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Carnage of Power', 'Daniel Weinstock');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Bad Blood', 'Highline Times');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Big Stick', 'Long Island Boating World');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Choosing Happiness Even When Life Is Hard', 'Senior Publication-Free Snrty');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Every Breath', 'Fry Multimedia');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Extraordinary Lives: The Art and Craft of American Biography', 'Nmp Information Svc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('False Start', 'Bob Bratten');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Harry Potter and the Sorcerer''s Stone (Enhanced Edition)', 'Mediachef');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Love and Other Scandals', 'Dreamscapes');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Luck of the Devil', 'Grand Rapids Harley Owners Group');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Mission Critical', 'Stephen Computer Svc Inc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Sweet Liar', 'City Social Inc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('The Chef', 'Inside Prospects');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('The Good Living Guide to Natural and Herbal Remedies', 'Onlinepublishers');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('The Huntress', 'Kris Limaye');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('The Promise', 'Equipment Controls');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('The Statue of Liberty', 'Daniel Weinstock');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('The Threat', 'Stephen Computer Svc Inc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Vendetta in Death', 'Stephen Computer Svc Inc');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Wasted Justice', 'Stephen Computer Svc Inc');

-- There are at least 10 authors in the BOOK_AUTHORS table.
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (1, 'Drew Bonney');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (2, 'Glenys Rheinallt Moray');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (3, 'Ilene Irving');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (4, 'Nikole Joseph');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (5, 'Cullen Winterbottom');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (6, 'Delilah Hadaway');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (7, 'Dell Coombs');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (8, 'Ann Dina Pearson');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (9, 'Dane Leon Powers');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (10, 'Fingal Glenna Sterling');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (11, 'Gena Anderson');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (12, 'Lenox Murray Angus');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (13, 'Jordon Benton');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (14, 'Dewydd Marcas Graham');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (15, 'Gaynor Gladwyn');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (16, 'Phyliss Jernigan');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (17, 'Suzi Tolbert');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (18, 'Delilah Hadaway');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (19, 'Dane Leon Powers');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (20, 'Cullen Winterbottom');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (21, 'Andrew G. McCabe');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (22, 'Caroline Linden');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (23, 'Christian Blanchet & Bertrand Dard');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (24, 'Diane Capri');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (25, 'Frank Minirth');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (26, 'J. D. Robb');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (27, 'J.K. Rowling');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (28, 'James Patterson & Max DiLallo');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (29, 'John Carreyrou');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (30, 'Kate Quinn');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (31, 'Katolen Yardley');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (32, 'Laurelin Paige');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (33, 'Mark Greaney');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (34, 'Meghan March');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (35, 'Meli Raine');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (36, 'Nicholas Sparks');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (37, 'R.C. Stephens');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (38, 'R.L. Mathewson');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (39, 'William Zinsser');

-- Each library branch has at least 10 book titles, and at least two copies of each of those titles.
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 1, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 3, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 6, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 7, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 8, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 9, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 11, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 12, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 13, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 14, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 17, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 20, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 23, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 25, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 26, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 30, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 31, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 32, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 34, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 37, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 39, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (1, 40, 6)

INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 9, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 17, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 18, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 22, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 23, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 25, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 26, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 28, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 33, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 35, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 36, 3)

INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 1, 3);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 2, 5);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 3, 10);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 5, 2);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 6, 5);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 7, 5);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 8, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 8, 3);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 9, 10);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 10, 6);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 11, 2);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 12, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 12, 6);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 13, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 13, 8);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 14, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 14, 6);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 15, 10);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 16, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 16, 3);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 17, 5);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 18, 7);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 19, 4);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 20, 7);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 21, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 22, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 23, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 32, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 36, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 37, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 38, 3)

INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 1, 5);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 2, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 2, 6);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 3, 6);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 4, 10);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 4, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 5, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 5, 9);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 6, 7);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 7, 8);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 8, 4);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 9, 3);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 10, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 10, 8);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 11, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 11, 4);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 13, 10);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 13, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 14, 6);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 15, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 16, 5);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 17, 6);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 19, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 20, 8);
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 21, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 26, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 27, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 28, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 31, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 35, 3)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 38, 4)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 39, 2)


-- There must be at least two books written by 'Stephen King' located at the 'Central' branch.
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Fire Starter', 'Scribner/Simon & Schuster');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Dark Tower', 'Scribner/Simon & Schuster');
INSERT INTO BOOKS (Title, PublisherName) VALUES ('Shining', 'Scribner/Simon & Schuster');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (40, 'Stephen King');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (41, 'Stephen King');
INSERT INTO BOOK_AUTHORS (BookID, AuthorName) VALUES (42, 'Stephen King');
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 40, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 41, 2)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (2, 42, 2)

INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (3, 41, 8)
INSERT INTO BOOK_COPIES(BranchID, BookID, Number_Of_Copies) VALUES (4, 42, 3)

-- There are at least 8 borrowers in the BORROWER table, and at least 2 of those borrowers have more than 5 books loaned to them.
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Shad Bain', '3789 Diamond Cove, Honolulu, HW 02212', '(720) 242-7098');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Alton Alan', '7 Vermont Drive, Levittown, NY 11756', '(726) 457-6027');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Letitia Edgar', '3 Shipley Street, Piqua, OH 45356', '(894) 508-0050');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Shelly Gladwyn', '3 Forest Dr., Suite F, Millville, NJ 08332', '(915) 450-6082');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Dorothea Christian', '859 Bishop Avenue, Dickson, TN 37055', '(232) 595-9113');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Brant Bolton', '617 Forest Dr., Baltimore, MD 21206', '(561) 818-1149');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Malcom Winter', '39 West Ramblewood Lane, Neptune, NJ 07753', '(979) 522-5147');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Holly Chase', '72 Bradford Rd., Downers Grove, IL 60515', '(242) 565-7216');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Savannah Morriss', '8520 Willow St., West Deptford, NJ 08096', '(333) 989-5258');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Griselda Bartram', '497 Penn Rd., Chesapeake, VA 23320', '(826) 587-8244');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Milo Saunders', '553 Littleton Street, Farmingdale, NY 11735', '(844) 876-2282');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Booker Martinson', '8592 Brandywine St., North Attleboro, MA 02760', '(251) 952-9353');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Clare Linwood', '803 South Wood St., Royal Oak, MI 48067', '(272) 655-2317');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Bertram Hobson', '692 Beacon Street, Suwanee, GA 30024', '(823) 334-0309');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Chastity Lewis', '84 Trenton Street, Pensacola, FL 32503', '(935) 933-6399');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Tamera Homewood', '8622 Armstrong Ave., Bloomington, IN 47401', '(212) 305-2411');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Sharla Newton', '92 Middle River St., Muskogee, OK 74403', '(495) 885-4424');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Ezekiel Buckley', '192 Greenrose Lane, Glenside, PA 19038', '(543) 908-0430');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Adrianne Pope', '9238 Lakewood St., Ridgefield, CT 06877', '(760) 797-0451');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Valarie Fairclough', '62 Broad Street, Roswell, GA 30075', '(242) 755-6519');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Blanch Underwood', '8180 Paris Hill Road, Mocksville, NC 27028', '(634) 841-6529');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Bentley Verity', '44 Yukon Street, Cleveland, TN 37312', '(223) 646-8687');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Branden Blue', '8915 Thompson Street, Lynchburg, VA 24502', '(232) 975-2613');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Henry Carlyle', '967 Rocky River Drive, Clifton, NJ 07011', '(437) 357-3737');
INSERT INTO BORROWER (Name, Address, Phone) VALUES('Louisa Abney', '41 Chestnut Ave., North Bergen, NJ 07047', '(567) 271-5772');

INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 1, 14, DATEADD(DAY, -231, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 1, 18, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -26, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 1, 4, DATEADD(DAY, -22, GETDATE()), DATEADD(DAY, 2, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 1, 7, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 2, 11, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -44, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 2, 13, DATEADD(DAY, -26, GETDATE()), DATEADD(DAY, -41, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 2, 16, DATEADD(DAY, -12, GETDATE()), DATEADD(DAY, -11, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 2, 19, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -43, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 1, 13, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 1, 14, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 2, 1, DATEADD(DAY, -41, GETDATE()), DATEADD(DAY, -4, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 2, 11, DATEADD(DAY, -36, GETDATE()), DATEADD(DAY, -26, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 2, 17, DATEADD(DAY, -33, GETDATE()), DATEADD(DAY, -1, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 2, 2, DATEADD(DAY, -25, GETDATE()), DATEADD(DAY, -16, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 1, 10, DATEADD(DAY, -55, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 1, 18, DATEADD(DAY, -59, GETDATE()), DATEADD(DAY, -21, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 1, 19, DATEADD(DAY, -41, GETDATE()), DATEADD(DAY, -31, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 1, 4, DATEADD(DAY, -35, GETDATE()), DATEADD(DAY, -1, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 2, 11, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -16, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 2, 17, DATEADD(DAY, -19, GETDATE()), DATEADD(DAY, -7, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 2, 4, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -29, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 2, 6, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -44, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 2, 7, DATEADD(DAY, -51, GETDATE()), DATEADD(DAY, -26, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 2, 13, DATEADD(DAY, -58, GETDATE()), DATEADD(DAY, -23, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 2, 15, DATEADD(DAY, -60, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 2, 2, DATEADD(DAY, -55, GETDATE()), DATEADD(DAY, -34, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 2, 20, DATEADD(DAY, -60, GETDATE()), DATEADD(DAY, -15, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 2, 3, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 2, 7, DATEADD(DAY, -9, GETDATE()), DATEADD(DAY, -3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (5, 1, 15, DATEADD(DAY, -47, GETDATE()), DATEADD(DAY, -38, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (5, 2, 1, DATEADD(DAY, -48, GETDATE()), DATEADD(DAY, -41, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (5, 2, 4, DATEADD(DAY, -39, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (5, 2, 6, DATEADD(DAY, -9, GETDATE()), DATEADD(DAY, -6, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (6, 1, 12, DATEADD(DAY, -51, GETDATE()), DATEADD(DAY, -33, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (6, 1, 9, DATEADD(DAY, -59, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (6, 2, 14, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (6, 2, 18, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -37, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 1, 14, DATEADD(DAY, -23, GETDATE()), DATEADD(DAY, 3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 1, 7, DATEADD(DAY, -40, GETDATE()), DATEADD(DAY, -17, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 2, 12, DATEADD(DAY, -13, GETDATE()), DATEADD(DAY, -2, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 2, 13, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -27, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 2, 19, DATEADD(DAY, -24, GETDATE()), DATEADD(DAY, -21, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 2, 4, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -50, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (8, 1, 14, DATEADD(DAY, -15, GETDATE()), DATEADD(DAY, 0, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 1, 14, DATEADD(DAY, -15, GETDATE()), DATEADD(DAY, -14, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 1, 18, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -9, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 1, 4, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -29, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 1, 5, DATEADD(DAY, -53, GETDATE()), DATEADD(DAY, -49, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 2, 2, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -8, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 2, 20, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -39, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (10, 2, 16, DATEADD(DAY, -51, GETDATE()), DATEADD(DAY, -9, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (10, 2, 2, DATEADD(DAY, -34, GETDATE()), DATEADD(DAY, -22, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (10, 2, 3, DATEADD(DAY, -53, GETDATE()), DATEADD(DAY, -1, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (10, 2, 5, DATEADD(DAY, -58, GETDATE()), DATEADD(DAY, -53, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (11, 1, 19, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -7, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (11, 1, 5, DATEADD(DAY, -36, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (11, 2, 14, DATEADD(DAY, -31, GETDATE()), DATEADD(DAY, -8, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (11, 2, 2, DATEADD(DAY, -55, GETDATE()), DATEADD(DAY, -6, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 1, 13, DATEADD(DAY, -51, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 1, 17, DATEADD(DAY, -52, GETDATE()), DATEADD(DAY, -6, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 1, 8, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -23, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 2, 10, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 2, 2, DATEADD(DAY, -16, GETDATE()), DATEADD(DAY, -10, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 2, 8, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -43, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (13, 1, 5, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -19, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (13, 2, 14, DATEADD(DAY, -6, GETDATE()), DATEADD(DAY, -3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (13, 2, 20, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -10, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (13, 2, 6, DATEADD(DAY, -37, GETDATE()), DATEADD(DAY, -16, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (15, 1, 16, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -8, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (15, 1, 7, DATEADD(DAY, -39, GETDATE()), DATEADD(DAY, -25, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (15, 2, 16, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -14, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 1, 10, DATEADD(DAY, -36, GETDATE()), DATEADD(DAY, -14, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 1, 14, DATEADD(DAY, -57, GETDATE()), DATEADD(DAY, -26, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 1, 20, DATEADD(DAY, -9, GETDATE()), DATEADD(DAY, 3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 1, 8, DATEADD(DAY, -31, GETDATE()), DATEADD(DAY, -15, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 2, 1, DATEADD(DAY, -50, GETDATE()), DATEADD(DAY, -29, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 2, 17, DATEADD(DAY, -28, GETDATE()), DATEADD(DAY, -19, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 2, 4, DATEADD(DAY, -23, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 1, 10, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -32, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 1, 17, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 2, 13, DATEADD(DAY, -13, GETDATE()), DATEADD(DAY, -7, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 2, 15, DATEADD(DAY, -55, GETDATE()), DATEADD(DAY, -10, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 2, 18, DATEADD(DAY, -50, GETDATE()), DATEADD(DAY, -44, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (18, 2, 19, DATEADD(DAY, -48, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (18, 2, 7, DATEADD(DAY, -53, GETDATE()), DATEADD(DAY, -50, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 1, 14, DATEADD(DAY, -60, GETDATE()), DATEADD(DAY, -36, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 1, 16, DATEADD(DAY, -28, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 1, 2, DATEADD(DAY, -21, GETDATE()), DATEADD(DAY, -7, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 1, 6, DATEADD(DAY, -50, GETDATE()), DATEADD(DAY, -41, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 1, 9, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -31, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 2, 16, DATEADD(DAY, -22, GETDATE()), DATEADD(DAY, -6, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 2, 3, DATEADD(DAY, -37, GETDATE()), DATEADD(DAY, -34, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 2, 8, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -11, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 1, 1, DATEADD(DAY, -38, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 1, 10, DATEADD(DAY, -57, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 1, 19, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -15, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 2, 12, DATEADD(DAY, -18, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 2, 15, DATEADD(DAY, -53, GETDATE()), DATEADD(DAY, -38, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (21, 1, 19, DATEADD(DAY, -35, GETDATE()), DATEADD(DAY, -21, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 1, 12, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -18, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 1, 14, DATEADD(DAY, -41, GETDATE()), DATEADD(DAY, -19, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 1, 20, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 1, 9, DATEADD(DAY, -57, GETDATE()), DATEADD(DAY, -36, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 2, 13, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -39, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 2, 15, DATEADD(DAY, -41, GETDATE()), DATEADD(DAY, 0, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 2, 2, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -41, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (24, 2, 1, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -30, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (24, 2, 14, DATEADD(DAY, -33, GETDATE()), DATEADD(DAY, -24, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (25, 1, 1, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -27, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (25, 1, 20, DATEADD(DAY, -19, GETDATE()), DATEADD(DAY, -11, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (25, 2, 10, DATEADD(DAY, -22, GETDATE()), DATEADD(DAY, -11, GETDATE()));

INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 3, 1, DATEADD(DAY, -14, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 3, 2, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -26, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 3, 3, DATEADD(DAY, -22, GETDATE()), DATEADD(DAY, 2, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 3, 4, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 3, 5, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -44, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 3, 6, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -41, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 3, 7, DATEADD(DAY, -12, GETDATE()), DATEADD(DAY, -11, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 3, 8, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -43, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 3, 9, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 3, 1, DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, 103, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (5, 3, 1, DATEADD(DAY, -41, GETDATE()), DATEADD(DAY, -4, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (6, 3, 1, DATEADD(DAY, -36, GETDATE()), DATEADD(DAY, -26, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (6, 3, 1, DATEADD(DAY, -33, GETDATE()), DATEADD(DAY, -1, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 3, 1, DATEADD(DAY, -25, GETDATE()), DATEADD(DAY, -16, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 3, 1, DATEADD(DAY, -55, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 3, 1, DATEADD(DAY, -59, GETDATE()), DATEADD(DAY, -21, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 3, 1, DATEADD(DAY, -841, GETDATE()), DATEADD(DAY, -31, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 3, 1, DATEADD(DAY, -35, GETDATE()), DATEADD(DAY, -1, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 3, 2, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -16, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (11, 3, 2, DATEADD(DAY, -19, GETDATE()), DATEADD(DAY, -7, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (11, 3, 2, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -29, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 3, 2, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, 944, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 3, 2, DATEADD(DAY, -51, GETDATE()), DATEADD(DAY, -26, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 3, 2, DATEADD(DAY, -58, GETDATE()), DATEADD(DAY, -23, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (13, 3, 2, DATEADD(DAY, -60, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (15, 3, 2, DATEADD(DAY, -55, GETDATE()), DATEADD(DAY, -34, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (15, 3, 2, DATEADD(DAY, -960, GETDATE()), DATEADD(DAY,-15, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 3, 2, DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 3, 3, DATEADD(DAY, -33, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 3, 3, DATEADD(DAY, -9, GETDATE()), DATEADD(DAY, -3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 3, 3, DATEADD(DAY, -47, GETDATE()), DATEADD(DAY, -38, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 3, 3, DATEADD(DAY, -48, GETDATE()), DATEADD(DAY, 341, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 3, 3, DATEADD(DAY, -39, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 3, 3, DATEADD(DAY, -9, GETDATE()), DATEADD(DAY, -6, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 3, 3, DATEADD(DAY, -51, GETDATE()), DATEADD(DAY, -33, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 3, 4, DATEADD(DAY, -59, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 3, 4, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 3, 4, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -37, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (21, 3, 4, DATEADD(DAY, -23, GETDATE()), DATEADD(DAY, 3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (22, 3, 4, DATEADD(DAY, -40, GETDATE()), DATEADD(DAY, -17, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (22, 3, 4, DATEADD(DAY, -13, GETDATE()), DATEADD(DAY, -2, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 3, 4, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -27, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 3, 4, DATEADD(DAY, -24, GETDATE()), DATEADD(DAY, 21, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 3, 4, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, 50, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (25, 3, 5, DATEADD(DAY, -15, GETDATE()), DATEADD(DAY, -14, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (25, 3, 5, DATEADD(DAY, -233, GETDATE()), DATEADD(DAY, -9, GETDATE()));

INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 4, 3, DATEADD(DAY, -58, GETDATE()), DATEADD(DAY, -53, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 4, 10, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -7, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 4, 30, DATEADD(DAY, -36, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (1, 4, 23, DATEADD(DAY, -31, GETDATE()), DATEADD(DAY, -8, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 4, 22, DATEADD(DAY, -55, GETDATE()), DATEADD(DAY, -6, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 4, 36, DATEADD(DAY, -51, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 4, 22, DATEADD(DAY, -52, GETDATE()), DATEADD(DAY, -6, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (2, 4, 38, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -23, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 4, 36, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 4, 39, DATEADD(DAY, -16, GETDATE()), DATEADD(DAY, -10, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 4, 2, DATEADD(DAY, -56, GETDATE()), DATEADD(DAY, -43, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 4, 14, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -19, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (3, 4, 15, DATEADD(DAY, -6, GETDATE()), DATEADD(DAY, -3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 4, 24, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -10, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 4, 8, DATEADD(DAY, -37, GETDATE()), DATEADD(DAY, -16, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 4, 21, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -8, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 4, 22, DATEADD(DAY, -39, GETDATE()), DATEADD(DAY, -25, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 4, 21, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -14, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (4, 4, 16, DATEADD(DAY, -36, GETDATE()), DATEADD(DAY, -14, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (5, 4, 1, DATEADD(DAY, -57, GETDATE()), DATEADD(DAY, -26, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (5, 4, 20, DATEADD(DAY, -9, GETDATE()), DATEADD(DAY, 3, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (5, 4, 28, DATEADD(DAY, -31, GETDATE()), DATEADD(DAY, -15, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (6, 4, 14, DATEADD(DAY, -50, GETDATE()), DATEADD(DAY, -29, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (6, 4, 14, DATEADD(DAY, -28, GETDATE()), DATEADD(DAY, -19, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 4, 16, DATEADD(DAY, -23, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 4, 34, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -32, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 4, 26, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (7, 4, 34, DATEADD(DAY, -13, GETDATE()), DATEADD(DAY, -7, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 4, 5, DATEADD(DAY, -55, GETDATE()), DATEADD(DAY, -10, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (9, 4, 1, DATEADD(DAY, -50, GETDATE()), DATEADD(DAY, -44, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (10, 4, 39, DATEADD(DAY, -48, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (10, 4, 6, DATEADD(DAY, -53, GETDATE()), DATEADD(DAY, -50, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (10, 4, 18, DATEADD(DAY, -60, GETDATE()), DATEADD(DAY, -36, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (10, 4, 27, DATEADD(DAY, -28, GETDATE()), DATEADD(DAY, -20, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (11, 4, 38, DATEADD(DAY, -21, GETDATE()), DATEADD(DAY, -7, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (11, 4, 36, DATEADD(DAY, -50, GETDATE()), DATEADD(DAY, -41, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 4, 13, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -31, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 4, 19, DATEADD(DAY, -22, GETDATE()), DATEADD(DAY, -6, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (12, 4, 18, DATEADD(DAY, -37, GETDATE()), DATEADD(DAY, -34, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (13, 4, 22, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -11, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (13, 4, 25, DATEADD(DAY, -38, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (13, 4, 30, DATEADD(DAY, -57, GETDATE()), DATEADD(DAY, -42, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (15, 4, 15, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -15, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 4, 20, DATEADD(DAY, -18, GETDATE()), DATEADD(DAY, -5, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 4, 20, DATEADD(DAY, -53, GETDATE()), DATEADD(DAY, -38, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (16, 4, 1, DATEADD(DAY, -35, GETDATE()), DATEADD(DAY, -21, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 4, 17, DATEADD(DAY, -49, GETDATE()), DATEADD(DAY, -18, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 4, 12, DATEADD(DAY, -41, GETDATE()), DATEADD(DAY, -19, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (17, 4, 24, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -12, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (18, 4, 5, DATEADD(DAY, -57, GETDATE()), DATEADD(DAY, -36, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (18, 4, 2, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -39, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 4, 3, DATEADD(DAY, -41, GETDATE()), DATEADD(DAY, 0, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 4, 31, DATEADD(DAY, -54, GETDATE()), DATEADD(DAY, -41, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (19, 4, 14, DATEADD(DAY, -43, GETDATE()), DATEADD(DAY, -30, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 4, 12, DATEADD(DAY, -33, GETDATE()), DATEADD(DAY, -24, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (20, 4, 9, DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -27, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (22, 4, 16, DATEADD(DAY, -19, GETDATE()), DATEADD(DAY, -11, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (22, 4, 2, DATEADD(DAY, -22, GETDATE()), DATEADD(DAY, -11, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 4, 6, DATEADD(DAY, -46, GETDATE()), DATEADD(DAY, -19, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 4, 28, DATEADD(DAY, -40, GETDATE()), DATEADD(DAY, -37, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (23, 4, 31, DATEADD(DAY, -50, GETDATE()), DATEADD(DAY, -30, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (24, 4, 7, DATEADD(DAY, -57, GETDATE()), DATEADD(DAY, -48, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (24, 4, 16, DATEADD(DAY, -44, GETDATE()), DATEADD(DAY, -43, GETDATE()));
INSERT INTO BOOK_LOANS (CardNo, BranchID, BookID, DateOut, DateDue) VALUES (25, 4, 36, DATEADD(DAY, -31, GETDATE()), DATEADD(DAY, -9, GETDATE()));

-- There are at least 50 loans in the BOOK_LOANS table.
-- SELECT COUNT(*) FROM BOOK_LOANS;


-- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?
CREATE PROCEDURE uspCopiesOfTitlesInBranch @Title nvarchar(512) = NULL, @BranchName nvarchar(64) = NULL
AS
SELECT Number_Of_Copies FROM BOOK_COPIES bc INNER JOIN BOOKS bk ON bc.BookID = bk.BookID INNER JOIN LIBRARY_BRANCH br ON bc.BranchID = br.BranchID WHERE br.BranchName = ISNULL(@BranchName, BranchName) AND bk.Title = ISNULL(@Title, Title);
GO
EXEC uspCopiesOfTitlesInBranch @BranchName = 'Sharpstown', @Title = 'The Lost Tribe';

-- How many copies of the book titled "The Lost Tribe" are owned by each library branch?
CREATE PROCEDURE uspCopiesOfTitlesByBranch @Title nvarchar(512) = NULL
AS
SELECT BranchName, Number_Of_Copies FROM BOOK_COPIES bc INNER JOIN BOOKS bk ON bc.BookID = bk.BookID INNER JOIN LIBRARY_BRANCH br ON bc.BranchID = br.BranchID WHERE bk.Title = ISNULL(@Title, Title);
GO
EXEC uspCopiesOfTitlesByBranch @Title = 'The Lost Tribe';

-- Retrieve the names of all borrowers who do not have any books checked out.
CREATE PROCEDURE uspNamesOfBorrowersWithoutBooks @Title nvarchar(512) = NULL
AS
SELECT Name FROM BORROWER WHERE CardNo IN (SELECT b.CardNo FROM BOOK_LOANS bl RIGHT JOIN BORROWER b ON b.CardNo = bl.CardNo GROUP BY b.CardNo HAVING COUNT(BookID) = 0);
GO
EXEC uspNamesOfBorrowersWithoutBooks;

-- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.
CREATE PROCEDURE uspNamesOfBorrowersDueToday @BranchName nvarchar(64) = NULL
AS
SELECT br.BranchName, bk.Title, b.Name, b.Address FROM BOOK_LOANS bl INNER JOIN LIBRARY_BRANCH br ON bl.BranchID = br.BranchID INNER JOIN BOOKS bk ON bk.BookID = bl.BookID INNER JOIN BORROWER b ON bl.CardNo = b.CardNo WHERE br.BranchName = ISNULL(@BranchName, BranchName) AND DATEDIFF(DAY, GETDATE(), DateDue) = 0;
GO
EXEC uspNamesOfBorrowersDueToday @BranchName = 'Sharpstown';

-- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.
CREATE PROCEDURE uspTotalBooksBorrowed @BranchName nvarchar(64) = NULL
AS
SELECT br.BranchName, COUNT(*) FROM BOOK_LOANS bl INNER JOIN LIBRARY_BRANCH br ON bl.BranchID = br.BranchID WHERE br.BranchName = ISNULL(@BranchName, BranchName) GROUP BY br.BranchName;
GO
EXEC uspTotalBooksBorrowed;
-- EXEC uspTotalBooksBorrowed @BranchName = 'Sharpstown';


-- Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.
CREATE PROCEDURE uspAvidReaders @BooksLimit INT = 5
AS
SELECT b.Name, CAST(b.Address AS varchar(max)) AS Address, COUNT(bl.BookID) As TotalBooksCheckedOut FROM BORROWER b LEFT JOIN BOOK_LOANS bl ON b.CardNo = bl.CardNo GROUP BY b.Name, CAST(b.Address AS varchar(max)) HAVING COUNT(bl.BookID) > @BooksLimit;
GO
EXEC uspAvidReaders @BooksLimit = 5;


-- For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".
CREATE PROCEDURE uspAuthorTitlesInALibrary @AuthorName nvarchar(64) = 'Stephen King', @BranchName nvarchar(64) = 'Central'
AS
SELECT b.Title, bc.Number_Of_Copies FROM BOOKS b INNER JOIN BOOK_COPIES bc ON b.BookID = bc.BookID INNER JOIN LIBRARY_BRANCH lb ON bc.BranchID = lb.BranchID INNER JOIN BOOK_AUTHORS ba ON ba.BookID = b.BookID WHERE lb.BranchName = ISNULL(@BranchName, BranchName) AND ba.AuthorName LIKE '%' + ISNULL(@AuthorName, AuthorName) + '%';
GO
EXEC uspAuthorTitlesInALibrary @AuthorName = 'Stephen King', @BranchName = 'Central'


