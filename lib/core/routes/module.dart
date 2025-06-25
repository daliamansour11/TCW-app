import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/core/routes/binds.dart';
import 'package:tcw/core/routes/modular_routes.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => modularBinds;

  @override
  List<ModularRoute> get routes => modularRoutes;
}
