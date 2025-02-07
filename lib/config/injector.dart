import 'package:auto_injector/auto_injector.dart';
import 'package:go_fidelidade/data/repositories/home_repository.dart';
import 'package:go_fidelidade/data/repositories/home_repository_remote.dart';
import 'package:go_fidelidade/data/services/client_service.dart';
import 'package:go_fidelidade/data/services/client_service_http.dart';
import 'package:go_fidelidade/ui/home/viewmodel/home_viewmodel.dart';
import 'package:http/http.dart' as http;

final injector = AutoInjector();

void setupDependencies(){
  injector.addSingleton<HomeRepository>(HomeRepositoryRemote.new);
  injector.addSingleton<ClientService>(ClientServiceHttp.new);
  injector.addSingleton(HomeViewModel.new);
  injector.add(http.Client.new);
}