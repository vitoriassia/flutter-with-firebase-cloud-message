import 'package:app_modular/app/core/services/push_notification_service.dart';
import 'package:app_modular/app/modules/auth/auth_module.dart';
import 'package:app_modular/app/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PushNotificationServiceFirebaseImp())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => SplashPage()),
    ModuleRoute('/auth', module: AuthModule())
  ];
}
