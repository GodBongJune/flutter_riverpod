import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant/
  // @GET("/")
  // paginate();

  // http://$ip/restaurant/:id
  @GET("/{id}")
  @Headers({
    "authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNzEwODMzMTAwLCJleHAiOjE3MTA4MzM0MDB9.ioTWVdzIgdA4SwkP_IZKU0TL0TMlC9wZCv0lTcWI8fc"
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
