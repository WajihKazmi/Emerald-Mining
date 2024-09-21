class AppUrl {
  static var baseUrl = "https://emerald-coin-mining-0ff0eef3b02d.herokuapp.com";
  static var forgetPassword = "$baseUrl/user/api/forgot-password";
  static var login = "$baseUrl/user/api/login/";
  static var signup =
      'https://emerald-coin-mining-0ff0eef3b02d.herokuapp.com/user/api/signup/';
  static var resendOtp =
      'https://emerald-coin-mining-0ff0eef3b02d.herokuapp.com/user/api/resent-otp';
  static var changePassword = '$baseUrl/user/change-password';
  static var getUser = '$baseUrl/user/api/allUsers/';
  static var getAllMachines = '$baseUrl/api/v1/machines/';
  static var coinTransfer = '$baseUrl/api/v1/coins-transfer/';
  static var getUserMachines = '$baseUrl/api/v1/user-machines/';
  static var buyMachines = '$baseUrl/api/v1/user-machines/';
  static var coinButton = '$baseUrl/user/';
  static var sendInvite = '$baseUrl/user/api/send-invite/';
  static var videos = '$baseUrl/api/v1/Emaralds-videos/';
  static var dailyReward = '$baseUrl/api/v1/daily-tasks/';
}
