create database movie_networking
use movie_networking
create table item(itemID int primary key, name varchar(50), title varchar(50) not null, mpparating varchar(4), popularity int, rating int default 10 check(rating>=0 and rating <=10));
create table movie(itemID int primary key, duration int check(duration >0), releaseDate date, endDate date, CONSTRAINT FK_MOVIE FOREIGN KEY (itemID) REFERENCES item(itemID) on delete cascade);
create table series(itemID int primary key, numberOfSeasons int default 1 check (numberOfSeasons >=1), starteDate date, endDate date, CONSTRAINT FK_SERIES FOREIGN KEY (itemID) REFERENCES item(itemID) on delete cascade);

create table season(itemID int , seasonNumber int check(seasonNumber>=1) default 1, startDate date, endDate date, overview varchar(400), CONSTRAINT FK_SEASON FOREIGN KEY (itemID) REFERENCES item(itemID) on delete cascade, CONSTRAINT PK_SEASON PRIMARY KEY (itemID,seasonNumber) );

create table episode(itemID int , seasonNumber int, episodeNumber int check(episodeNumber >=1) default 1, airingDate date, overview varchar(400),constraint FK_episode  foreign key(itemID, seasonNumber) references season(itemID, seasonNumber) on delete cascade,  CONSTRAINT PK_EPISODE PRIMARY KEY (itemID,seasonNumber, episodeNumber));


create table production_company(companyID int primary key, companyname varchar(70) unique, websiteLink varchar(100));
create table genre(genreID int primary key, genreName varchar(30) unique);
create table item_genre(itemID int FOREIGN KEY REFERENCES item(itemID), genreID int FOREIGN KEY REFERENCES genre(genreID) on delete cascade,CONSTRAINT PK_ITEM_GENRE PRIMARY KEY (itemID,genreID) );


create table video(videoID int primary key, link varchar(150), size int check(size >0), title varchar(100), fileExtension varchar(6), uploadDate date);
create table photo(photoID int primary key, link varchar(150), size int check(size >0), title varchar(100), fileExtension varchar(6), uploadDate date);

create table item_image(photoID int foreign key references photo(photoID) on delete cascade , itemID int foreign key references item(itemID) on delete cascade, constraint PK_PHOTO_ITEM primary key (photoID, itemID));
create table item_video(videoID int foreign key references video(videoID) on delete cascade , itemID int foreign key references item(itemID) on delete cascade, constraint PK_video_ITEM primary key (videoID, itemID));

create table person(personID int primary key, name varchar(100) not null, DOB date, gender varchar(1));
create table actor(personID int primary key, nickName varchar(50), dateOfDeath date, height decimal(4,2), background varchar(1000), constraint PK_ACTOR foreign key (personID) references person(personID) on delete cascade);
create table writer(personID int primary key, dateOfDeath date, background varchar(1000), constraint PK_WRITER foreign key (personID) references person(personID) on delete cascade);
create table director(personID int primary key, dateOfDeath date, background varchar(1000), constraint PK_DIRECTOR foreign key (personID) references person(personID) on delete cascade);
create table actor_castin_item(itemID int foreign key references item(itemID) on delete cascade, actorID int foreign key references actor(personID) on delete cascade, constraint PK_ACTOR_ITEM PRIMARY KEY (itemID, actorID));
create table writer_item(itemID int foreign key references item(itemID) on delete cascade, writerID int foreign key references writer(personID) on delete cascade, constraint PK_WRITER_ITEM PRIMARY KEY (itemID, writerID));
create table director_item(itemID int foreign key references item(itemID) on delete cascade, directorID int foreign key references director(personID) on delete cascade, constraint PK_DIRECTOR_ITEM PRIMARY KEY (itemID, directorID));

create table users(personID int primary key, email varchar(100), phone varchar(12), country varchar(30));
create table user_follow(followerID int, followingID INT, constraint FK_Following foreign key (followingID) references users(personID), followDate date, CONSTRAINT FK_FOLLOWER foreign key (followerID) references users(personID) on delete cascade, constraint PK_USER_FOLLOWER PRIMARY KEY (followerID, followingID) );
create table post(postID int primary key, text varchar(1000), postingDate date, deleteDate date, deleted char(1), reported char(1), userID int foreign key references users(personID) on delete cascade);
create table user_like_post(postID int foreign key references post(postID) on delete cascade, userID int foreign key references users(personID) on delete cascade, likeDate date, constraint PK_POST_USER_LIKE PRIMARY KEY (postID,userID));
create table comment(commentID int primary key, postID int foreign key references post(postID) on delete cascade ,userID int foreign key references users(personID) , commentText varchar(1000), reported char(1), deleted char(1));
create table review(reviewID int primary key, shareDate date, rate int check(rate>=0 and rate <11) default 10, reviewText varchar(1000), deleted char(1), reported char(1));
create table review_item_user(itemID int foreign key references item(itemID) on delete cascade, reviewID int foreign key references review(reviewID) on delete cascade, userID int foreign key references users(personID) on delete cascade, constraint PK_REVIEW_USER_ITEM primary key (reviewID, userID, itemID) );

---------------------------------------------------------------------

--INSERTION

INSERT INTO genre(genreID, genreName) VALUES (1001,'adventure'),(1002,'action'),(1003,'drama'),(1004,'romance'),(1005,'comedy'),(1006,'horror');

INSERT INTO item(itemID,name,title,mppaRating,popularity,rating) VALUES (1,'Harry Potter and the Deathly Hallows: Part 2','Harry Potter and the Deathly Hallows: Part 2','pg13',1,8);
INSERT INTO item(itemID,name,title,mppaRating,popularity,rating) VALUES (2,'Harry Potter and the Deathly Hallows: Part 1','Harry Potter and the Deathly Hallows: Part 1','pg13',2,9);
INSERT INTO item(itemID,name,title,mppaRating,popularity,rating) VALUES (3,'Pirates of the Caribbean: Curse of the Black Pearl','Pirates of the Caribbean: Curse of the Black Pearl','pg13',9,8);
INSERT INTO item(itemID,name,title,mppaRating,popularity,rating) VALUES (4,'Chernobyl','Chernobyl','TVMA',15,9);
INSERT INTO item(itemID,name,title,mppaRating,popularity,rating) VALUES (5,'The Sopranos','The Sopranos','TVMA',30,9);

INSERT INTO movie(itemID, duration, releaseDate) VALUES (1, 130 ,'2011-07-15' ), (2, 146 , '2010-11-19'), (3, 143 , '2003-07-09');


INSERT INTO series(itemID, numberOfSeasons, starteDate) VALUES (4, 1 ,'2019-05-06' ), (5, 6 , '2010-11-19');


INSERT INTO season(itemID, seasonNumber, startDate, overview) VALUES (4,1,'2019-05-06' , 'In April 1986, a huge explosion erupted at the Chernobyl nuclear power station in northern Ukraine. This series follows the stories of the men and women, who tried to contain the disaster, as well as those who gave their lives preventing a subsequent and worse one.'), (5,1, '1999-01-10' , 'An innovative look at the life of fictional Mafia Capo Tony Soprano, this serial is presented largely first person, but additional perspective is conveyed by the intimate conversations Tony has with his psychotherapist. We see Tony at work, at home, and in therapy. Moments of black comedy intersperse this aggressive, adult drama, with adult language, and extreme violence.'),(5,2, '2000-01-16' , 'An innovative look at the life of fictional Mafia Capo Tony Soprano, this serial is presented largely first person, but additional perspective is conveyed by the intimate conversations Tony has with his psychotherapist. We see Tony at work, at home, and in therapy. Moments of black comedy intersperse this aggressive, adult drama, with adult language, and extreme violence.')

INSERT INTO episode(itemID, seasonNumber, episodeNumber, airingDate, overview) VALUES (4,1,1,'2019-05-06','Plant workers and firefighters put their lives on the line to control a catastrophic April 1986 explosion at a Soviet nuclear power plant.'), (4,1,2,'2019-05-13','With untold millions at risk, Ulana makes a desperate attempt to reach Valery and warn him about the threat of a second explosion.'), (5,1,1,'1999-01-10','A mobster passes out at a family barbecue and seeks therapy to understand why.'), (5,2,1,'2000-01-16','Pussy returns after months in hiding, Chris starts a boiler room stock operation, and Tonys long-lost sister shows up on the doorstep.');

INSERT INTO production_company(companyID,companyname,websiteLink) VALUES (2001,'Home Box Office (HBO)','www.hbo.com'),(2002,'Warner Bros','www.warnerbros.com'),(2003,'Walt Disney Pictures','movies.disney.com');

INSERT INTO item_genre(itemID,genreID) VALUES(1,1001),(2,1001),(3,1001),(3,1002),(4,1003),(5,1003);

INSERT INTO video(videoID, uploadDate,link,size,title,fileExtension) VALUES (1,'2012-05-13','',12,'harrypotter-2','mp4'),(2,'2013-04-06','',16,'harrypotter-1','mp4'),(3,'2004-06-04','',30,'piratescarriebean-curse','mp4'),(4,'2019-09-13','',28,'chernobyl','mp4'),(5,'2000-07-12','',35,'sopranos','mp4');
INSERT INTO photo(photoID, uploadDate,link,size,title,fileExtension) VALUES (1,'2012-05-13','',2,'harrypotter-2','jpg'),(2,'2013-04-06','',3,'harrypotter-1','jpg'),(3,'2004-06-04','',1,'piratescarriebean-curse','png'),(4,'2019-09-13','',7,'chernobyl','png'),(5,'2000-07-12','',5,'sopranos','jpg');

INSERT INTO item_image(itemID, photoID) VALUES(1,1),(2,2),(3,3),(4,4),(5,5);
INSERT INTO item_video(itemID, videoID) VALUES(1,1),(2,2),(3,3),(4,4),(5,5);

INSERT INTO person(personID,name,DOB,gender) VALUES(1,'Daniell Radcliffe','1989-07-23','M'), (2,'Emma Watson','1990-04-15','F'),(3,'Rupert Grint','1988-08-24','M');
INSERT INTO person(personID,name,DOB,gender) VALUES(4,'Johnny Depp','1963-06-09','M'), (5,'Orlando Bloom','1977-01-13','M'),(6,'Keira Knightly','1985-03-26','F');
INSERT INTO person(personID,name,DOB,gender) VALUES(7,'Jessie Buckley','1989-09-18','F'), (8,'Jared Harris','1961-08-24','M'),(9,'Stellan Skarsgard','1951-06-13','M');
INSERT INTO person(personID,name,DOB,gender) VALUES(10,'James Gandolfini','1961-09-18','M'), (11,'Lorraine Bracco','1954-11-02','F'),(12,'Edie Falco','1963-07-05','M');

INSERT INTO person(personID,name, DOB,gender) VALUES (13,'J.K.Rowling','1965-07-31','F'),(14,'Ted Elliott','1961-07-04','M'),(15,'Craig Mazin','1971-04-08','M'),(16,'David Chase','1945-08-22','M')

INSERT INTO person(personID,name, DOB,gender) VALUES (17, 'David Yates','1963-10-08','M'),(18,'Gore Verbinski','1964-03-10','M'),(19, 'Johan Renck','1966-12-05','M'),(20,'Terence Winter','1960-10-02','M');

INSERT INTO person(personID,name, DOB,gender) VALUES (21,'Victor Baldwin','1945-09-11','M'), (22,'Scarlett Hawkins','1989-07-29','F'),(23,'Rashad Herrera','2004-03-15','M'),(24,'Nina Wiley','2002-11-23','F')

INSERT INTO actor(personID, nickname, dateOfDeath, height, background) VALUES(1,NULL,NULL,01.8,'PERSONAL INFO MISSING'), (2,NULL,NULL,01.8,'PERSONAL INFO MISSING'),(3,NULL,NULL,01.8,'PERSONAL INFO MISSING');
INSERT INTO actor(personID, nickname, dateOfDeath, height, background) VALUES(4,NULL,NULL,01.8,'PERSONAL INFO MISSING'), (5,NULL,NULL,01.8,'PERSONAL INFO MISSING'),(6,NULL,NULL,01.8,'PERSONAL INFO MISSING');
INSERT INTO actor(personID, nickname, dateOfDeath, height, background) VALUES(7,NULL,NULL,01.8,'PERSONAL INFO MISSING'), (8,NULL,NULL,01.8,'PERSONAL INFO MISSING'),(9,NULL,NULL,01.8,'PERSONAL INFO MISSING');
INSERT INTO actor(personID, nickname, dateOfDeath, height, background) VALUES(10,NULL,'2013-06-19',01.8,'PERSONAL INFO MISSING'), (11,NULL,NULL,01.8,'PERSONAL INFO MISSING'),(12,NULL,NULL,01.8,'PERSONAL INFO MISSING');

INSERT INTO actor_castin_item(itemId,actorID) VALUES (1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,4),(3,5),(3,6),(4,7),(4,8),(4,9),(5,10),(5,11),(5,12);

INSERT INTO writer(personID, dateOfDeath, background) VALUES (13,null,'Joanne Rowling was born in Yate, near Bristol, a few miles south of a town called Dursley. Her father Peter Rowling was an engineer for Rolls Royce in Bristol at this time. Her mother, Anne, was half-French and half-Scottish. They met on a train as it left Kings Cross Station in London.'),(14, null,'Ted Elliott was born on July 4, 1961 in Santa Ana, California, USA. He is a writer and producer, known for Shrek (2001), The Lone Ranger (2013) and Pirates of the Caribbean: The Curse of the Black Pearl (2003).'),(15,null,'Craig Mazin was born on April 8, 1971 in Brooklyn, New York, USA. He is a writer and producer, known for Chernobyl (2019), The Hangover Part II (2011) and Identity Thief (2013).'),(16,null,'Born in Mt. Vernon, New York, and raised in New Jersey, David Chase (born David DeCesare) dreamed of being a star drummer in a rock band! He spent many years playing drums and bass trying to be part of a successful rock band in the 1960s East Coast music scene. He also loved movies, such as The Public Enemy (1931) with James Cagney');

INSERT INTO writer_item(writerID, itemID) VALUES (13,1), (13,2),(14,3),(15,4),(16,5);

INSERT INTO director(personID, dateOfDeath, background) VALUES(17,null,'David Yates was born on October 8, 1963 in St. Helens, Merseyside, England. He is a director and producer, known for Harry Potter and the Deathly Hallows: Part 2 (2011), Harry Potter and the Order of the Phoenix (2007) and The Legend of Tarzan (2016).'),(18,null,'Gore Verbinski, one of American cinema most inventive directors who was a punk-rock guitarist as a teenager and had to sell his guitar to buy his first camera, is now the director of Pirates of the Caribbean: Dead Man Chest (2006) which made the industry record for highest opening weekend of all time ($135,600,000) and grossed over $1 billion'),(19,null, 'Johan Renck is one of the most respected and sought after directors of commercials and music videos today, so much so that the French magazine CB News dubbed him "the number one director of commercials and music videos in the world". His directing career started in 1992 when he joined the production company Mekano Film and Television in Stockholm,'),(20, null, 'Terence Winter was born on October 2, 1960 in Brooklyn, New York, USA. He is a producer and writer, known for The Sopranos (1999), The Wolf of Wall Street (2013) and Boardwalk Empire (2010).');

INSERT INTO director_item(itemID,directorID) VALUES(1,17),(2,17),(3,18),(4,19),(5,20);

('Victor Baldwin','tincidunt.congue.turpis@icloud.net','(766) 777-4787','Sweden'),
  ('Nina Wiley','fringilla.purus.mauris@icloud.com','(650) 338-9969','Chile'),
  ('Scarlett Hawkins','nec@outlook.org','1-149-679-2021','United Kingdom'),
  ('Rashad Herrera','dolor.dolor@icloud.org','1-223-121-9621','Vietnam'),
  ('Amethyst Navarro','nec.ante@aol.edu','(517) 883-8464','Canada');
INSERT INTO users(personID, email, phone, country) VALUES (21, 'tincidunt.congue.turpis@icloud.net','17667774787','Sweden'),(22,'nec@outlook.org','11496792021','United Kingdom'),(23, 'dolor.dolor@icloud.org','12231219621','Canada'),(24, 'fringilla.purus.mauris@icloud.com','16503389969','Chile');

INSERT INTO user_follow(followerID, followingID, followDate) VALUES (21,22,'2017-03-02'),(21,23,'2019-06-27'),(21,24, '2020-09-13'),(22,21,'2017-03-04'),(22,24, '2020-08-03'),(24,21,'2020-09-13'),(24,23,'2021-02-09')

INSERT INTO post(postID, text, postingDate, userID) VALUES (5001,'With great power comes great need to take a nap. Wake me up later.','2020-04-08',21),(5002,'You see, that’s the thing. It PROBABLY is fine. It’s PROBABLY 100% okay. There are PROBABLY no spiders in this headset.','2022-06-01',21),(5003,'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. ','2022-05-02',24)

INSERT INTO user_like_post(likeDate, userID, postID) VALUES ('2020-04-08',22,5001),('2020-04-08',23,5001),('2022-06-02',24,5002),('2022-05-04',21,5003)

INSERT INTO comment(postID, commentID, commentText, userID, reported, deleted) VALUES (5001,101,'that is true',22,'F','F'), (5001,102,'ok',24,'F','F'), (5002,103,'alrigth',24,'F','T')

INSERT INTO review(reviewID, rate,deleted,reported,shareDate,reviewText) VALUES (1,7,'F','F','2022-01-14','just have to watch it'), (2,7,'F','F','2020-06-22','cool'), (3,7,'F','F','2021-12-09','will watch it again'), (4,7,'F','F','2022-03-28','awesome')

INSERT INTO review_item_user(userID,reviewID,ItemID) VALUES (21,1,1),(21,3,2),(22,2,3),(24,4,5);
