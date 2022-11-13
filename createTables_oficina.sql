
create database oficina;
use oficina;

-- Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS `oficina`.`Clientes` (
  `idClientes` INT AUTO_INCREMENT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereco` VARCHAR(45) NULL,
  `CPF` VARCHAR(11) NULL,
  PRIMARY KEY (`idClientes`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `oficina`.`Veículo` (
  `idVeiculo` INT AUTO_INCREMENT NOT NULL,
  `TipoVeiculo` ENUM('Carro', 'Moto', 'Onibus', 'Caminhão', 'Caminhonete') NOT NULL,
  `Placa` CHAR(7) NULL,
  `Marca` VARCHAR(25) NULL,
  `Cor` VARCHAR(30) NULL,
  `idClientes` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`, `idClientes`),
  INDEX `fk_Veículo_Clientes1_idx` (`idClientes` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_Clientes1`
    FOREIGN KEY (`idClientes`)
    REFERENCES `oficina`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `oficina`.`Peca` (
  `idPeca` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Tipo` VARCHAR(45) NULL,
  `ValorPeca` VARCHAR(45) NULL,
  PRIMARY KEY (`idPeca`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `oficina`.`MaoDeObra` (
  `idMaoDeObra` INT NOT NULL,
  `ValorServico` VARCHAR(45) NULL,
  PRIMARY KEY (`idMaoDeObra`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `oficina`.`Servicos` (
  `idServicos` INT NOT NULL,
  `TipoServico` VARCHAR(45) NULL,
  `idMaoDeObra` INT NOT NULL,
  PRIMARY KEY (`idServicos`, `idMaoDeObra`),
  INDEX `fk_Serviços_Mão de Obra1_idx` (`idMaoDeObra` ASC) VISIBLE,
  CONSTRAINT `fk_Serviços_Mão de Obra1`
    FOREIGN KEY (`idMaoDeObra`)
    REFERENCES `oficina`.`MaoDeObra` (`idMaoDeObra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `oficina`.`Mecanico` (
  `idMecanico` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  `Especialidade` ENUM('Elétrico', 'Funilaria', 'Mecânica') NULL,
  PRIMARY KEY (`idMecanico`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `oficina`.`MontagemEquipes` (
  `idEquipe` INT NOT NULL,
  `idMecanico` INT NOT NULL,
  PRIMARY KEY (`idEquipe`, `idMecanico`),
  INDEX `fk_Equipe_has_Mecânico_Mecânico1_idx` (`idMecanico` ASC) VISIBLE,
  INDEX `fk_Equipe_has_Mecânico_Equipe1_idx` (`idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_has_Mecânico_Equipe1`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `oficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_has_Mecânico_Mecânico1`
    FOREIGN KEY (`idMecanico`)
    REFERENCES `oficina`.`Mecanico` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

drop table Equipe;
CREATE TABLE IF NOT EXISTS `oficina`.`Equipe` (
  `idEquipe` INT auto_increment NOT NULL,
  `DescriçaoServico` VARCHAR(200),
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `oficina`.`OrdemServico` (
  `idOrdemServiço` INT auto_increment NOT NULL,
  `DataEmissao` DATE NULL,
  `ValorOrdem` DOUBLE NULL,
  `Status` ENUM('Gerando orçamento', 'Processando', 'Em faturamento', 'Faturado') DEFAULT 'Gerando orçamento' NOT NULL,
  `DataFinalizacao` DATE NULL,
  `idClientes` INT NOT NULL,
  `idVeiculo` INT NOT NULL,
  `idEquipe` INT NOT NULL,
  PRIMARY KEY (`idOrdemServiço`, `idClientes`, `idVeiculo`, `idEquipe`),
  INDEX `fk_Ordens de Serviço_Clientes1_idx` (`idClientes` ASC) VISIBLE,
  INDEX `fk_Ordens de Serviço_Veículo1_idx` (`idVeiculo` ASC) VISIBLE,
  INDEX `fk_Ordens de Serviço_Equipe1_idx` (`idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Ordens de Serviço_Clientes1`
    FOREIGN KEY (`idClientes`)
    REFERENCES `oficina`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordens de Serviço_Veículo1`
    FOREIGN KEY (`idVeiculo`)
    REFERENCES `oficina`.`Veículo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordens de Serviço_Equipe1`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `oficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

drop table Revisao;
CREATE TABLE IF NOT EXISTS `oficina`.`Revisao` (
  `idRevisao` INT auto_increment NOT NULL,
  `FlgRevisao` ENUM('Aceito', 'Não aceito', 'Aguardando resposta') NOT NULL,
  `idClientes` INT NOT NULL,
  `idOrdemServiço` INT NOT NULL,
  PRIMARY KEY (`idRevisao`, `idOrdemServiço`),
  CONSTRAINT `fk_Revisão_Clientes1`
    FOREIGN KEY (`idClientes`)
    REFERENCES `oficina`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Revisão_Ordens de Serviço1`
    FOREIGN KEY (`idOrdemServiço`)
    REFERENCES `oficina`.`OrdemServiCo` (`idOrdemServiço`)
    
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `oficina`.`PecasSolicitadas` (
  `idPeca` INT NOT NULL,
  `idServicos` INT NOT NULL,
  `QuantidadePecas` VARCHAR(45) NULL,
  `ValorPecas` DOUBLE NULL,
  PRIMARY KEY (`idPeca`, `idServicos`),
  INDEX `fk_Peça_has_Serviços_Serviços1_idx` (`idServicos` ASC) VISIBLE,
  INDEX `fk_Peça_has_Serviços_Peça1_idx` (`idPeca` ASC) VISIBLE,
  CONSTRAINT `fk_Peça_has_Serviços_Peça1`
    FOREIGN KEY (`idPeca`)
    REFERENCES `oficina`.`Peca` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peça_has_Serviços_Serviços1`
    FOREIGN KEY (`idServicos`)
    REFERENCES `oficina`.`Servicos` (`idServicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `oficina`.`ServicosOfertados` (
  `idOrdemServico` INT NOT NULL,
  `idServicos` INT NOT NULL,
  `ValorTotal` DOUBLE NULL,
  PRIMARY KEY (`idOrdemServico`, `idServicos`),
  INDEX `fk_Ordens de Serviço_has_Serviços_Serviços1_idx` (`idServicos` ASC) VISIBLE,
  INDEX `fk_Ordens de Serviço_has_Serviços_Ordens de Serviço_idx` (`idOrdemServico` ASC) VISIBLE,
  CONSTRAINT `fk_Ordens de Serviço_has_Serviços_Ordens de Serviço`
    FOREIGN KEY (`idOrdemServico`)
    REFERENCES `oficina`.`OrdemServico` (`idOrdemServiço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordens de Serviço_has_Serviços_Serviços1`
    FOREIGN KEY (`idServicos`)
    REFERENCES `oficina`.`Servicos` (`idServicos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


