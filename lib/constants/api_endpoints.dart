class ApiEndpoints {
  ApiEndpoints._privateConstructor();
  static final ApiEndpoints _instance = ApiEndpoints._privateConstructor();
  static ApiEndpoints get instance => _instance;

  String _baseUrl = "";

  final String _protocol = "https";
  final String _domainName = "hufi-qldt.dev";
  final String _apiPrefix = "api";
  final String _apiVersion = "v1";
  final String _oauth = "oauth2";
  final String _login = "login";
  final String _token = "token";
  final String _attendance = "diemdanh";

  ApiEndpoints() {
    _baseUrl = '$_protocol://$_domainName/$_apiPrefix/$_apiVersion'; 
  }

  String get baseUrl => _baseUrl;
  String get tokenUrl => '$_baseUrl/$_oauth/$_token';
  String get loginUrl => '$_baseUrl/$_oauth/$_login';
  String get attendanceUrl => '$_baseUrl/$_attendance';
}