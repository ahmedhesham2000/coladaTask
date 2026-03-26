class AppConstants {
  static const String appName = "J Smash";
  static const String appVersion = "1.0.0";

  // API
  static const String baseUrl =
      "https://backend.coladaapp.io/public/assessment/";
  static const String apiVersion = "v1/";
  static const String contentType = "application/json";

  static const int deliveryTimeInMinutes = 60;

  // ASSETS
  static const String assetIcons = "assets/images/icons/";
  static const String assetImages = "assets/images/";
  static const String assetTranslations = "assets/translations";

  // SOCIAL MEDIA
  static const String facebookUrl = "";
  static const String twitterUrl = "";
  static const String termsConditionsUrl = "";
  static const String privacyPolicayUrl = "";

  // API CONSTANTS
  static dynamic requestHeaders = {
    'Content-Type': 'application/json',
    'channel': 'Mobile',
    'Charset': 'utf-8',
  };
  // API CONSTANTS
  static dynamic requestHeadersUAE = {
    'Content-Type': 'application/json',
    'channel': 'DigitalNativeApp',
    'Charset': 'utf-8',
  };

  // THEME CONSTANTS
  static const String fontFamily = "WorkSans";
  static const String seconedFontFamily = "Montserrat";
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double borderRadius = 20.0;

  static const int typeTerms = 1;
  static const int typeAutoPay = 2;

  static var isUpdate = 'is_update';

  static const addressStep = 1;
  static const businessStep = 2;
  static const paymentStep = 3;
  static var shiftTypeParam = 'shift_time_param';
  static var addressEntity = "addressEntity";
  static const String googlePlayIdentifier = "com.eand.smbapp";
  static String eidFrontBase64Key = 'eidFrontBase64';
  static String eidDocumentsEntityKey = 'eidDocumentsEntity';
}

class SharedPreferencesKeys {
  static const String profileImage = "profile_image";
  static String intermediaryAccountIdKey = 'intermediaryAccountId';
  static String eidFrontBase64Key = 'eidFrontBase64';
  static String eidDocumentsEntityKey = 'eidDocumentsEntity';
  static String emailKey = 'email';
  static String phoneKey = 'phone';
  static String userName = 'name';
  static String partyID = 'partyId';
  static String isAutoPayExpired = 'isAutoPayExpired';
  static var user = "user";

  static var isLogged = "isLogged";

  static var currentLang = 'currentLang';
}
