import 'package:flutter_test/flutter_test.dart';
import 'package:go_fidelidade/data/repositories/home_repository_remote.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_fidelidade/data/repositories/home_repository.dart';
import 'package:go_fidelidade/data/services/client_service_http.dart';
import 'package:go_fidelidade/domain/api_response.dart';

// Criação de uma classe mock para ClientServiceHttp
class MockClientServiceHttp extends Mock implements ClientServiceHttp {}

void main() {
  late HomeRepository homeRepository;
  late MockClientServiceHttp mockClientServiceHttp;

  setUp(() {
    mockClientServiceHttp = MockClientServiceHttp();
    homeRepository = HomeRepositoryRemote(mockClientServiceHttp);
  });

  group('HomeRepositoryRemote', () {
    
    test('deve retornar ApiResponse com sucesso quando a chamada for bem-sucedida', () async {
      // Mock da resposta da API
      when(() => mockClientServiceHttp.get(any()))
          .thenAnswer((_) async => {
            'sucesso': true, // Agora o campo 'sucesso' é incluído
            'data': {'someField': 'some data'}, // Exemplo de dados
            'mensagem': [], // Caso haja uma mensagem vazia
          });

      final result = await homeRepository.getData();

      // Verificar se o resultado é uma resposta válida
      expect(result, isA<ApiResponse>());
      // Verificar que o campo 'sucesso' é verdadeiro
      expect(result.sucesso, true);
      // Verificar que a data não é nula
      expect(result.data, isNotNull);
      // Verificar que a mensagem está vazia (caso seja esperado no teste)
      expect(result.mensagem, isEmpty);
    });


    test('deve retornar ApiResponse vazio quando ocorrer um erro na chamada', () async {
      // Definir o comportamento do mock para lançar uma exceção
      when(() => mockClientServiceHttp.get(any())).thenThrow(Exception('Erro na requisição'));

      final result = await homeRepository.getData();

      // Verificar se o resultado é um ApiResponse vazio
      expect(result, isA<ApiResponse>());
      expect(result.sucesso, false);
    });
  });
}
