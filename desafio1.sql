-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-10-2019 a las 10:43:38
-- Versión del servidor: 10.1.29-MariaDB
-- Versión de PHP: 7.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `desafio1`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignar_franjas`
--

CREATE TABLE `asignar_franjas` (
  `Id` int(11) NOT NULL,
  `Id_aula` int(3) NOT NULL,
  `Id_franja` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Ocupada` tinyint(4) NOT NULL,
  `Profesor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignar_roles`
--

CREATE TABLE `asignar_roles` (
  `Id` int(11) NOT NULL,
  `Id_usuario` int(11) NOT NULL,
  `Id_rol` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `asignar_roles`
--

INSERT INTO `asignar_roles` (`Id`, `Id_usuario`, `Id_rol`) VALUES
(2, 13, 3),
(4, 14, 1),
(5, 15, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

CREATE TABLE `aula` (
  `Numero` int(3) NOT NULL,
  `Descripcion` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `aula`
--

INSERT INTO `aula` (`Numero`, `Descripcion`) VALUES
(103, 'Sala de Velocidad'),
(104, 'Sala de Fuerza'),
(105, 'Sala de Descanso'),
(106, 'Sala de Precision');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `franjas`
--

CREATE TABLE `franjas` (
  `Numero` int(11) NOT NULL,
  `Comienzo` varchar(5) NOT NULL,
  `Final` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `franjas`
--

INSERT INTO `franjas` (`Numero`, `Comienzo`, `Final`) VALUES
(1, '08:30', '09:25'),
(2, '09:25', '10:20'),
(3, '10:20', '11:15'),
(4, '11:45', '12:40'),
(5, '12:40', '13:35'),
(6, '13:35', '14:30'),
(7, '00:00', '22:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `Numero` int(2) NOT NULL,
  `Descripcion` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`Numero`, `Descripcion`) VALUES
(1, 'Profesor'),
(2, 'Administrador de Aula'),
(3, 'Administrador General');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Id` int(11) NOT NULL,
  `Correo` varchar(60) NOT NULL,
  `Clave` varchar(100) NOT NULL,
  `Nombre` varchar(50) NOT NULL,
  `Apellidos` varchar(50) NOT NULL,
  `Edad` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Id`, `Correo`, `Clave`, `Nombre`, `Apellidos`, `Edad`) VALUES
(2, 'a@a.a', '202cb962ac59075b964b07152d234b70', 'aaaa', 'asdgfhjk', 33),
(13, 'd@d.d', '202cb962ac59075b964b07152d234b70', 'dddddd', 'drhrdhrdh', 44),
(14, 'e@e.e', '827ccb0eea8a706c4c34a16891f84e7b', 'edsgfdgb', 'efegfewg', 44),
(15, 'b@b.b', '202cb962ac59075b964b07152d234b70', 'bbbbbb', 'bbbbbbbbbbbbbbbb', 12);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignar_franjas`
--
ALTER TABLE `asignar_franjas`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Id_aula` (`Id_aula`),
  ADD KEY `Id_franja` (`Id_franja`),
  ADD KEY `Profesor` (`Profesor`);

--
-- Indices de la tabla `asignar_roles`
--
ALTER TABLE `asignar_roles`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `Id_rol` (`Id_rol`),
  ADD KEY `Id_usuario` (`Id_usuario`);

--
-- Indices de la tabla `aula`
--
ALTER TABLE `aula`
  ADD PRIMARY KEY (`Numero`);

--
-- Indices de la tabla `franjas`
--
ALTER TABLE `franjas`
  ADD PRIMARY KEY (`Numero`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`Numero`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Id`,`Correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignar_roles`
--
ALTER TABLE `asignar_roles`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asignar_franjas`
--
ALTER TABLE `asignar_franjas`
  ADD CONSTRAINT `asignar_franjas_ibfk_1` FOREIGN KEY (`Id_aula`) REFERENCES `aula` (`Numero`),
  ADD CONSTRAINT `asignar_franjas_ibfk_2` FOREIGN KEY (`Id_franja`) REFERENCES `franjas` (`Numero`),
  ADD CONSTRAINT `asignar_franjas_ibfk_3` FOREIGN KEY (`Profesor`) REFERENCES `usuarios` (`Id`);

--
-- Filtros para la tabla `asignar_roles`
--
ALTER TABLE `asignar_roles`
  ADD CONSTRAINT `asignar_roles_ibfk_1` FOREIGN KEY (`Id_rol`) REFERENCES `rol` (`Numero`),
  ADD CONSTRAINT `asignar_roles_ibfk_2` FOREIGN KEY (`Id_usuario`) REFERENCES `usuarios` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
