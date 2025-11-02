class ApiUrls{

  static const String baseUrl = 'https://frijo.noviindus.in/api';

  static const String otpVerified = '$baseUrl/otp_verified';
  static const String categoryList = '$baseUrl/category_list';
  static const String home = '$baseUrl/home';
  static String myFeed(int page) => '$baseUrl/my_feed?page=$page';
  static const String myFeedPost = '$baseUrl/my_feed';

}