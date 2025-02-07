import 'package:go_fidelidade/domain/api_response.dart';

abstract class HomeRepository {
  Future<ApiResponse> getData();
}