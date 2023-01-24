Feature: Customer Registration
  # For now just checking response messages and if the customer id gets generated upon successful registration
  @positive
  Scenario: testing the POST call for customer registration with valid email address
    Given url baseUrl+'/registration'
    And request '{"email": "valid@xyz.com"}'
    When method POST
    Then status 201
    * match response.customerID == '#present'

  @negative
  Scenario: testing the customer registration with invalid email address
    Given url baseUrl+'/registration'
    And request '{"email": "invalidxyz.com"}'
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid email address'

  @negative
  Scenario: testing the customer signup with duplicate email address record
    Given url baseUrl+'/registration'
    And request '{"email": "duplicate@xyz.com"}'
    When method POST
    Then status 409
    * match response.errorMessage == 'Email record already exists'


