// ignore_for_file: depend_on_referenced_packages

import 'package:coladatask/config/app_config.dart';
import 'package:coladatask/core/network/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService {
  static NetworkService? _this;

  factory NetworkService() {
    _this ??= NetworkService._();
    return _this!;
  }

  Dio unAuthedDio = Dio();
  Dio authenticatedDio = Dio();

  String? _token;
  String? _refreshToken;
  String lang = "en";

  Future<void> setLanguage(String lang) async {
    this.lang = lang;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("lang", lang);
    initializeInterceptors();
  }

  // final String _baseURL = AppConfig.instance.baseURL;
  final String _baseURL = AppConfig.instance.baseURL;

  NetworkService._() {
    unAuthedDio.options.baseUrl = _baseURL;
    unAuthedDio.options.connectTimeout = const Duration(milliseconds: 50000);

    authenticatedDio.options.baseUrl = _baseURL;
    authenticatedDio.options.connectTimeout = const Duration(
      milliseconds: 50000,
    );

    initializeInterceptors();
  }

  Future<void> setToken(String? token, String? refreshToken) async {
    _token = token;
    _refreshToken = refreshToken;
    if (token != null && refreshToken != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("userToken", token);
      preferences.setString("refreshToken", refreshToken);
    }
    initializeInterceptors();
  }

  void clearToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    _token = null;
    _refreshToken = null;
    initializeInterceptors();
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString("userToken");
    _refreshToken = preferences.getString("refreshToken");
    return _token;
  }

  void initializeInterceptors() {
    unAuthedDio.interceptors.clear();
    authenticatedDio.interceptors.clear();

    // Add headers to unAuthedDio
    unAuthedDio.options.headers = {'Accept-Language': lang};

    // Add headers to authenticatedDio
    authenticatedDio.options.headers = {
      'Accept-Language': lang,
      if (_token != null) 'Authorization': 'Bearer $_token',
    };

    unAuthedDio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        logPrint: (obj) => debugPrint(obj.toString()),
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );

    // Add token refresh interceptor
    authenticatedDio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Token expired, try to refresh it
            try {
              // Get refresh token from memory or SharedPreferences
              String? refreshToken = _refreshToken;
              if (refreshToken == null || refreshToken.isEmpty) {
                final prefs = await SharedPreferences.getInstance();
                refreshToken = prefs.getString('refreshToken');
              }

              // If no refresh token available, pass the error
              if (refreshToken == null || refreshToken.isEmpty) {
                return handler.next(error);
              }

              // Store the failed request to retry it later
              final options = error.requestOptions;

              // Make the refresh token request
              final refreshResponse = await unAuthedDio.post(
                EndPoints.refreshToken,
                data: {'token': refreshToken},
              );
              if (refreshResponse.statusCode == 200 &&
                  refreshResponse.data != null) {
                // Get new tokens
                final newToken = refreshResponse.data['data']['accessToken'];
                final newRefreshToken =
                    refreshResponse.data['data']['refreshToken'];

                // Update tokens
                await setToken(newToken, newRefreshToken);

                // Retry the failed request with new token
                final response = await authenticatedDio.request(
                  options.path,
                  data: options.data,
                  queryParameters: options.queryParameters,
                  options: Options(
                    method: options.method,
                    headers: {
                      ...options.headers,
                      'Authorization': 'Bearer $newToken',
                    },
                  ),
                );

                // Return the successful response
                return handler.resolve(response);
              }
            } catch (e) {
              // If refresh token also fails, clear tokens and redirect to login
              clearToken();
            }
          }

          // Continue with the error
          return handler.next(error);
        },
      ),
    );

    // Add logger interceptor
    authenticatedDio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        logPrint: (obj) => debugPrint(obj.toString()),
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }
}
