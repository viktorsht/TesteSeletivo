// Implementação do ClientService usando o pacote HTTP

import 'dart:convert';

import 'package:go_fidelidade/data/services/client_service.dart';
import 'package:http/http.dart' as http;

class ClientServiceHttp implements ClientService {
  final http.Client _httpClient;

  ClientServiceHttp({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final response = await _httpClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedBody = utf8.decode(response.bodyBytes);
        return jsonDecode(decodedBody) as Map<String, dynamic>;
      } else {
        throw Exception('Erro ao buscar dados: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição GET: $e');
    }
  }

  void dispose() {
    _httpClient.close();
  }
}