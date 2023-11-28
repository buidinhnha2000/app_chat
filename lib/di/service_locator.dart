import 'package:get_it/get_it.dart';

class ServiceLocator {
  ServiceLocator._();

  static final _getIt = GetIt.instance;

  static final instance = ServiceLocator._();

  void registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? onDispose,
  }) {
    _getIt.registerSingleton<T>(
      instance,
      instanceName: instanceName,
      signalsReady: signalsReady,
      dispose: onDispose,
    );
  }

  void registerSingletonAsync<T extends Object>(
    Future<T> Function() asyncInstance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? onDispose,
  }) {
    _getIt.registerSingletonAsync(
      asyncInstance,
      instanceName: instanceName,
      signalsReady: signalsReady,
      dispose: onDispose,
    );
  }

  void registerLazySingleton<T extends Object>(
    T Function() asyncInstance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? onDispose,
  }) {
    _getIt.registerLazySingleton(
      asyncInstance,
      instanceName: instanceName,
      dispose: onDispose,
    );
  }

  void registerLazySingletonAsync<T extends Object>(
    Future<T> Function() asyncInstance, {
    String? instanceName,
    bool? signalsReady,
    DisposingFunc<T>? onDispose,
  }) {
    _getIt.registerLazySingletonAsync(
      asyncInstance,
      instanceName: instanceName,
      dispose: onDispose,
    );
  }

  T inject<T extends Object>({String? instanceName}) =>
      _getIt.get<T>(instanceName: instanceName);

  Future<T> injectAsync<T extends Object>({String? instanceName}) =>
      _getIt.getAsync<T>(instanceName: instanceName);
}
