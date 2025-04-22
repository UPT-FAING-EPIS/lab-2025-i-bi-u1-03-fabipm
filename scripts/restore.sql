-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Servidor:                     Microsoft SQL Server
-- --------------------------------------------------------

SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

-- Creando base de datos bdlab03
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'bdlab03')
BEGIN
    CREATE DATABASE [bdlab03] COLLATE SQL_Latin1_General_CP1_CI_AS;
END
GO

USE [bdlab03];
GO

-- Creando tabla archivo_csv
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[archivo_csv]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[archivo_csv] (
        [id_archivo] INT IDENTITY(1,1) NOT NULL,
        [nombre_archivo] NVARCHAR(255) NOT NULL,
        [fecha_subida] DATETIME NOT NULL DEFAULT GETDATE(),
        [ruta_archivo] NVARCHAR(255) NOT NULL,
        PRIMARY KEY ([id_archivo])
    );
END
GO

-- Creando tabla categoria_tecnologia
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[categoria_tecnologia]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[categoria_tecnologia] (
        [id_categoria] INT IDENTITY(1,1) NOT NULL,
        [nombre] NVARCHAR(255) NOT NULL,
        PRIMARY KEY ([id_categoria])
    );
END
GO

-- Insertando datos en categoria_tecnologia
SET IDENTITY_INSERT [dbo].[categoria_tecnologia] ON;
GO

MERGE INTO [dbo].[categoria_tecnologia] AS target
USING (VALUES
    (1, 'Lenguajes de programacion'),
    (2, 'Frameworks y Librerías'),
    (3, 'Bases de Datos'),
    (4, 'Plataformas de Nube e Infraestructura'),
    (5, 'Inteligencia Artificial'),
    (6, 'Calidad de Software'),
    (7, 'Big Data')
) AS source ([id_categoria], [nombre])
ON target.[id_categoria] = source.[id_categoria]
WHEN NOT MATCHED THEN
    INSERT ([id_categoria], [nombre]) VALUES (source.[id_categoria], source.[nombre]);
GO

SET IDENTITY_INSERT [dbo].[categoria_tecnologia] OFF;
GO

-- Creando tabla tecnologia
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tecnologia]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[tecnologia] (
        [id_tecnologia] INT IDENTITY(1,1) NOT NULL,
        [nombre] NVARCHAR(255) NOT NULL,
        [id_categoria] INT NULL,
        PRIMARY KEY ([id_tecnologia]),
        CONSTRAINT [fk_tecnologia_categoria] FOREIGN KEY ([id_categoria]) REFERENCES [categoria_tecnologia] ([id_categoria]) ON DELETE SET NULL
    );
END
GO

-- Insertando datos en tecnologia
SET IDENTITY_INSERT [dbo].[tecnologia] ON;
GO

MERGE INTO [dbo].[tecnologia] AS target
USING (VALUES
    (1, 'Java', 1),
    (2, 'Python', 1),
    (3, 'C#', 1),
    (4, 'JavaScript', 1),
    (5, 'R', 1),
    (6, 'PHP', 1),
    (7, 'Kotlin', 1),
    (8, 'C', 1),
    (9, 'C++', 1),
    (10, 'Spring', 2),
    (11, 'Django', 2),
    (12, 'React', 2),
    (13, 'ASP.NET', 2),
    (14, 'TensorFlow', 2),
    (15, 'Keras', 2),
    (16, 'Pandas', 2),
    (17, 'Matplotlib', 2),
    (18, 'Angular', 2),
    (19, 'Laravel', 2),
    (20, 'Flutter', 2),
    (21, 'React Native', 2),
    (22, 'OpenSSL', 2),
    (23, 'Flask', 2),
    (24, 'Arduino', 2),
    (25, 'Raspberry Pi', 2),
    (26, 'Unity', 2),
    (27, 'Unreal Engine', 2),
    (28, 'MySQL', 3),
    (29, 'PostgreSQL', 3),
    (30, 'MongoDB', 3),
    (31, 'Firebase', 3),
    (32, 'SQLite', 3),
    (33, 'AWS', 4),
    (34, 'Google Cloud', 4),
    (35, 'IBM Cloud', 4),
    (36, 'Microsoft Azure', 4),
    (37, 'DigitalOcean', 4),
    (38, 'Heroku', 4),
    (39, 'Azure', 4),
    (40, 'PyTorch', 5),
    (41, 'OpenCV', 5),
    (42, 'JUnit', 6),
    (43, 'Selenium', 6),
    (44, 'SonarQube', 6),
    (45, 'Hadoop', 7),
    (46, 'Spark', 7)
) AS source ([id_tecnologia], [nombre], [id_categoria])
ON target.[id_tecnologia] = source.[id_tecnologia]
WHEN NOT MATCHED THEN
    INSERT ([id_tecnologia], [nombre], [id_categoria]) VALUES (source.[id_tecnologia], source.[nombre], source.[id_categoria]);
GO

SET IDENTITY_INSERT [dbo].[tecnologia] OFF;
GO

-- Creando tabla universidad
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[universidad]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[universidad] (
        [id_universidad] INT IDENTITY(1,1) NOT NULL,
        [nombre] NVARCHAR(255) NOT NULL,
        [ubicacion] NVARCHAR(255) NOT NULL,
        [tipo] NVARCHAR(50) NOT NULL,
        PRIMARY KEY ([id_universidad])
    );
END
GO

-- Insertando datos en universidad
SET IDENTITY_INSERT [dbo].[universidad] ON;
GO

MERGE INTO [dbo].[universidad] AS target
USING (VALUES
    (1, 'Universidad Privada de Tacna', 'TACNA', 'PRIVADA'),
    (2, 'Universidad Nacional de San Agustín de Arequipa', 'Arequipa', 'PRIVADA'),
    (3, 'Universidad César Vallejo', 'Lima', 'PUBLICA'),
    (4, 'Universidad Nacional de Trujillo', 'Trujillo', 'PUBLICA'),
    (5, 'Universidad Privada del Norte', 'Lima', 'PRIVADA'),
    (6, 'Universidad de Ciencias y Empresariales', 'Cuzco', 'PRIVADA'),
    (7, 'Universidad Nacional Mayor de San Marcos', 'Lima', 'PUBLICA'),
    (8, 'Pontificia Universidad Católica del Perú', 'Lima', 'PRIVADA'),
    (9, 'Universidad Privada del Norte', 'Piura', 'PRIVADA'),
    (10, 'Universidad de San Martín de Porres', 'Lima', 'PRIVADA')
) AS source ([id_universidad], [nombre], [ubicacion], [tipo])
ON target.[id_universidad] = source.[id_universidad]
WHEN NOT MATCHED THEN
    INSERT ([id_universidad], [nombre], [ubicacion], [tipo]) VALUES (source.[id_universidad], source.[nombre], source.[ubicacion], source.[tipo]);
GO

SET IDENTITY_INSERT [dbo].[universidad] OFF;
GO

-- Creando tabla tesis
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tesis]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[tesis] (
        [id_tesis] INT IDENTITY(1,1) NOT NULL,
        [año_publicacion] INT NULL,
        [categoria] NVARCHAR(MAX) NULL,
        [id_universidad] INT NULL,
        PRIMARY KEY ([id_tesis]),
        CONSTRAINT [fk_tesis_universidad] FOREIGN KEY ([id_universidad]) REFERENCES [universidad] ([id_universidad]) ON DELETE SET NULL
    );
END
GO

-- Insertando datos en tesis
SET IDENTITY_INSERT [dbo].[tesis] ON;
GO

MERGE INTO [dbo].[tesis] AS target
USING (VALUES
    (1, 2024, 'Desarrollo de Software', 1),
    (2, 2023, 'Sistemas de Información', 2),
    (3, 2024, 'Inteligencia Artificial', 3),
    (4, 2023, 'Análisis de Datos', 4),
    (5, 2024, 'Desarrollo de Aplicaciones Web', 5),
    (6, 2023, 'Aplicaciones Móviles', 6),
    (7, 2024, 'Seguridad Informática', 7),
    (8, 2023, 'Internet de las Cosas (IoT)', 8),
    (9, 2024, 'Big Data y Cloud Computing', 5),
    (10, 2023, 'Desarrollo de Videojuegos', 10)
) AS source ([id_tesis], [año_publicacion], [categoria], [id_universidad])
ON target.[id_tesis] = source.[id_tesis]
WHEN NOT MATCHED THEN
    INSERT ([id_tesis], [año_publicacion], [categoria], [id_universidad]) VALUES (source.[id_tesis], source.[año_publicacion], source.[categoria], source.[id_universidad]);
GO

SET IDENTITY_INSERT [dbo].[tesis] OFF;
GO

-- Creando tabla tesis_tecnologia
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tesis_tecnologia]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[tesis_tecnologia] (
        [id_tesis] INT NOT NULL,
        [id_tecnologia] INT NOT NULL,
        PRIMARY KEY ([id_tesis], [id_tecnologia]),
        CONSTRAINT [fk_tesis_tecnologia_tesis] FOREIGN KEY ([id_tesis]) REFERENCES [tesis] ([id_tesis]),
        CONSTRAINT [fk_tesis_tecnologia_tecnologia] FOREIGN KEY ([id_tecnologia]) REFERENCES [tecnologia] ([id_tecnologia])
    );
END
GO

-- Insertando datos en tesis_tecnologia
INSERT INTO [dbo].[tesis_tecnologia] ([id_tesis], [id_tecnologia])
SELECT 1, 1 UNION ALL
SELECT 1, 2 UNION ALL
SELECT 1, 10 UNION ALL
SELECT 1, 11 UNION ALL
SELECT 1, 28 UNION ALL
SELECT 1, 33 UNION ALL
SELECT 1, 34 UNION ALL
SELECT 1, 42 UNION ALL
SELECT 1, 43 UNION ALL
SELECT 2, 3 UNION ALL
SELECT 2, 4 UNION ALL
SELECT 2, 12 UNION ALL
SELECT 2, 13 UNION ALL
SELECT 2, 29 UNION ALL
SELECT 2, 33 UNION ALL
SELECT 2, 39 UNION ALL
SELECT 2, 44 UNION ALL
SELECT 3, 2 UNION ALL
SELECT 3, 14 UNION ALL
SELECT 3, 15 UNION ALL
SELECT 3, 30 UNION ALL
SELECT 3, 34 UNION ALL
SELECT 3, 35 UNION ALL
SELECT 4, 2 UNION ALL
SELECT 4, 5 UNION ALL
SELECT 4, 16 UNION ALL
SELECT 4, 17 UNION ALL
SELECT 4, 30 UNION ALL
SELECT 4, 33 UNION ALL
SELECT 4, 36 UNION ALL
SELECT 4, 45 UNION ALL
SELECT 4, 46 UNION ALL
SELECT 5, 4 UNION ALL
SELECT 5, 6 UNION ALL
SELECT 5, 18 UNION ALL
SELECT 5, 19 UNION ALL
SELECT 5, 28 UNION ALL
SELECT 5, 37 UNION ALL
SELECT 5, 38 UNION ALL
SELECT 5, 42 UNION ALL
SELECT 6, 1 UNION ALL
SELECT 6, 7 UNION ALL
SELECT 6, 20 UNION ALL
SELECT 6, 21 UNION ALL
SELECT 6, 31 UNION ALL
SELECT 6, 34 UNION ALL
SELECT 7, 2 UNION ALL
SELECT 7, 8 UNION ALL
SELECT 7, 22 UNION ALL
SELECT 7, 23 UNION ALL
SELECT 7, 28 UNION ALL
SELECT 7, 33 UNION ALL
SELECT 7, 36 UNION ALL
SELECT 8, 2 UNION ALL
SELECT 8, 9 UNION ALL
SELECT 8, 24 UNION ALL
SELECT 8, 25 UNION ALL
SELECT 8, 32 UNION ALL
SELECT 8, 33 UNION ALL
SELECT 8, 34 UNION ALL
SELECT 9, 1 UNION ALL
SELECT 9, 2 UNION ALL
SELECT 9, 29 UNION ALL
SELECT 9, 33 UNION ALL
SELECT 9, 34 UNION ALL
SELECT 9, 39 UNION ALL
SELECT 9, 45 UNION ALL
SELECT 9, 46 UNION ALL
SELECT 10, 2 UNION ALL
SELECT 10, 9 UNION ALL
SELECT 10, 26 UNION ALL
SELECT 10, 27 UNION ALL
SELECT 10, 29 UNION ALL
SELECT 10, 33 UNION ALL
SELECT 10, 34;
GO
