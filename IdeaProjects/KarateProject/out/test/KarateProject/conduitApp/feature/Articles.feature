Feature: Tests for Articles page

  Background: Define url
    Given url 'https://conduit.productionready.io/api/'

    Scenario: Create a new articles
      Given path 'users/login'
      And request {"user": {"email": "karate1@testone.com","password": "karate1234"}}
      When method Post
      Then status 200
      And match response.user.email == 'karate1@testone.com'
      And match response.user.bio == null
       * def token = response.user.token

      Given path 'articles/'
      Given header Authorization = 'Token ' + token
      And request {"article": {"tagList": ["m1"],"title": "test from Mac M1","description": "Sending test from postman M1","body": "testing from M1 "}}
      When method Post
      Then status 200
      And match response.article.tagList contains ['m1']
      And match response.article.title == "test from Mac M1"