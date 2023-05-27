class ApiEndpoints {
  ApiEndpoints._privateConstructor();
  static final ApiEndpoints _instance = ApiEndpoints._privateConstructor();
  static ApiEndpoints get instance => _instance;

  final String protocol = "https";
  final String domainName = "qldt-hufi.dev";
  final String apiPrefix = "api";
  final String apiVersion = "v1";
  
  final String _oauth = "oauth2";
  final String _login = "login";
  final String _token = "token";
  final String _attendance = "diemdanh";

  ApiEndpoints();

  String get baseUrl => '$protocol://$domainName/$apiPrefix/$apiVersion';
  String get tokenUrl => '$baseUrl/$_oauth/$_token';
  String get loginUrl => '$baseUrl/$_oauth/$_login';
  String get attendanceUrl => '$baseUrl/$_attendance';
}