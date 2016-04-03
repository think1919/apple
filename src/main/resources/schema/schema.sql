-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema beta1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema beta1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `betago` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema betago
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema betago
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `betago` DEFAULT CHARACTER SET utf8 ;
USE `betago` ;

-- -----------------------------------------------------
-- Table `betago`.`organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`organization` (
  `id`  INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `address` VARCHAR(255) NULL,
  `enabled` TINYINT(1) NULL,
  `description` VARCHAR(255) NULL,
  `parent` INT NULL,
  `create_time` TIMESTAMP NULL,
  `update_time` TIMESTAMP NULL,
  `type` VARCHAR(10) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_org_org_idx` (`parent` ASC),
  CONSTRAINT `fk_org_org`
    FOREIGN KEY (`parent`)
    REFERENCES `betago`.`organization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '组织机构';


-- -----------------------------------------------------
-- Table `betago`.`sys_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`sys_users` (
  `username` VARCHAR(40) NOT NULL,
  `password` VARCHAR(255) NULL,
  `enabled` TINYINT(1) NULL,
  `sex` TINYINT(1) NULL,
  `social_id` VARCHAR(40) NULL,
  `qq` VARCHAR(40) NULL,
  `phone` VARCHAR(11) NOT NULL,
  `email` VARCHAR(40) NULL,
  `description` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NULL,
  `update_time` TIMESTAMP NULL,
  `name` VARCHAR(80) NULL,
  PRIMARY KEY (`username`),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `social_id_UNIQUE` (`social_id` ASC))
ENGINE = InnoDB
COMMENT = '用户';


-- -----------------------------------------------------
-- Table `betago`.`job`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`job` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `create_time` TIMESTAMP NULL DEFAULT NULL,
  `update_time` TIMESTAMP NULL DEFAULT NULL,
  `grade` INT(11) NOT NULL DEFAULT '255',
  `organization_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_job_organization1_idx` (`organization_id` ASC),
  UNIQUE INDEX job_name_uindex (`name` ASC),
  CONSTRAINT `fk_job_organization1`
    FOREIGN KEY (`organization_id`)
    REFERENCES `betago`.`organization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8
COMMENT = '职务信息';




-- -----------------------------------------------------
-- Table `betago`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `description` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NULL,
  `update_time` TIMESTAMP NULL,
  `enabled` TINYINT(1) NULL,
  `grade` INT(11) NOT NULL DEFAULT '255',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
COMMENT = '权限组信息';


-- -----------------------------------------------------
-- Table `betago`.`authorities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`authorities` (
  `authority` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`authority`))
ENGINE = InnoDB
COMMENT = '角色';


-- -----------------------------------------------------
-- Table `betago`.`group_has_authorities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`group_has_authorities` (
  `group_id` INT NOT NULL,
  `authorities_authority` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`group_id`, `authorities_authority`),
  INDEX `fk_group_has_authorities_authorities1_idx` (`authorities_authority` ASC),
  INDEX `fk_group_has_authorities_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_group_has_authorities_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `betago`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_has_authorities_authorities1`
    FOREIGN KEY (`authorities_authority`)
    REFERENCES `betago`.`authorities` (`authority`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betago`.`job_has_sys_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`job_has_sys_users` (
  `job_id` INT NOT NULL,
  `sys_users_username` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`job_id`, `sys_users_username`),
  INDEX `fk_job_has_sys_users_sys_users1_idx` (`sys_users_username` ASC),
  INDEX `fk_job_has_sys_users_job1_idx` (`job_id` ASC),
  CONSTRAINT `fk_job_has_sys_users_job1`
    FOREIGN KEY (`job_id`)
    REFERENCES `betago`.`job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_job_has_sys_users_sys_users1`
    FOREIGN KEY (`sys_users_username`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betago`.`group_has_sys_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`group_has_sys_users` (
  `group_id` INT NOT NULL,
  `sys_users_username` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`group_id`, `sys_users_username`),
  INDEX `fk_group_has_sys_users_sys_users1_idx` (`sys_users_username` ASC),
  INDEX `fk_group_has_sys_users_group1_idx` (`group_id` ASC),
  CONSTRAINT `fk_group_has_sys_users_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `betago`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_has_sys_users_sys_users1`
    FOREIGN KEY (`sys_users_username`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `betago`.`log_group_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`log_group_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `sys_users_username` VARCHAR(40) NOT NULL,
  `event` VARCHAR(40) NULL,
  `description` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NULL,
  `operator` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_log_group_users_group1_idx` (`group_id` ASC),
  INDEX `fk_log_group_users_sys_users1_idx` (`sys_users_username` ASC),
  INDEX `fk_log_group_users_sys_users2_idx` (`operator` ASC),
  CONSTRAINT `fk_log_group_users_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `betago`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_group_users_sys_users1`
    FOREIGN KEY (`sys_users_username`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_group_users_sys_users2`
    FOREIGN KEY (`operator`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '组用户变更日志';


-- -----------------------------------------------------
-- Table `betago`.`log_job_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`log_job_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `job_id` INT NOT NULL,
  `sys_users_username` VARCHAR(40) NOT NULL,
  `event` VARCHAR(40) NULL,
  `description` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NULL,
  `operator` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_log_job_users_job1_idx` (`job_id` ASC),
  INDEX `fk_log_job_users_sys_users1_idx` (`sys_users_username` ASC),
  INDEX `fk_log_job_users_sys_users2_idx` (`operator` ASC),
  CONSTRAINT `fk_log_job_users_job1`
    FOREIGN KEY (`job_id`)
    REFERENCES `betago`.`job` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_job_users_sys_users1`
    FOREIGN KEY (`sys_users_username`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_job_users_sys_users2`
    FOREIGN KEY (`operator`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '职务变更日志';


-- -----------------------------------------------------
-- Table `betago`.`log_group_authorities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`log_group_authorities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `group_id` INT NOT NULL,
  `authorities_authority` VARCHAR(255) NOT NULL,
  `event` VARCHAR(40) NULL,
  `description` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NULL,
  `operator` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_log_group_authorities_group1_idx` (`group_id` ASC),
  INDEX `fk_log_group_authorities_authorities1_idx` (`authorities_authority` ASC),
  INDEX `fk_log_group_authorities_sys_users1_idx` (`operator` ASC),
  CONSTRAINT `fk_log_group_authorities_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `betago`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_group_authorities_authorities1`
    FOREIGN KEY (`authorities_authority`)
    REFERENCES `betago`.`authorities` (`authority`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_group_authorities_sys_users1`
    FOREIGN KEY (`operator`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '组权限变更日志';


-- -----------------------------------------------------
-- Table `betago`.`log_operate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`log_operate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `operator` VARCHAR(40) NOT NULL,
  `content` TEXT NULL,
  `create_time` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_log_operate_sys_users1_idx` (`operator` ASC),
  CONSTRAINT `fk_log_operate_sys_users1`
    FOREIGN KEY (`operator`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '普通数据更新 删除日志';


-- -----------------------------------------------------
-- Table `betago`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`region` (
  `id` VARCHAR(40) NOT NULL,
  `province` VARCHAR(40) NULL,
  `city` VARCHAR(40) NULL,
  `district` VARCHAR(40) NULL,
  `street` VARCHAR(40) NULL,
  `longitude` FLOAT NULL,
  `latitude` FLOAT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = '行政区划 地区信息';


-- -----------------------------------------------------
-- Table `betago`.`house`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`house` (
  `id` INT NOT NULL,
  `name` VARCHAR(40) NULL,
  `region_id` VARCHAR(40) NOT NULL,
  `address` VARCHAR(255) NULL,
  `acreage` INT NULL,
  `style` VARCHAR(40) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_house_region1_idx` (`region_id` ASC),
  CONSTRAINT `fk_house_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `betago`.`region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '楼盘信息';


-- -----------------------------------------------------
-- Table `betago`.`customer_resources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`customer_resources` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `sex` TINYINT(1) NOT NULL,
  `phone` VARCHAR(11) NULL,
  `source` VARCHAR(255) NULL,
  `resolve` VARCHAR(255) NULL,
  `blacklist` TINYINT(1) NULL,
  `house_id` INT NOT NULL,
  `reporter` VARCHAR(40) NOT NULL,
  `assigned_to` VARCHAR(40) NOT NULL,
  `create_time` TIMESTAMP NULL,
  `update_time` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_resources_house1_idx` (`house_id` ASC),
  INDEX `fk_customer_resources_sys_users1_idx` (`reporter` ASC),
  INDEX `fk_customer_resources_sys_users2_idx` (`assigned_to` ASC),
  CONSTRAINT `fk_customer_resources_house1`
    FOREIGN KEY (`house_id`)
    REFERENCES `betago`.`house` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_resources_sys_users1`
    FOREIGN KEY (`reporter`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_resources_sys_users2`
    FOREIGN KEY (`assigned_to`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '客户资源信息';


-- -----------------------------------------------------
-- Table `betago`.`log_resource_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`log_resource_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `customer_resources_id` INT NOT NULL,
  `assigned_to` VARCHAR(40) NOT NULL,
  `operator` VARCHAR(40) NOT NULL,
  `event` VARCHAR(40) NULL,
  `content` VARCHAR(255) NULL,
  `create_time` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_log_resource_user_customer_resources1_idx` (`customer_resources_id` ASC),
  INDEX `fk_log_resource_user_sys_users1_idx` (`assigned_to` ASC),
  INDEX `fk_log_resource_user_sys_users2_idx` (`operator` ASC),
  CONSTRAINT `fk_log_resource_user_customer_resources1`
    FOREIGN KEY (`customer_resources_id`)
    REFERENCES `betago`.`customer_resources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_resource_user_sys_users1`
    FOREIGN KEY (`assigned_to`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_resource_user_sys_users2`
    FOREIGN KEY (`operator`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '客户资源创建、分配以及解决操作日志';


-- -----------------------------------------------------
-- Table `betago`.`resource_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`resource_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `duty` VARCHAR(40) NULL,
  `customer_resources_id` INT NOT NULL,
  `sys_users_username` VARCHAR(40) NOT NULL,
  `enabled` TINYINT(1) NULL COMMENT '资源相关人员信息',
  `create_time` DATETIME NULL,
  `expired_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_resource_user_customer_resources1_idx` (`customer_resources_id` ASC),
  INDEX `fk_resource_user_sys_users1_idx` (`sys_users_username` ASC),
  CONSTRAINT `fk_resource_user_customer_resources1`
    FOREIGN KEY (`customer_resources_id`)
    REFERENCES `betago`.`customer_resources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_resource_user_sys_users1`
    FOREIGN KEY (`sys_users_username`)
    REFERENCES `betago`.`sys_users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `betago` ;

-- -----------------------------------------------------
-- Table `betago`.`clientdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`clientdetails` (
  `appId` VARCHAR(256) NOT NULL,
  `resourceIds` VARCHAR(256) NULL DEFAULT NULL,
  `appSecret` VARCHAR(256) NULL DEFAULT NULL,
  `scope` VARCHAR(256) NULL DEFAULT NULL,
  `grantTypes` VARCHAR(256) NULL DEFAULT NULL,
  `redirectUrl` VARCHAR(256) NULL DEFAULT NULL,
  `authorities` VARCHAR(256) NULL DEFAULT NULL,
  `access_token_validity` INT(11) NULL DEFAULT NULL,
  `refresh_token_validity` INT(11) NULL DEFAULT NULL,
  `additionalInformation` VARCHAR(4096) NULL DEFAULT NULL,
  `autoApproveScopes` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`appId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `betago`.`oauth_access_token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`oauth_access_token` (
  `token_id` VARCHAR(256) NULL DEFAULT NULL,
  `token` BLOB NULL DEFAULT NULL,
  `authentication_id` VARCHAR(256) NOT NULL,
  `user_name` VARCHAR(256) NULL DEFAULT NULL,
  `client_id` VARCHAR(256) NULL DEFAULT NULL,
  `authentication` BLOB NULL DEFAULT NULL,
  `refresh_token` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`authentication_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `betago`.`oauth_approvals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`oauth_approvals` (
  `userId` VARCHAR(256) NULL DEFAULT NULL,
  `clientId` VARCHAR(256) NULL DEFAULT NULL,
  `scope` VARCHAR(256) NULL DEFAULT NULL,
  `status` VARCHAR(10) NULL DEFAULT NULL,
  `expiresAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastModifiedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `betago`.`oauth_client_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`oauth_client_details` (
  `client_id` VARCHAR(256) NOT NULL,
  `resource_ids` VARCHAR(256) NULL DEFAULT NULL,
  `client_secret` VARCHAR(256) NULL DEFAULT NULL,
  `scope` VARCHAR(256) NULL DEFAULT NULL,
  `authorized_grant_types` VARCHAR(256) NULL DEFAULT NULL,
  `web_server_redirect_uri` VARCHAR(256) NULL DEFAULT NULL,
  `authorities` VARCHAR(256) NULL DEFAULT NULL,
  `access_token_validity` INT(11) NULL DEFAULT NULL,
  `refresh_token_validity` INT(11) NULL DEFAULT NULL,
  `additional_information` VARCHAR(4096) NULL DEFAULT NULL,
  `autoapprove` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `betago`.`oauth_client_token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`oauth_client_token` (
  `token_id` VARCHAR(256) NULL DEFAULT NULL,
  `token` BLOB NULL DEFAULT NULL,
  `authentication_id` VARCHAR(256) NOT NULL,
  `user_name` VARCHAR(256) NULL DEFAULT NULL,
  `client_id` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`authentication_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `betago`.`oauth_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`oauth_code` (
  `code` VARCHAR(256) NULL DEFAULT NULL,
  `authentication` BLOB NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `betago`.`oauth_refresh_token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betago`.`oauth_refresh_token` (
  `token_id` VARCHAR(256) NULL DEFAULT NULL,
  `token` BLOB NULL DEFAULT NULL,
  `authentication` BLOB NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




