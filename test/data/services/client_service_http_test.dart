import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_fidelidade/data/services/client_service_http.dart';
import 'package:http/http.dart' as http;

// Criando um mock do http.Client
class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ClientServiceHttp clientService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    clientService = ClientServiceHttp(httpClient: mockHttpClient);
  });

  group('ClientServiceHttp', () {
    test('deve retornar dados quando a requisição GET for bem-sucedida', () async {
      // Mock da resposta da requisição HTTP
      final url = 'https://www.jsonkeeper.com/b/1IXK';
      final response = {'data': 'some data'};

      // Definir o comportamento do mock para a função GET
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response(jsonEncode(response), 200));

      // Chamar o método get
      final result = await clientService.get(url);

      // Verificar se o retorno está correto
      expect(result, isA<Map<String, dynamic>>());
      expect(result['data'], 'some data');
    });

    test('deve lançar uma exceção quando o status da resposta não for 200', () async {
      final url = 'https://www.jsonkeeper.com/b/1IXK';

      // Mock de uma resposta com status de erro
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenAnswer((_) async => http.Response('Erro', 404));

      // Verificar se a exceção é lançada
      expect(() async => await clientService.get(url), throwsA(isA<Exception>()));
    });

    test('deve lançar uma exceção quando ocorrer um erro na requisição', () async {
      final url = 'https://www.jsonkeeper.com/b/1IXK';

      // Simulando erro no HTTP Client
      when(() => mockHttpClient.get(Uri.parse(url)))
          .thenThrow(Exception('Erro na requisição GET'));

      // Verificar se a exceção é lançada
      expect(() async => await clientService.get(url), throwsA(isA<Exception>()));
    });
  });

  tearDown(() {
    clientService.dispose();
  });
}
