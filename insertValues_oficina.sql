insert into Clientes (Nome, Endereco, CPF) 
			values
            ('Maria Joana R Silva', 'Rua Mecanico', '12304516658'),
            ('Matheus O Pimentel', 'Rua Encanador', '12304513258'),
            ('Ana Carolina R Silva', 'Rua Wander Costa', '11404818600'),
            ('Roberta G Assis', 'Avenida Liberdade', '12304516190');
            
select * from Clientes;

insert into Veículo (TipoVeiculo, Placa, Marca, Cor, idClientes)
			values 	('Carro', 'PXA5058', 'Hyundai', 'Vermelho', 1),
					('Onibus', 'PWB0989', 'Chevrolet', 'Marrom', 2),
					('Moto', 'GBA8767', 'Fiat', 'Prata', 3),
					('Carro', 'YUI9832', 'Fiat', 'Preto', 4),
                    ('Carro', 'PWX5058', 'Hyundai', 'Marrom', 1),
                    ('Caminhão', 'PXA3090', 'Autoscar', 'Prata', 4);
                    
select * from Veículo;

insert into Peca (idPeca, Nome, Tipo, ValorPeca) 
		values 	(1,'Calota', 'Pronto Entrega', 28.9),
				(2, 'Parabrisa', 'Pronto Entrega', 95.1),
				(3, 'Volante', 'Terceirizado', 106.0);
                
select * from Peca;

insert into MaoDeObra (idMaoDeObra, ValorServico)
		values 	(1, 300.0),
				(6, 250.9),
                (7, 550.6),
                (8, 100.0);
                

select * from MaoDeObra;

insert into Servicos (idServicos, TipoServico, idMaoDeObra)
			values 	(1, 'Funilaria', 1),
					(2, 'Pintura', 6),
                    (3, 'Mecânica', 8),
                    (4, 'Troca de Peça', 7);
                    
select * from Servicos;

insert into Mecanico (idMecanico, Nome, Endereço, Especialidade)
			values 	(1, 'João Borges', 'Rua Liberdade', 'Elétrico'),
					(2, 'Joaquim Jose Pereira','Avenida Constelação', 'Funilaria'),
                    (3, 'Nivaldo Marques', 'Rio Paraguai', 'Mecânica');
                    
insert into Equipe (DescriçaoServico)
			values ('Funilaria e Pintura'),
					('Pintura'),
                    ('Troca de Peças'),
                    ('Elétrico'),
                    ('Mecânica');

select * from Equipe;

insert into OrdemServico (DataEmissao, ValorOrdem, Status, DataFinalizacao, idClientes, idVeiculo, idEquipe)
			values 	('2020-09-08', 280.9, 'Gerando orçamento', null, 1, 3, 5),
					('2022-10-01', 2750.9, 'Processando', null, 2, 4, 4),
                    ('2008-07-16', 1876.5, 'Faturado', null, 1, 3, 2),
                    ('2009-07-22', 176.5, 'Faturado', null, 1, 3, 2),
                    ('2021-02-18', 245.5, 'Faturado', null, 1, 3, 2),
                    ('2022-10-03', 1023.5, 'Em faturamento', null, 1, 3, 2);

select * from OrdemServico;
                    
insert into Revisao (FlgRevisao, idClientes, idOrdemServiço)
			values 	('Aguardando resposta', 1, 1),
					('Aceito', 2, 2),
                    ('Aceito', 1, 3),
                    ('Não Aceito', 1, 4),
                    ('Aceito', 1, 5),
                    ('Aceito', 1, 6);

-- Quantos clientes existem na base?                     
select count(*) from Clientes;

-- Relaçao de clientes e veículos
select * from Clientes c, Veículo v where c.idClientes = v.idClientes;

-- Quantidade de veículos por cliente
select c.idClientes, count(distinct idVeiculo)
from Clientes c, Veículo v 
where c.idClientes = v.idClientes
group by c.idClientes; 

-- Quantidade de Ordem de Serviço por Status
select Status, count(*)
from OrdemServico
group by Status;

-- Quantidade de Servicos realizados por Equipe maiores que 1
select o.idEquipe, count(*)
from OrdemServico o, Equipe e
where o.idEquipe = e.idEquipe
group by o.idEquipe
having count(*) > 1;