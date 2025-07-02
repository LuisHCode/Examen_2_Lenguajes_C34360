SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
--
-- Base de datos: `examen`
--
CREATE DATABASE IF NOT EXISTS `examen` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `examen`;

-- --------------------------------------------------------
CREATE TABLE `admin` (
  `idUsuario` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` VARCHAR(100),
  `direccion` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;


CREATE TABLE `alumno` (
  `idUsuario` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_Ingreso` DATE NOT NULL,
  `celular` VARCHAR(10),
  `genero` CHAR(1),
  `carrera` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` VARCHAR(100),
  `direccion` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE `profesor` (
  `idUsuario` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_Ingreso` DATE NOT NULL,
  `telefono` VARCHAR(10),
  `genero` CHAR(1),
  `curso` VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` VARCHAR(100),
  `direccion` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE `persona` (
  `idUsuario` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecha_Ingreso` DATE NOT NULL,
  `telefono` VARCHAR(10),
  `celular` VARCHAR(10) NOT NULL,
  `genero` CHAR(1) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE `socio` (
  `idUsuario`		VARCHAR (15) NOT NULL,
  `nombre`		VARCHAR(40) NOT NULL,
  `apellido1`	VARCHAR(15) NOT NULL,
  `apellido2`	VARCHAR(15) NOT NULL,
  `fechaNac`	DATE NOT NULL,
  `telefono`	VARCHAR(10),
  `celular`		VARCHAR(10) NOT NULL,
  `correo` 	VARCHAR (100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

CREATE TABLE doctor (
  `idUsuario` VARCHAR(15) NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `especialidad` VARCHAR (25) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(10),
  `celular` VARCHAR(10) NOT NULL,
  `ultima_consulta` DATE,
  `direccion` VARCHAR(100)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

  ALTER TABLE `doctor`
  ADD PRIMARY KEY (`idUsuario`);

  ALTER TABLE `socio`
  ADD PRIMARY KEY (`idUsuario`);

  ALTER TABLE `persona`
  ADD PRIMARY KEY (`idUsuario`);

  ALTER TABLE `alumno`
  ADD PRIMARY KEY (`idusuario`);

  ALTER TABLE `profesor`
  ADD PRIMARY KEY (`idUsuario`);


-- COMMIT;

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` varchar(15) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `rol` int NOT NULL,
  `passw` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `ultimoAcceso` datetime DEFAULT NULL,
  `tkR` varchar(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Índices para tablas volcadas
--

ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `idx_Correo` (`correo`);

COMMIT;

USE examen;

DROP FUNCTION IF EXISTS modificarToken;
DROP PROCEDURE IF EXISTS verificarTokenR;

DELIMITER $$

CREATE FUNCTION modificarToken (_idUsuario VARCHAR(100), _tkR varchar(255)) RETURNS INT(1) 
READS SQL DATA DETERMINISTIC
begin
    declare _cant int;
    select count(idUsuario) into _cant from usuario where idUsuario = _idUsuario or correo = _idUsuario;
    if _cant > 0 then
        update usuario set
                tkR = _tkR
                where idUsuario = _idUsuario or correo = _idUsuario;
        if _tkR <> "" then
            update usuario set
                ultimoAcceso = now()
                where idUsuario = _idUsuario or correo = _idUsuario;
        end if;
    end if;
    return _cant;
end$$

CREATE PROCEDURE verificarTokenR (_idUsuario VARCHAR(15), _tkR varchar(255)) 
begin
    select rol from usuario where idUsuario = _idUsuario and tkR = _tkR;
end$$

DELIMITER ;


INSERT INTO Admin(idUsuario, nombre, correo, direccion) 
values (12345, "Luis West", "luis@west", "Cieneguita");

INSERT INTO usuario(idUsuario, correo, rol, passw) 
values (12345, "luis@west", 1, "$2y$10$fC69KeDpsRIeqOSD1pGOMeSTjd3y8MafyIjkcBaxhX312SXKQtWmy");

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
