import 'package:gluten_freemwork/framework/api/i_log_target.dart';
import 'package:gluten_freemwork/framework/api/i_logger.dart';
import 'package:gluten_freemwork/framework/api/log_level.dart';
import 'package:gluten_freemwork/framework/impl/logger.dart';

class LogManager implements ILogTarget
{

  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  int _logLevel = LogLevel.INFO;
  int get logLevel => _logLevel;
  set logLevel(int value) => _logLevel = value;

  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final List<ILogTarget> _targets = List<ILogTarget>();

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  ILogger getLogger(dynamic source) => Logger(source, this);

  void addLogTarget(ILogTarget target) => _targets.add(target);

  void log(
      dynamic source,
      int level,
      DateTime timestamp,
      String message,
      [List<dynamic> params])
  {
    if(level > _logLevel)
      return;

    _targets.forEach( (ILogTarget target)
    {
      target.log(source, level, timestamp, message, params);
    });
  }
}