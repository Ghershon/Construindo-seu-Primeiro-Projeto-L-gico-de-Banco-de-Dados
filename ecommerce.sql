-- criação de banco de dados para o cenário do E-Commerce
create database ecommerce;

use ecommerce;

-- criar tabela cliente
create table client(
 idClient int auto_increment primary key,
 FName varchar(10),
 Minit varchar(3),
 Lname varchar(20),
 CPF char(11) not null,
 Address varchar(30),
 constraint unique_cpf_client unique (CPF)
 );
       

-- criar tabela produto
create table product (
 idProduct int auto_increment primary key,
 PName varchar(10) not null,
 classification_kids bool default false,
 category enum('Eletrônicos', 'Vestuários','Brinquedos','Alimentos','Móveis'),
 avaliação float default 0,
 size varchar(10)
 );

create table payments (
 idclient int,
 idPayment int,
 typePayment enum('Boleto', 'PIX', 'Cartão', 'Multiplos Cartões'),
 limitAvailable float,
 primary key (idclient, idPayment)
);

-- criar tabela pedido
create table orders (
 idOrder int auto_increment primary key,
 idOrderClient int, 
 OrderStatus enum('Cancelado', 'Confirmado', 'Em processamento') not null,
 OrderDescription varchar(255),
 sendValue float default 10,
 paymentCash bool default false,
 constraint fk_orders_client foreign key (idOrderClient) references clients(idclient)
 );

-- criar tabela estoque
create table productStorage (
     idProdStorage int auto_increment primary key,
     storageLocation varchar(255),
     quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
idSupplier int auto_increment primary key,
SocialName varchar(255) not null,
CNPJ char(15) not null,
contact varchar(11) not null,
constraint unique_supplier unique (CNPJ)
);
 
 -- criar tabela vendedor
 create table seller(
      idSeller int auto_increment primary key,
      SocialName varchar(255) not null, 
      AbstName varchar(255),
      CNPJ char(15) not null,
      CPF char(11) not null,
      location varchar(255),
      contact varchar(11) not null,
      constraint unique_cnpj_seller unique (CNPJ),
      constraint unique_cpf_seller unique (CPF)
 );
 
 create table productSeller(
      idPseller int primary key,
      idProduct int primary key,
      prodQuantity int default 1,
      primary key (idPseller, idProduct),
      constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
      constraint fk_product_product foreign key (idProduct) references product(idProduct)
);



 create table productOrder(
      idPOproduct int,
      idPOorder int,
      poQuantity int default 1,
      poStatus enum('Disponível', 'Sem Estoque') default 'Disponível',
      primary key(idPOproduct, idPOorder),
      constraint fk_product_seller foreign key (idPOproduct) references product(idProduct),
      constraint fk_product_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
     idLproduct int,
     idLstorage int,
     location varchar(255) not null,
     primary key (idLproduct, idLstorage),
     constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
	 constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	 idPsSupplier int,
     idPsProduct int,
     quantity int not null,
     primary key(idPsSupplier, idPsProduct),
     constraint fk_product_supplier_supplier foreign key (idPsSupplier) references product(idSupplier),
	 constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

desc productSupplier;

show tables;
