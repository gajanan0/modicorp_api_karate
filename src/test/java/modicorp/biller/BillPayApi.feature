Feature: Biller Payment

  Background: Get url
    * def requestJSON = read("classpath:TestData.json")

  Scenario: testing the customer is able to make successful bill payment for valid details
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 1234567890
    * set requestJSON.utilityType = 'Electricity'
    * set requestJSON.utilityBiller = 'MSEDCL'
    * set requestJSON.billAmount = 1000
    * request requestJSON
    When method POST
    Then status 201

  Scenario: testing the error for invalid Customer ID
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 1111111111
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Customer ID'

  Scenario: testing the error for invalid Biller ID
    Given url baseUrl+'/billpayment'
    * set requestJSON.billerID = 1111111111
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Biller ID'

  Scenario: testing the error for invalid bill amount
    Given url baseUrl+'/billpayment'
    * set requestJSON.billAmount = 0000
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Bill Amount'

  Scenario: testing the error for invalid customer
    Given url baseUrl+'/billpayment'
    * set requestJSON.emailAddress = invalid@xyz.com
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Email Address'