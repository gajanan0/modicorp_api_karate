function fn() {
  var env = karate.env;

  if (!env) {
    env = 'dev';

  }
  var config = {
    env: env,
	myVarName: 'someValue',
	baseUrl= 'https://reqres.in/api/users/2'
  }
 if (env == 'dev') {

  } else if (env == 'e2e') {

  }
  return config;
}