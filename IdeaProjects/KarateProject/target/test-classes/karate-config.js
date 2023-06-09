function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
	apiUrl: 'https://conduit.productionready.io/api/'
  }

  if (env == 'dev') {
    config.userEmail = 'karate1@testone.com'
    config.userPassword = 'karate1234'

  } if (env == 'qa') {
    // customize
  }

  var accessToken = karate.callSingle ('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers',{Authorization:'Token ' + accessToken})
  return config;
}