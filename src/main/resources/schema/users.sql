
INSERT INTO `betago`.`sys_users` (`username`, `password`, `enabled`, `sex`, `social_id`, `phone`, `email`, `description`, `name`)
 VALUES ('think', '$2a$10$Unsd.vVsD6F2bGxrnGdONO3pfIWRJ4u3dN4PVzXE3FN0/wMnpX5Ca', '1', '1', '457008802', '18950197603', 'zscgrhg@qq.com', '李文魁', '李文魁');
INSERT INTO `betago`.`sys_users` (`username`, `password`, `enabled`, `sex`, `phone`, `description`, `name`)
VALUES ('zjl', '$10$Unsd.vVsD6F2bGxrnGdONO3pfIWRJ4u3dN4PVzXE3FN0/wMnpX5Ca', '1', '1', '10000000000', 'zjl', 'zjl');

 INSERT INTO `betago`.`group` (`id`,`name`,`grade`, `description`, `enabled`) VALUES ('1','dev','0', '开发', '1');
 INSERT INTO `betago`.`group` (`id`, `name`, `grade`,`description`, `enabled`) VALUES ('2', 'default','255', '普通注册用户', '1');

INSERT INTO `betago`.`authorities` (`authority`, `description`) VALUES ('ROLE_dev', 'dev');
INSERT INTO `betago`.`authorities` (`authority`, `description`) VALUES ('ROLE_user', 'user');
INSERT INTO `betago`.`group_has_authorities` (`group_id`, `authorities_authority`) VALUES ('1', 'ROLE_dev');
INSERT INTO `betago`.`group_has_authorities` (`group_id`, `authorities_authority`) VALUES ('1', 'ROLE_user');
INSERT INTO `betago`.`group_has_sys_users` (`group_id`, `sys_users_username`) VALUES ('1', 'think');
INSERT INTO `betago`.`group_has_sys_users` (`group_id`, `sys_users_username`) VALUES ('1', 'zjl');
INSERT INTO `betago`.`group_has_authorities` (`group_id`, `authorities_authority`) VALUES ('2', 'ROLE_user');

