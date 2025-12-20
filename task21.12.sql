CREATE DATABASE Imdb
USE Imdb
CREATE TABLE Movies
(
Id INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50),
Point DECIMAL(18,2),
Duration DECIMAL(18,2)
DirectorId INT
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
SELECT * FROM Movies m
JOIN MovieDirectory md
ON md.DirectoryId=m.Id
JOIN MovieActors ma
ON ma.ActorId=m.Id
JOIN MovieGenres mg
ON mg.GenreId=m.Id
WHERE m.Point>6
--2.


