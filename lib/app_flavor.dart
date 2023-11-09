enum AppFlavor {
  staging('https://631eb73e58a1c0fe9f562cec.mockapi.io/'),
  production('https://631eb73e58a1c0fe9f562cec.mockapi.io/');

  final String baseUrl;

  const AppFlavor(this.baseUrl);
}
