USE `redemrp`;

INSERT INTO `items` (`itemid`, `name`, `description`, `weight`, `imgsrc`) VALUES
(1, 'Japko', 'Zajebiste japuszko ', 45, 'items/wide-blade-knife.png'),
(2, 'Kości do gry', 'Można za ich pomocą grać w kości.', 10, 'items/bolas-thrown.png');

ALTER TABLE `items`
  ADD PRIMARY KEY (`itemid`),
  MODIFY `itemid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;