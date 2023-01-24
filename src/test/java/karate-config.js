function fn() {
  var env = karate.env;

  if (!env) {
    env = 'dev';

  }
  var config = {
    env: env,
	myVarName: 'someValue',
	baseUrl= 'https://modicorp.biller.com'
  }
 if (env == 'dev') {

  } else if (env == 'qa') {

  }
  return config;
}