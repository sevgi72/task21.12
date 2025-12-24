CREATE DATABASE Imdb
USE Imdb
CREATE TABLE Movies
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50),
Point DECIMAL(18,2),
Duration DECIMAL(18,2),
DirectoryId INT
)
CREATE TABLE Directories
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50)
)
CREATE TABLE MovieDirectory
(
MovieId INT FOREIGN KEY REFERENCES Movies(Id),
DirectoryId INT FOREIGN KEY REFERENCES Directories(Id)
PRIMARY KEY(MovieId,DirectoryId)
)
CREATE TABLE Actors
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50)
)
CREATE TABLE MovieActors
(
MovieId INT FOREIGN KEY REFERENCES Movies(Id),
ActorId INT FOREIGN KEY REFERENCES Actors(Id)
)
CREATE TABLE Genres
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50)
)
CREATE TABLE MovieGenres
(
MovieId INT FOREIGN KEY REFERENCES Movies(Id),
GenreId INT FOREIGN KEY REFERENCES Genres(Id),
)

-- Movies
INSERT INTO Movies ([Name], Point, Duration)
VALUES
('Inception', 8.8, 148),
('The Dark Knight', 9.0, 152),
('Interstellar', 8.6, 169);

-- Directories (Directors)
INSERT INTO Directories ([Name])
VALUES
('Christopher Nolan'),
('Quentin Tarantino');

-- MovieDirectory
INSERT INTO MovieDirectory (MovieId, DirectoryId)
VALUES
(1, 1), -- Inception - Nolan
(2, 1), -- The Dark Knight - Nolan
(3, 1); -- Interstellar - Nolan

-- Actors
INSERT INTO Actors ([Name])
VALUES
('Leonardo DiCaprio'),
('Christian Bale'),
('Matthew McConaughey'),
('Heath Ledger');

-- MovieActors
INSERT INTO MovieActors (MovieId, ActorId)
VALUES
(1, 1), -- Inception - DiCaprio
(2, 2), -- The Dark Knight - Bale
(2, 4), -- The Dark Knight - Heath Ledger
(3, 3); -- Interstellar - McConaughey

-- Genres
INSERT INTO Genres ([Name])
VALUES
('Action'),
('Drama'),
('Sci-Fi');

-- MovieGenres
INSERT INTO MovieGenres (MovieId, GenreId)
VALUES
(1, 3), -- Inception - Sci-Fi
(1, 1), -- Inception - Action
(2, 1), -- The Dark Knight - Action
(2, 2), -- The Dark Knight - Drama
(3, 3), -- Interstellar - Sci-Fi
(3, 2); -- Interstellar - Drama
--1.
SELECT 
    m.Name AS MovieName,
    m.Point AS IMDBPoint,
    g.Name AS GenreName,
    d.Name AS DirectorName,
    a.Name AS ActorName
FROM Movies m
JOIN MovieDirectory md 
ON md.MovieId = m.Id
JOIN Directories d 
ON d.Id = md.DirectoryId
JOIN MovieActors ma 
ON ma.MovieId = m.Id
JOIN Actors a 
ON a.Id = ma.ActorId
JOIN MovieGenres mg 
ON mg.MovieId = m.Id
JOIN Genres g 
ON g.Id = mg.GenreId
WHERE m.Point > 6;


--2.
SELECT 
m.Name AS MovieName,
m.Point AS IMDBPoint,
g.Name AS GenreName
FROM Movies m
JOIN MovieGenres mg
ON m.Id=mg.MovieId
JOIN Genres g
ON g.Id=mg.GenreId
WHERE g.Name LIKE '%A%';


--3.
SELECT 
m.Name AS MovieName,
m.Point AS IMDBPoint,
m.Duration AS [Time],
g.Name AS GenreName
FROM Movies m
JOIN MovieGenres mg
ON m.Id=mg.MovieId
JOIN Genres g
ON g.Id=mg.GenreId
WHERE LEN(m.Name)>10 AND m.Name LIKE '%t'

--4.
SELECT 
m.Name AS MovieName,
m.Point AS IMDBPoint,
g.Name AS GenreName,
d.Name AS DirectorName,
a.Name AS ActorName
FROM Movies m
JOIN MovieDirectory md 
ON md.MovieId = m.Id
JOIN Directories d 
ON d.Id = md.DirectoryId
JOIN MovieActors ma 
ON ma.MovieId = m.Id
JOIN Actors a 
ON a.Id = ma.ActorId
JOIN MovieGenres mg 
ON mg.MovieId = m.Id
JOIN Genres g 
ON g.Id = mg.GenreId
WHERE m.Point > (SELECT AVG(Point) FROM Movies)
ORDER BY m.Point DESC



--2.TASK 
CREATE DATABASE Spotify
USE Spotify
CREATE TABLE Artists
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(20)
)
CREATE TABLE Albums
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(20)
);
ALTER TABLE Albums
ADD ArtistId INT
ALTER TABLE Albums
ADD FOREIGN KEY (ArtistId) REFERENCES Artists(Id)
CREATE TABLE Musics
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(30),
TotalSecond INT,
AlbumId INT FOREIGN KEY REFERENCES Albums(Id)
)
INSERT INTO Artists ([Name])
VALUES
('Adele'),
('Drake'),
('Taylor Swift');
INSERT INTO Albums ([Name], ArtistId)
VALUES
('25', 1),          -- Adele
('Scorpion', 2),    -- Drake
('Midnights', 3);   -- Taylor Swift
INSERT INTO Musics ([Name], TotalSecond, AlbumId)
VALUES
('Hello', 295, 1),
('Gods Plan', 198, 2),
('Anti-Hero', 200, 3),
('Blank Space', 231, 3);
--1.query
SELECT
    m.Name AS MusicName,
    m.TotalSecond,
    ar.Name AS ArtistName,
    al.Name AS AlbumName
FROM Musics m
JOIN Albums al
ON al.Id = m.AlbumId
JOIN Artists ar
ON ar.Id = al.ArtistId;
--2.query
SELECT
al.Name AS AlbumName,
(SELECT COUNT(*) FROM Musics m WHERE m.AlbumId=al.Id) AS MusicCount
FROM Albums al
