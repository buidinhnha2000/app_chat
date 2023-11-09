import 'package:flutter/material.dart';

import 'app_flavor.dart';
import 'bootstrap.dart';
import 'data/remote/remote.dart';
import 'di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient(baseUrl: AppFlavor.staging.baseUrl);

  final serviceLocator = ServiceLocator.instance;
  serviceLocator.registerSingleton(dioClient);
  serviceLocator.configureNetworkModule(AppFlavor.staging);

  bootstrap();
}
