Feature: Fund Wallet

  Background:
    * def requestJSON = read("classpath:Customer.json")

  @positive
  Scenario: the customer is able to check current wallet balance
    Given url baseUrl+'/add-wallet'
#    * set emailAddress = 'abc@xyz.com'
    * set customerID = '101'
    When method GET
    Then status 200
    * def reference_wallet_balance = response.currentWallentBalance

  @positive # assumed that the reference wallet balance is used for below post call
  Scenario: the customer is able to add fund to wallet for valid details
    Given url baseUrl+'/add-wallet'
#    * set emailAddress = 'abc@xyz.com'
    * set customerID = '101'
    * set requestJSON.byBankAccount = 56985656
    * request requestJSON
    When method POST
    Then status 201
    * match response.currentWallentBalance == reference_wallet_balance

  @negative
  Scenario: the error for wallet addition with excessive amount than the allowed limit (assume 9999999)
    Given url baseUrl+'/add-wallet'
    * set customerID = '101'
    * set requestJSON.addAmount = 10000000
    * set requestJSON.byBankAccount = 56985656
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Amount'

  @negative
  Scenario: testing the error for less amount wallet addition (assume <100)
    Given url baseUrl+'/add-wallet'
    * set customerID = '101'
    * set requestJSON.addAmount = 50
    * set requestJSON.byBankAccount = 56985656
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Minimum amount should be 100'

  @negative # similar to this - more scenarios can be considered for different transaction failure reasons
  Scenario: testing the error for transaction failure due to bank account suspension
    Given url baseUrl+'/add-wallet'
    * set customerID = '101'
    * set requestJSON.addAmount = 50000
    * set requestJSON.byBankAccount = 56985656
    * request requestJSON
    When method POST
    Then status 503
    * match response.errorMessage == 'Bank account is not responding'