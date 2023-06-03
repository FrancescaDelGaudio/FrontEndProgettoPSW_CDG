class AuthenticationData {
  String accessToken;
  String refreshToken;
  String error;
  int expiresIn;


  AuthenticationData({required this.accessToken, required this.refreshToken, required this.error, required this.expiresIn,});

  factory AuthenticationData.fromJson(Map<String, dynamic> json) {
    return AuthenticationData(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      error: json['error_description'],
      expiresIn: json['expires_in'],
    );
  }

  bool hasError() {
    return error != null;
  }


}