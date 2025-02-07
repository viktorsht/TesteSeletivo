import 'package:go_fidelidade/data/repositories/home_repository.dart';
import 'package:go_fidelidade/data/services/client_service.dart';
import 'package:go_fidelidade/domain/api_response.dart';

class HomeRepositoryRemote implements HomeRepository {
  final ClientService service;

  HomeRepositoryRemote(this.service);

  @override
  Future<ApiResponse> getData() async {
    try {
      final response = await service.get('https://www.jsonkeeper.com/b/1IXK');
      return ApiResponse.fromJson(response);
    } catch (e) {
      return ApiResponse.empty();
    }
  }
}