Feature: Customer Registration

  Scenario: testing the POST call for customer registration with valid email address
    Given url baseUrl+'/registration'
    And request '{"email": "valid@xyz.com"}'
    When method POST
    Then status 201

  Scenario: testing the customer registration with invalid email address
    Given url baseUrl+'/registration'
    And request '{"email": "invalid@xyz.com"}'
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid email address'

  Scenario: testing the customer signup with duplicate email address record
    Given url baseUrl+'/registration'
    And request '{"email": "duplicate@xyz.com"}'
    When method POST
    Then status 422
    * match response.errorMessage == 'Email record already exists'


