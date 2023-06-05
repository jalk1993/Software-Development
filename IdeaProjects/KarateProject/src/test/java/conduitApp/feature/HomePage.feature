Feature: Automate the home page tests

  #En background vamos a agregar todas las variables que se van a reutilizar a lo largo del codigo
  Background:
    Given url apiUrl


  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match each response.tags == '#string'
    And match response.tags contains ['SIDA', 'HITLER']
    And match response.tags !contains ['cars']
    And match response.tags contains any ['BlackLivesMatter', 'test', 'loco']
    

    Scenario: Get all Articles
    * def timeValidator = read ('classpath:helpers/timeValidator.js')
      Given params { limit: 10 , offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200
      And match response == {'articles': "#[10]", "articlesCount": 500} 
      And match each response.articles ==
      """
        {
            "title": "#string",
            "slug": "#string",
            "body": "#string",
            "createdAt": '#? timeValidator(_)',
            "updatedAt": '#? timeValidator(_)',
            "tagList": '#array',
            "description": "#string",
            "author": {
                "username": "#string",
                "bio": '##string',
                "image": "#string",
                "following": '#boolean'
            },
            "favorited": '#boolean',
            "favoritesCount": '#number'
        }

      """