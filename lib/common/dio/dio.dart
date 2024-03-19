import 'package:dio/dio.dart';
import 'package:flutter_riverpod/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청 보낼떄
  // 요청이 보내질떄마다 만약 요청의 Header에 accessToken=true 라는 값이있으면
  // 실제 토큰을 가져와서(storage에서 가져옴) authorization : bearer $token으로 헤더를 변경
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("[REQ] [${options.method}] ${options.uri}");

    if (options.headers["accessToken"] == "true") {
      //헤더 삭제
      options.headers.remove("accessToken");

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      //실제 토큰으로 대체
      options.headers.addAll({
        "authorization": "Bearer $token",
      });
    }

    if (options.headers["refreshToken"] == "true") {
      //헤더 삭제
      options.headers.remove("refreshToken");

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      //실제 토큰으로 대체
      options.headers.addAll({
        "authorization": "Bearer $token",
      });
    }

    return super.onRequest(options, handler);
  }
  // 2) 응답 받을떄
  // 3) 에러 났을때
}
