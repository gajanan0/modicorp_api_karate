Feature: Biller Payment

  Background: Get url
    * def requestJSON = read("classpath:TestData.json")

  @positive
  Scenario: testing the customer is able to make successful bill payment for valid details
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 101
    * set requestJSON.utilityType = 'Electricity'
    * set requestJSON.utilityBiller = 'MSEDCL'
    * set requestJSON.billID = 5365896345
    * set requestJSON.billAmount = 1000
    * request requestJSON
    When method POST
    Then status 201
#    * match response status match it with paid/unpaid

  @negative
  Scenario: testing the error for invalid Customer ID
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 1111111111
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Customer ID'

  @negative
  Scenario: testing the error for invalid Biller ID
    Given url baseUrl+'/billpayment'
    * set requestJSON.billerID = 1111111111
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Biller ID'

  @negative
  Scenario: testing the error for invalid bill amount
    Given url baseUrl+'/billpayment'
    * set requestJSON.billAmount = 0000
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Bill Amount'

  @negative
  Scenario: testing the error for invalid customer
    Given url baseUrl+'/billpayment'
    * set requestJSON.emailAddress = invalid@xyz.com
    * request requestJSON
    When method POST
    Then status 400
    * match response.errorMessage == 'Invalid Email Address'

  @negative # assume customer id 401 with zero wallet balance and assume api throwing conflict
  Scenario: testing the error for customer tring to make payment with zero wallet balance
    Given url baseUrl+'/billpayment'
    * set requestJSON.emailAddress = 401@xyz.com
    * request requestJSON
    When method POST
    Then status 409
    * match response.errorMessage == 'Insufficient wallet balance'

  @negative # assume customer id 402 with less wallet balance and assume api throwing conflict
  Scenario: testing the error for customer tring to make payment with less wallet balance than the required amount
    Given url baseUrl+'/billpayment'
    * set requestJSON.emailAddress = 402@xyz.com
    * request requestJSON
    When method POST
    Then status 409
    * match response.errorMessage == 'Insufficient wallet balance'
