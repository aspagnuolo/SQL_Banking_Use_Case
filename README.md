# SQL: Banking Use Case
The aim of the project is to create a denormalised table containing behavioural indicators on the customer, calculated on the basis of transactions and product possession.   
The purpose is to create features for a possible supervised machine learning model.  
`db_banking.sql` provides information on customer accounts and transactions.
The features created, for each client_id, are the following:
- Age
- Number of outgoing transactions on all accounts
- Number of incoming transactions on all accounts
- Outgoing transacted amount on all accounts
- Incoming transacted amount on all accounts
- Total number of accounts held
- Number of accounts held by type (one indicator per type)
- Number of outgoing transactions by type (one indicator per type)
- Number of incoming transactions by type (one indicator per type)
- Outgoing transacted amount by account type (one indicator per type)
- Incoming transacted amount by account type (one indicator per type)
