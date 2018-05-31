Right off I will say that I have commented in both code bases just for you.
Grep for 'NOTE:' to find them. Other comments are my normal style.

#### General philosophy
I build via vanilla code as much as possible instead of relying on lots of plugins.
This bare-bones MVP approach is more contrived than my usual approach as I feel decisions like this violate convention over configurations. But I feel these decisions properly illustrate my ability to work within the structure provided with as few tools as possible to complete a feature.

Ex1: Instead of implementing a more conventional react-router approach, I choose to handle the URL using vanilla patterns alone.


#### Complexity

I would note that in real life the sorting and filtering of such a feature should be handled by the frontend to the greatest extent possible. However I recognize the point of the challenge is to garner insight into my abilities to work in a decoupled dependent structure. Given these constraints I have done what I can to increase the response time of the server by eliminating ```n+1``` queries and ensuring the most intensive queries are constructed in raw SQL.

#### Structure

Frontend - I decided on a overarching smart component (App) with dumb children (CustomerList, SearchBox)
As to state I have opted to stick with the basic react state as the use case here does not merit a stronger architecture such as Redux/Flux.

DB Lookups - I choose to go with Ruby/AR first for sorting as opposed to more complex SQL queries for the majority of lookups. This should demonstrate a healthy balance in my ability to query the DB.

Sorting - Sorting via dropdown would not have been my first choice. There are several out of the box solutions available for super simple table sorting via headers, a more intuitive solution for the end user.

#### Styling

I didn't do a ton of styling as the main goal here is to showcase functionality over form.
I've taken a bit of artistic license with the layouts suggested in the challenge.
IE sort by located at the top right of the customer list.
Instead I opted for what I view as a cleaner approach locating all filter options
within their on widget area. This is more in keeping with the modular component approach React promotes.
