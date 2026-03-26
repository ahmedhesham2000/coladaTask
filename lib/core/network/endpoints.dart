class EndPoints {
  static const String apiPath = "public/assessment/";
  static const String refreshToken = "auth/refresh-token";
  static const String venue = 'venue';
  static String catalog(String venueId) => 'venue/$venueId/catalog';
}
