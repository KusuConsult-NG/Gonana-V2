class AppConfig {
  static const String identityPassBaseUrl =
      'https://sandbox.prembly.com/api/v1';

  // NOTE: In a production app, these should be securely stored in .env or Firebase Remote Config
  // The user should provide their APP_ID and X_API_KEY from Prembly Dashboard
  static const String identityPassAppId = 'YOUR_PREMBLY_APP_ID';
  static const String identityPassApiKey = 'YOUR_PREMBLY_API_KEY';
}
