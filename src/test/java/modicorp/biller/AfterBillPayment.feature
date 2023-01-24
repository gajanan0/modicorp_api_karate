Feature: Transaction status after bill payment

  Background: Get url
    * def requestJSON = read("classpath:TestData.json")

  @positive # this scenario to be tried after some time say 1 mins
  Scenario: the customer is able to track transaction for successful bill payment
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 1234567890
    * set requestJSON.transactionID = 'DT122326232656235'
    * request requestJSON
    When method GET
    Then status 200
    * match response.infoMessage == 'Transaction is successful'

  @positive # this scenario to be tried after some time say 3 mins
  Scenario: the customer is able to track transaction for failed bill payment
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 1234567890
    * set requestJSON.processingID = 'PID122326232656235'
    * request requestJSON
    When method GET
    Then status 200
    * match response.infoMessage == 'Pleas wait, transaction is inprogress'

  @negative # this scenario to be tried after some time say 15 mins
  Scenario: the customer is able to track transaction for failed bill payment
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 1234567890
    * set requestJSON.processingID = 'PID122326232656235'
    * request requestJSON
    When method GET
    Then status 200
    * match response.infoMessage == 'Sorry, transaction is failed'

  @negative
  Scenario: the customer is unable to track transaction for incorrect transaction id for correct customer id
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 1234567890
    * set requestJSON.transactionID = 'INC122326232656235'
    * request requestJSON
    When method GET
    Then status 400
    * match response.infoMessage == 'Incorrect transaction id'

  @negative # not considering authorisation, hence not found is valid response
  Scenario: the customer is unable to track transaction for incorrect/correct transaction id and incorrect customer id
    Given url baseUrl+'/billpayment'
    * set requestJSON.customerID = 1234567890
    * set requestJSON.transactionID = 'INC122326232656235'
    * request requestJSON
    When method GET
    Then status 404
    * match response.infoMessage == 'Incorrect customer id'