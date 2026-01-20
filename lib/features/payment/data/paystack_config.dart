class PaystackConfig {
  // NOTE: Currently using TEST public key
  // PRODUCTION: Replace with your LIVE Public Key from Paystack Dashboard before deployment
  // Ideally, load this from an environment variable (e.g. using flutter_dotenv)
  static const String publicKey =
      'pk_test_3e87802dae281fbeb004f2b0f741a6e662aba103';

  // URL for your backend's verify endpoint (e.g., Firebase Cloud Function)
  // If verifying from client (NOT RECOMMENDED for production), this would be Paystack's API
  static const String verifyUrl =
      'https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net/verifyPayment';
}
