USE netflix;

CREATE TABLE IF NOT EXISTS Movies (
Movie_ID INT PRIMARY KEY AUTO_INCREMENT,
Content_Type VARCHAR(30),
Movie_Title VARCHAR(300),
Release_Year YEAR,
IMDB_Rating DECIMAL(4,2),
IMDB_Votes INT );

INSERT INTO Movies (Movie_Title, Content_Type, Release_Year, IMDB_Rating, IMDB_Votes)
SELECT DISTINCT Movie_Title, Content_Type, Release_Year, IMDB_Rating, IMDB_Votes FROM data;


CREATE TABLE IF NOT EXISTS Genres(
Genre_ID INT PRIMARY KEY AUTO_INCREMENT,
Genre VARCHAR(100) UNIQUE );

INSERT INTO Genres (Genre)
SELECT DISTINCT Genres FROM data;


CREATE TABLE IF NOT EXISTS Movie_Genres (
Movie_ID INT,
Genre_ID INT,
PRIMARY KEY (Movie_ID, Genre_ID),
FOREIGN KEY (Movie_ID) REFERENCES Movies(Movie_ID),
FOREIGN KEY (Genre_ID) REFERENCES Genres(Genre_ID));
    
INSERT INTO  Movie_Genres (Movie_ID, Genre_ID)
SELECT DISTINCT m.Movie_ID, g.Genre_ID
FROM data d
JOIN Movies m ON d.Movie_Title = m.Movie_Title
JOIN Genres g ON d.Genres = g.Genre;


CREATE TABLE IF NOT EXISTS Movie_Countries (
Movie_ID INT,
Country_Code VARCHAR(10),
PRIMARY KEY (Movie_ID, Country_Code),
FOREIGN KEY (Movie_ID) REFERENCES Movies(Movie_ID));

INSERT INTO Movie_Countries (Movie_ID, Country_Code)
SELECT DISTINCT m.Movie_ID ,d.Available_Countries
FROM data d
JOIN Movies m ON m.Movie_Title= d.Movie_Title;


select * from genres;
select * from movie_countries;
select * from movie_genres;
select * from movies;

#Yaer wise count of movies
SELECT Release_Year,COUNT(DISTINCT Movie_Title) Movie_Count
FROM movies
GROUP BY Release_Year
ORDER BY Release_Year;

#genre wise count of movies
SELECT g.Genre,COUNT(DISTINCT m.Movie_Title) Movie_Count
FROM genres g
JOIN movie_genres mg ON mg.Genre_ID=g.Genre_ID
JOIN movies m ON m.Movie_ID = mg.Movie_ID
GROUP BY g.Genre
ORDER BY Movie_Count;

#Average IMDB rating of each genre
SELECT g.Genre,AVG(m.IMDB_Rating) Average_rating
FROM genres g
JOIN movie_genres mg ON mg.Genre_ID=g.Genre_ID
JOIN movies m ON m.Movie_ID = mg.Movie_ID 
GROUP BY g.Genre
ORDER BY Average_rating;