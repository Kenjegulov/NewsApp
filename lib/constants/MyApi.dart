class MyApi {
  static String myApiKey = "7ce39c65756c47298a14d340bcef85b8";
  static String myApiUrl([String? domain]) {
    return "https://newsapi.org/v2/top-headlines?country=$domain&apiKey=$myApiKey";
  }
}
