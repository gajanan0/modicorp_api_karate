Feature: Fund Wallet

  Background:
    * def requestJSON = read("classpath:Customer.json")

  Scenario: testing the customer is able to add fund to wallet for valid details
    Given url baseUrl+'/add-wallet'
    * request requestJSON
    When method POST
    Then status 201

  Scenario: testing the error for wallet addition with excessive amount than the allowed limit (assume 9999999)
    Given url baseUrl+'/add-wallet'
    * set requestJSON.addAmount = 10000000
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Amount'

  Scenario: testing the error for less amount wallet addition
    Given url baseUrl+'/add-wallet'
    * set requestJSON.billAmount = 50
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Minimum amount should be 100'


