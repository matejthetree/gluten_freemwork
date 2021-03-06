import 'package:gluten_freemwork/framework/api/i_config.dart';
import 'package:gluten_freemwork/framework/api/i_extension.dart';
import 'package:gluten_freemwork/framework/api/i_log_target.dart';
import 'package:gluten_freemwork/framework/api/i_logger.dart';
import 'package:gluten_freemwork/framework/api/i_matcher.dart';
import 'package:organic_injection/organic_injection.dart';

abstract class IContext
{
  IInjector get injector;

  int get logLevel;

  set logLevel(int value);

  String get state;

  bool get uninitialized;

  bool get initialized;

  bool get active;

  bool get suspended;

  bool get destroyed;

  IContext install(List<IExtension> extensions);

  IContext configure(List<IConfig> configs);

  IContext addChild(IContext child);

  IContext removeChild(IContext child);

  IContext addConfigHandler(IMatcher matcher, Function handler);

  ILogger getLogger(dynamic source);

  IContext addLogTarget(ILogTarget target);

  IContext detain(List<dynamic> instances);

  IContext release(List<dynamic> instances);

  void initialize([Function callback]);

  void suspend([Function callback]);

  void resume([Function callback]);

  void destroy([Function callback]);

  IContext beforeInitializing(Function handler);

  IContext whenInitializing(Function handler);

  IContext afterInitializing(Function handler);

  IContext beforeSuspending(Function handler);

  IContext whenSuspending(Function handler);

  IContext afterSuspending(Function handler);

  IContext beforeResuming(Function handler);

  IContext whenResuming(Function handler);

  IContext afterResuming(Function handler);

  IContext beforeDestroying(Function handler);

  IContext whenDestroying(Function handler);

  IContext afterDestroying(Function handler);

}

