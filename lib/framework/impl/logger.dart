import 'package:gluten_freemwork/framework/api/i_log_target.dart';
import 'package:gluten_freemwork/framework/api/i_logger.dart';


class Logger implements ILogger
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	dynamic _source;
	
	ILogTarget _target;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	Logger(this._source, this._target);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void debug(dynamic message, [List<dynamic> params])
	{
		_target.log(_source, 32, new DateTime.now(), message, params);
	}

	void info(dynamic message, [List<dynamic> params])
	{
		_target.log(_source, 16, new DateTime.now(), message, params);
	}

	void warn(dynamic message, [List<dynamic> params])
	{
		_target.log(_source, 8, new DateTime.now(), message, params);
	}
	
	void error(dynamic message, [List<dynamic> params])
	{
		_target.log(_source, 4, new DateTime.now(), message, params);
	}

	void fatal(dynamic message, [List<dynamic> params])
	{
		_target.log(_source, 2, new DateTime.now(), message, params);
	}
}