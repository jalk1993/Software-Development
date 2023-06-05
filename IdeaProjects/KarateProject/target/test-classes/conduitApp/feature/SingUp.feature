
Feature: Create users 

Background: Preconditions
* def dataGenerator = Java.type('helpers.DataGenerator')
* def timeValidator = read ('classpath:helpers/timeValidator.js')
* def randomEmail = dataGenerator.getRandomEmail()
* def randomUserName = dataGenerator.getRandomUserName()
* url apiUrl

Scenario: Sign up new user

Given path "users"
And request
"""
{
    "user": {
        "email": "#(randomEmail)",
        "password": "1234karate",
        "username": "#(randomUserName)"
    }
}

"""
When method Post
Then status 200
And match response ==
"""
{
    "user": {
        "id": '#number',
        "email": #(randomEmail),
        "createdAt": '#? timeValidator(_)',
        "updatedAt": '#? timeValidator(_)',
        "username": #(randomUserName),
        "bio": null,
        "image": null,
        "token": '#string'
    }
}
"""
@debug
Scenario Outline: Validate Sign up error messages

Given path "users"
And request
"""
{
    "user": {
        "email": "<email>",
        "password": "<password>",
        "username": "<username>"
    }
}

"""
When method Post
Then status 422
And match response == <errorResponse>

Examples: 
| email                 |   password | username         | errorResponse                                                                     | 
| #(randomEmail)        | 1234karate |jkarate89asasa    | {"errors":{"username":["has already been taken"]}}                                |
| jkarate89111@testk.com| 1234karate |#(randomUserName) | {"errors":{"email":["has already been taken"]}}                                   |
|                       | 1234karate |#(randomUserName) | {"errors":{"email":["can't be blank"]}}                                           |
| #(randomEmail)        | 1234karate |                  | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}}|
| #(randomEmail)        |            |#(randomUserName) | {"errors":{"password":["can't be blank"]}}                                           |
