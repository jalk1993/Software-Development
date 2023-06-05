Feature: Tests for Articles page


#En background vamos a agregar todas las variables que se van a reutilizar a lo largo del codigo
  Background: Define url
    * def articlesBodyRequest = read('classpath:conduitApp/json/ArticlesBody.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articlesBodyRequest.article.title = dataGenerator.getRandomArticlesValues().title
    * set articlesBodyRequest.article.body = dataGenerator.getRandomArticlesValues().body
    * set articlesBodyRequest.article.description = dataGenerator.getRandomArticlesValues().description
    * url apiUrl
  
  #Llamamos este feature, desde otro archivo .feature creado fuera de nuestra carpeta de ejecucion, ademas que podemos agregar parametros.
       
       #* def tokenResponse = callonce read('classpath:helpers/CreateToken.feature')
       #* def token = tokenResponse.authToken

    Scenario: Create a new article
     
      Given path 'articles/'
      And request articlesBodyRequest
      When method Post
      Then status 200
      And match response.article.tagList contains ['m1']
      And match response.article.title == articlesBodyRequest.article.title
      

      Scenario: Create and Delete an article
      Given path 'articles/'
      And request articlesBodyRequest
      When method Post
      Then status 200
      * def articleSlug = response.article.slug

      Given params { limit: 10 , offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200
      And match response.articles[0].title == articlesBodyRequest.article.title
      
      Given path 'articles/', articleSlug
      When method Delete
      Then status 200

       Given params { limit: 10 , offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200
      And match response.articles[0].title != articlesBodyRequest.article.title