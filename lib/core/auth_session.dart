class AuthSession {
  static String? token;

  static void setToken(String? t) => token = t;
  static String? getToken() => token;

  static void clear() => token = null;
}
