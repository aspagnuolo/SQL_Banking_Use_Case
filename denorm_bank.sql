select * from cliente;
select * from conto;
select * from tipo_conto;
select * from tipo_transazione;
select * from transazioni;

    
CREATE VIEW banca.denormalised_table as
SELECT 
    cli.id_cliente,
    DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), cli.data_nascita)), '%Y') + 0 AS age,
    sum(CASE WHEN tran.id_tipo_trans NOT IN (0, 1, 2) THEN 1 ELSE 0 END) AS n°_outgoing_trans,
    sum(CASE WHEN tran.id_tipo_trans IN (0, 1, 2) THEN 1 ELSE 0 END) AS n°_incoming_trans,
    round(sum(CASE WHEN tran.id_tipo_trans not IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS outgoing_transacted,
    round(sum(CASE WHEN tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS incoming_transacted,
    count(DISTINCT co.id_tipo_conto) as n°_accounts,
    count(DISTINCT CASE WHEN co.id_tipo_conto = 0 THEN 1 END) AS basic_account,
    count(DISTINCT CASE WHEN co.id_tipo_conto = 1 THEN 1 END) AS business_account,
    count(DISTINCT CASE WHEN co.id_tipo_conto = 2 THEN 1 END) AS private_account,
    count(DISTINCT CASE WHEN co.id_tipo_conto = 3 THEN 1 END) AS family_account,
    count(CASE WHEN tipo_tran.id_tipo_transazione = 0 THEN 1 END) AS salary,
    count(CASE WHEN tipo_tran.id_tipo_transazione = 1 THEN 1 END) AS pension,
    count(CASE WHEN tipo_tran.id_tipo_transazione = 2 THEN 1 END) AS dividends,
    count(CASE WHEN tipo_tran.id_tipo_transazione = 3 THEN 1 END) AS Amazon,
    count(CASE WHEN tipo_tran.id_tipo_transazione = 4 THEN 1 END) AS loan,
    count(CASE WHEN tipo_tran.id_tipo_transazione = 5 THEN 1 END) AS hotel,
    count(CASE WHEN tipo_tran.id_tipo_transazione = 6 THEN 1 END) AS flight_ticket,
    count(CASE WHEN tipo_tran.id_tipo_transazione = 7 THEN 1 END) AS supermarket,
    round(sum(CASE WHEN co.id_tipo_conto = 0 AND tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS incoming_basic_account,
    round(sum(CASE WHEN co.id_tipo_conto = 0 AND tran.id_tipo_trans not IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS outgoing_basic_account,
	round(sum(CASE WHEN co.id_tipo_conto = 1 AND tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS incoming_business_account,
    round(sum(CASE WHEN co.id_tipo_conto = 1 AND tran.id_tipo_trans not IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS outgoing_business_account,
	round(sum(CASE WHEN co.id_tipo_conto = 2 AND tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS incoming_private_account,
    round(sum(CASE WHEN co.id_tipo_conto = 2 AND tran.id_tipo_trans not IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS outgoing_private_account,
	round(sum(CASE WHEN co.id_tipo_conto = 3 AND tran.id_tipo_trans IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS incoming_family_account,
    round(sum(CASE WHEN co.id_tipo_conto = 3 AND tran.id_tipo_trans not IN (0, 1, 2) THEN tran.importo ELSE 0 END),2) AS outgoing_family_account
FROM 
    banca.cliente cli
    LEFT JOIN banca.conto co ON cli.id_cliente = co.id_cliente
    LEFT JOIN banca.transazioni tran ON co.id_conto = tran.id_conto
    LEFT join banca.tipo_transazione tipo_tran ON tran.id_tipo_trans = tipo_tran.id_tipo_transazione
GROUP BY 
    cli.id_cliente;
    
SELECT * FROM denormalised_table