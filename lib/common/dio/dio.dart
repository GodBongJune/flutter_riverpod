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
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}");

    return super.onResponse(response, handler);
  }

  // 3) 에러 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401에러 났을때 (status code)
    // 토큰을 재발급 받는 시도를하고 토큰이 재발급되면 다시 새로운 토큰으로 요청을한다.
    print("[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}");

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    //refreshToken이 아예 없으면 에러던짐
    if (refreshToken == null) {
      //에러를 던질때는 handel.reject 사용
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == "/auth/token";

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post(
          "http://$ip/auth/token",
          options: Options(
            headers: {
              "authorization": "Bearer $refreshToken",
            },
          ),
        );

        final accessToken = resp.data["accessToken"];

        final options = err.requestOptions;

        //토큰 업데이트
        options.headers.addAll({
          "authorization": "Bearer $accessToken",
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        //요청 재전송
        final response = await dio.fetch(options);

        //새로 보낸 요청의 응답
        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
