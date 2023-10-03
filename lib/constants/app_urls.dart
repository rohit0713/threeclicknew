class AppUrls {
  String get baseUrl => 'http://3clickjob.ph/public/api/v1';

  String get loginUrl => '/login';
  String get registrationUrl => '/register';
  String get nationalityUrl => '/nationalitieslist';
  String get provinceUrl => '/provincelist';
  String get cityUrl => '/locations';
  String get sendOtpUrl => '/otp/generate';
  String get otpVerificationUrl => '/otp/verification';
  String get referralUrl => '/agent/searchingReference_code';
  String get forgotPasswordUrl => '/forgot-password';
}

final appUrls = AppUrls();
