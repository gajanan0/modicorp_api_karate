ASSUMPTION IN TESTING MODI CORPORATION BILLING APPLICATION
1.	Karate framework is used for API test automation.
2.	Java-Selenium-Cucumber is used in UI test automation framework.
3.	Environment URL is considered as https://modicorp.biller.com 
4.	NO authentication is assumed involved for registration/login/wallet etc.
5.	The post-paid category of bill payment is assumed.
6.	Utility bill categories are considered as-
	•	Mobile
	•	Landline 
	•	Broadband 
	•	Data
	•	DTH 
	•	Electricity
	•	Gas
	•	Water
	•	Insurance
7.	Consumer ID is assumed.
8.	Email address is generated randomly to address the duplicate email address issue.	
9.	The wallet limit is assumed as 9999999.
10.	Duplicate email address conflict status code is assumed as 409 (vs 422).
11.	JSON Schema validation are not considered in scope but if would have considered then scenarios could be- 
•	email address more than 256 chars
•	customer id, 
•	required param in json (mandatory), 
•	etc.

