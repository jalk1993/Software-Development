Feature: Automate the home page
  Background:
    Given url 'https://conduit.productionready.io/api/'

  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match each response.tags == '#string'
    And match response.tags contains ['SIDA', 'HITLER']
    And match response.tags !contains ['cars']

    Scenario: Get all Articles
      Given params { limit: 10 , offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200