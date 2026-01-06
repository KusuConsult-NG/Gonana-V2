class PaymentResponse {
  final String authorizationUrl;
  final String accessCode;
  final String reference;

  PaymentResponse({
    required this.authorizationUrl,
    required this.accessCode,
    required this.reference,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      authorizationUrl: json['authorization_url'],
      accessCode: json['access_code'],
      reference: json['reference'],
    );
  }
}
