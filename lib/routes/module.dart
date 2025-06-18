import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/routes/binds.dart';
import 'modular_routes.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => modularBinds;

  @override
  List<ModularRoute> get routes => modularRoutes;
}
