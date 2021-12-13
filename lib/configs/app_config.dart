class AppConfig {
  static final baseUrl = 'https://project.nironcrm.tk/simply-life-mobile';
  static final baseApiUrl = AppConfig.baseUrl + '/api';
  static final confirmPayment = AppConfig.baseUrl + '/api/payment/success';
  static final successPayment =
      AppConfig.baseUrl + '/api/payment/confirm-paypal';
  static final failPayment = AppConfig.baseUrl + '/api/payment/fail';

  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();
}
