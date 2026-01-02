import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: 'https://api.gonana.com/api/v1/', // Placeholder URL
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
