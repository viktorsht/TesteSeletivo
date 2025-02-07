import 'package:flutter/material.dart';
import 'package:go_fidelidade/data/repositories/home_repository.dart';
import 'package:go_fidelidade/domain/motel.dart';
import 'package:go_fidelidade/utils/command.dart';
import 'package:go_fidelidade/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  final Command0<List<Motel>> fetchMoteisCommand;

  HomeViewModel(HomeRepository homeRepository)
      : fetchMoteisCommand = Command0(() async {
          try {
            final response = await homeRepository.getData();
            if (response.sucesso) {
              return Result.ok((response.data?.moteis ?? []));
            } else {
              return Result.error(Exception("Erro ao buscar moteis."));
            }
          } catch (e) {
            return Result.error(Exception("Erro inesperado: $e"));
          }
        });

  void fetchMoteis() {
    fetchMoteisCommand.execute();
    notifyListeners();
  }

}
