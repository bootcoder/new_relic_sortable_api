For the frontend I decided on a overarching smart component (App) with several dumb children

Right off I will say that I have commented in both code bases just for you.
Grep for 'NOTE:' to find them. Other comments are my normal style.

Choosing to go with Ruby/AR first for sorting as opposed to more complex SQL queries.

PSEUDO

Customers have a first name
Customers have a last name
Company has a name
Customers belong to a company
Companies have many Customers
