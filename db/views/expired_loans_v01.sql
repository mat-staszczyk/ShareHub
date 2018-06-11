SELECT transactions.id AS transaction_id, 
       transactions.lender_id, 
       lenders.email AS lender_email, 
       lenders.first_name AS lender_first_name, 
       transactions.borrower_id AS borrower_id, 
       borrowers.first_name AS borrower_first_name, 
       borrowers.email AS borrower_email, 
       transactions.return_planned_at, 
       extract(day FROM age(current_date, transactions.return_planned_at)) AS after_return_date
  FROM transactions
  JOIN things ON transactions.thing_id = things.id
  JOIN users lenders ON transactions.lender_id = lenders.id
  JOIN users borrowers ON transactions.borrower_id = borrowers.id
 WHERE transactions.returned_at IS NULL 
   AND transactions.return_planned_at <= current_timestamp;
