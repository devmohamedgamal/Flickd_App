//Packages
import 'package:get_it/get_it.dart';

//Services
import '../services/http_service.dart';

class MovieServics {
  final GetIt getIt = GetIt.instance;

  late HttpService httpService;

  MovieServics() {
    httpService = getIt.get<HttpService>();
  }
}
