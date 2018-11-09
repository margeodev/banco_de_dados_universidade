-- MySQL Script generated by MySQL Workbench
-- Fri Nov  9 10:21:52 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_faculdade` DEFAULT CHARACTER SET utf8 ;
USE `db_faculdade` ;

-- -----------------------------------------------------
-- Table `db_faculdade`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`departamento` (
  `id_departamento` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nome_departamento` VARCHAR(45) NULL,
  PRIMARY KEY (`id_departamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`professor` (
  `id_professor` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nome_professor` VARCHAR(45) NULL,
  `sobrenome_professor` VARCHAR(45) NULL,
  `status` TINYINT NULL,
  `departamento_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_professor`),
  INDEX `fk_professor_departamento1_idx` (`departamento_id` ASC),
  CONSTRAINT `fk_professor_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `db_faculdade`.`departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`curso` (
  `id_curso` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nome_curso` VARCHAR(45) NULL,
  `departamento_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_curso`),
  INDEX `fk_curso_departamento1_idx` (`departamento_id` ASC),
  CONSTRAINT `fk_curso_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `db_faculdade`.`departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`turma` (
  `id_turma` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `pediodo` CHAR(2) NULL,
  `num_alunos` INT NULL,
  `data_inicio` DATE NULL,
  `data_fim` DATE NULL,
  `curso_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_turma`, `curso_id`),
  INDEX `fk_turma_curso1_idx` (`curso_id` ASC),
  CONSTRAINT `fk_turma_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `db_faculdade`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`aluno` (
  `id_aluno` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nome_aluno` VARCHAR(45) NULL,
  `sobrenome_aluno` VARCHAR(45) NULL,
  `status` TINYINT NULL,
  `nome_do_pai` VARCHAR(45) NULL,
  `nome_da_mae` VARCHAR(45) NULL,
  `sexo` CHAR(1) NULL,
  `cpf` VARCHAR(11) NULL,
  `email` VARCHAR(45) NULL,
  `whatsapp` VARCHAR(45) NULL,
  `curso_id` BIGINT(20) NOT NULL,
  `turma_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_aluno`),
  INDEX `fk_aluno_curso1_idx` (`curso_id` ASC),
  INDEX `fk_aluno_turma1_idx` (`turma_id` ASC),
  CONSTRAINT `fk_aluno_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `db_faculdade`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_turma1`
    FOREIGN KEY (`turma_id`)
    REFERENCES `db_faculdade`.`turma` (`id_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`disciplina` (
  `id_disciplina` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `nome_disciplina` VARCHAR(45) NULL,
  `descricao` VARCHAR(255) NULL,
  `numero_alunos` INT NULL,
  `carga_horaria` INT NULL,
  `departamento_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_disciplina`),
  INDEX `fk_disciplina_departamento1_idx` (`departamento_id` ASC),
  CONSTRAINT `fk_disciplina_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `db_faculdade`.`departamento` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`historico` (
  `id_historico` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `data_inicio` DATE NULL,
  `data_fim` DATE NULL,
  `aluno_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_historico`),
  INDEX `fk_historico_aluno1_idx` (`aluno_id` ASC),
  CONSTRAINT `fk_historico_aluno1`
    FOREIGN KEY (`aluno_id`)
    REFERENCES `db_faculdade`.`aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`prof_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`prof_disciplina` (
  `professor_id` BIGINT(20) NOT NULL,
  `disciplina_id` BIGINT(20) NOT NULL,
  INDEX `fk_prof_disciplina_professor1_idx` (`professor_id` ASC),
  INDEX `fk_prof_disciplina_disciplina1_idx` (`disciplina_id` ASC),
  PRIMARY KEY (`professor_id`, `disciplina_id`),
  CONSTRAINT `fk_prof_disciplina_professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `db_faculdade`.`professor` (`id_professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prof_disciplina_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_faculdade`.`disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`curso_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`curso_disciplina` (
  `curso_id` BIGINT(20) NOT NULL,
  `disciplina_id` BIGINT(20) NOT NULL,
  INDEX `fk_curso_disciplina_curso1_idx` (`curso_id` ASC),
  INDEX `fk_curso_disciplina_disciplina1_idx` (`disciplina_id` ASC),
  PRIMARY KEY (`curso_id`, `disciplina_id`),
  CONSTRAINT `fk_curso_disciplina_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `db_faculdade`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_disciplina_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_faculdade`.`disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`disciplina_historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`disciplina_historico` (
  `historico_id` BIGINT(20) NOT NULL,
  `disciplina_id` BIGINT(20) NOT NULL,
  `nota` DECIMAL(10,2) NULL,
  `frequencia` INT NULL,
  INDEX `fk_disciplina_historico_historico1_idx` (`historico_id` ASC),
  INDEX `fk_disciplina_historico_disciplina1_idx` (`disciplina_id` ASC),
  CONSTRAINT `fk_disciplina_historico_historico1`
    FOREIGN KEY (`historico_id`)
    REFERENCES `db_faculdade`.`historico` (`id_historico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disciplina_historico_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_faculdade`.`disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`aluno_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`aluno_disciplina` (
  `aluno_id` BIGINT(20) NOT NULL,
  `disciplina_id` BIGINT(20) NOT NULL,
  INDEX `fk_aluno_disciplina_aluno1_idx` (`aluno_id` ASC),
  INDEX `fk_aluno_disciplina_disciplina1_idx` (`disciplina_id` ASC),
  PRIMARY KEY (`aluno_id`, `disciplina_id`),
  CONSTRAINT `fk_aluno_disciplina_aluno1`
    FOREIGN KEY (`aluno_id`)
    REFERENCES `db_faculdade`.`aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_disciplina_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `db_faculdade`.`disciplina` (`id_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tipo_telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tipo_telefone` (
  `id_tipo_telefone` BIGINT(20) NOT NULL,
  `tipo_telefone` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipo_telefone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`telefone_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`telefone_aluno` (
  `id_telefone_aluno` BIGINT(20) NOT NULL,
  `numero_telefone` VARCHAR(20) NULL,
  `tipo_telefone_id` BIGINT(20) NOT NULL,
  `aluno_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_telefone_aluno`, `tipo_telefone_id`),
  INDEX `fk_telefone_aluno_tipo_telefone1_idx` (`tipo_telefone_id` ASC),
  INDEX `fk_telefone_aluno_aluno1_idx` (`aluno_id` ASC),
  CONSTRAINT `fk_telefone_aluno_tipo_telefone1`
    FOREIGN KEY (`tipo_telefone_id`)
    REFERENCES `db_faculdade`.`tipo_telefone` (`id_tipo_telefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefone_aluno_aluno1`
    FOREIGN KEY (`aluno_id`)
    REFERENCES `db_faculdade`.`aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`tipo_logradouro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`tipo_logradouro` (
  `id_tipo_logradouro` BIGINT(20) NOT NULL,
  `tipo_logradouro` VARCHAR(45) NULL,
  PRIMARY KEY (`id_tipo_logradouro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_faculdade`.`endereco_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_faculdade`.`endereco_aluno` (
  `id_endereco_aluno` BIGINT(20) NOT NULL,
  `rua` VARCHAR(45) NULL,
  `numero` VARCHAR(45) NULL,
  `complemento` VARCHAR(45) NULL,
  `cep` VARCHAR(45) NULL,
  `tipo_logradouro_id` BIGINT(20) NOT NULL,
  `aluno_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id_endereco_aluno`),
  INDEX `fk_endereco_aluno_tipo_logradouro1_idx` (`tipo_logradouro_id` ASC),
  INDEX `fk_endereco_aluno_aluno1_idx` (`aluno_id` ASC),
  CONSTRAINT `fk_endereco_aluno_tipo_logradouro1`
    FOREIGN KEY (`tipo_logradouro_id`)
    REFERENCES `db_faculdade`.`tipo_logradouro` (`id_tipo_logradouro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_aluno_aluno1`
    FOREIGN KEY (`aluno_id`)
    REFERENCES `db_faculdade`.`aluno` (`id_aluno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
