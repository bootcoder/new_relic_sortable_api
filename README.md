## Instalation:

#### API

Built with Rails ```5.1.6``` and Ruby ```2.4.1```

- Clone API source
- ```$ bundle install```
- ```$ rails db:create```
- ```$ rails db:mirgate```
- ```$ rails db:seed```
- ```$ rails s```
- ```$ bundle exec rspec .``` to run specs

#### FrontEnd

Built with Create-React-App ```1.4.3``` and Node ```9.3.0```

- Clone React source
- ```$ yarn```
- ```$ yarn start```
- ```$ yarn test``` to run specs

#### Deployment

The complete app is deployed to Heroku on a standard dyno.

- [Application](https://bootcoder-relic-search.herokuapp.com/)
- [Rails API](https://bootcoder-relic-search-api.herokuapp.com/)

#### PR's

- [React](https://github.com/bootcoder/new_relic_sortable_react/pull/1)
- [Rails API](https://github.com/bootcoder/new_relic_sortable_api/pull/1)

## Development Notes:

#### General philosophy

Right off I will say that I have commented in both code bases just for you.
Grep for 'NOTE:' to find them. Other comments are my normal style.

I build via vanilla code as much as possible instead of relying on lots of plugins.
This bare-bones MVP approach is more contrived than my usual approach as I feel decisions like this violate convention over configurations. But I feel these decisions properly illustrate my ability to work within the structure provided with as few tools as possible to complete a feature.

Ex1: Instead of implementing a more conventional react-router approach, I choose to handle the URL using vanilla patterns alone.

#### Complexity

I would note that in real life the sorting and filtering of such a feature should be handled by the frontend to the greatest extent possible. However I recognize the point of the challenge is to garner insight into my abilities to work in a decoupled dependent structure. Given these constraints I have done what I can to increase the response time of the server by eliminating ```n+1``` queries and ensuring the most intensive queries are constructed in raw SQL.

#### Structure

##### FrontEnd

I decided on a overarching smart component (App) with (mostly) dumb children (CustomerList, SearchBox). In hind site the CustomerList would have been a stateless functional component but that's okay if we decide to beef it up at a later date we'll already have the structure in place to do so.

For my state store I have opted to stick with the basic react state as the use case here does not merit a stronger architecture such as Redux/Flux.

Architecturally, I choose to keep the vast majority of functions within the ```<App />``` for conciseness during your review. I did split out the fetch to ```request.js```, both to demonstrate ability and make mocking the call a breeze.

**Testing** - Controller and Model specs provide 100% coverage on the backend. I focused my strategy on testing the payload instead of routing and status codes since the payload is the thing we really care about here.

I readily admit that the frontend testing could be more thorough.

**Sorting** - Side note: Sorting via dropdown would not have been my first choice. There are several out of the box solutions available for super simple table sorting via headers, a more intuitive solution for the end user.

##### Backend

**DB Lookups** - I choose to go with Ruby/AR first for sorting as opposed to more complex SQL queries for the majority of lookups. This should demonstrate a healthy balance in my ability to query the DB. Also I made sure to serialize the JSON payload down to clear needs only, presenting a much cleaner backend product.

**Architecture** I choose to leave the bulk of the logic in the controller. We could easily extract this functionality into helpers for a production level application.

#### Styling

I didn't do a ton of styling as the main goal here is to showcase functionality over form.
Style and design are very important to me, but it can also be a huge time suck when given free range without mockups.

I've taken a bit of artistic license with the layouts suggested in the challenge.
Ex: 'sort by located at the top right of the customer list'.
Instead I opted for what I view as a cleaner approach locating all filter options within their on widget area. This is more in keeping with the modular component approach React promotes.
