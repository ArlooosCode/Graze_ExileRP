# Graze_ExileRP

Edited By K4R0L#2115



```SQL```
```lua
USE `essentialmode`;

CREATE TABLE `user_parkings` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) DEFAULT NULL,
  `garage` varchar(60) DEFAULT NULL,
  `zone` int(11) NOT NULL,
  `vehicle` longtext,

  PRIMARY KEY (`id`)
);
