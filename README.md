# Tinnova Api Test

## THIS IS THE DOCUMENTATION OF MY ANSWER FOR THE INTERVIEW

# Get a list of beers
> `localhost:3000/beers` (get request)

* You need to pass the Bearer token to be able to complete the request.
* You can ask for: a single beer by beer name, a set of beers with an abv greater than the specified value, an specific page of beers.

> ENDPOINTS:

####To get the beer with the name 'AB:08'
`localhost:3000/beers?beer_name=AB:08` 

####To get the third page of beer results, return 25 entries
`localhost:3000/beers?page=3` 

####Retrieve a list of beers with an abv greater than 10, max 25 entries
`localhost:3000/beers?abv_gt=10` 

#### If you don't pass any value you will get the first 25 beer entries
`localhost:3000/beers`

> A user will see a beer of list of beers, the beers that the user has seen will not duplicate in the response or database. Several users can make use of the API and they will only see their selection. No crossing of data between users.

####Response (JSON)
```json
{
  "id": 2,
  "name": "AB:08",
  "tagline": "Deconstructed Blonde Imperial Stout.",
  "description": "Flavours and aromas you'd expect from a Stout, but brewed without dark malts. The full mouthfeel comes courtesy of wheat and oats, while smoked malt and the twist additions add the complex flavours normally provided by highly kilned malts.",
  "abv": 10,
  "favorite": false,
  "seen_at": "2021-07-24T09:32:36.108Z"
}
```

# Mark a Beer as Favorite

> `localhost:3000/favorite` (post request)

* Select a beer by name and mark it as favorite
* Beers market as favorite will show it in their response body ("favorite": true)
* You can select as many beers for your favorite endpoint. THEY CANT BE DUPLICATED

> ENDPOINTS:

####Mark the Beer AB:08 as favorite
`localhost:3000/favorite?beer_name=AB:08`

```json
{
  "success": "favorite saved!"
}
```

#### YOU CANT SAVE A FAVORITE MORE THAN ONE (NO DUPLICATED VALUES)

```json
{
  "notice": "Beer is already a favorite"
}
```

#### Get your list of favorite beers (get request)
`localhost:3000/favorite` 

```json
[
  {
    "id": 1,
    "name": "AB:08",
    "description": "Flavours and aromas you'd expect from a Stout, but brewed without dark malts. The full mouthfeel comes courtesy of wheat and oats, while smoked malt and the twist additions add the complex flavours normally provided by highly kilned malts.",
    "tagline": "Deconstructed Blonde Imperial Stout.",
    "abv": 10,
    "favorite": true,
    "user_id": 1,
    "seen_at": "2021-07-24T09:31:58.535Z"
  }
]
```

 #### Favorite beers will show on top of your Beer list
```json
[
    {
      "id": 2,
      "name": "AB:08",
      "tagline": "Deconstructed Blonde Imperial Stout.",
      "description": "Flavours and aromas you'd expect from a Stout, but brewed without dark malts. The full mouthfeel comes courtesy of wheat and oats, while smoked malt and the twist additions add the complex flavours normally provided by highly kilned malts.",
      "abv": 10,
      "favorite": true,
      "seen_at": "2021-07-24T09:32:36.108Z"
    },
    {
      "id": 3,
      "name": "Buzz",
      "tagline": "A Real Bitter Experience.",
      "description": "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.",
      "abv": 4,
      "favorite": false,
      "seen_at": "2021-07-24T09:35:11.486Z"
    }
]
```


> #### As with the get request for the beer list, the favorite list will only show the beers that the user marked as favorite, they will not see anything from any other user.

> #### For optimization purposes only unique values (not colliding with other users) will be saved in the database. This means that a user will only have one record in the database for beer seen, if the user makes another request and gets the same beer this one will not be saved in the database. Different users can have the same entries in the database and they will not collide with each other.