import 'package:gluten_freemwork/framework/api/i_context.dart';
import 'package:gluten_freemwork/framework/api/i_log_target.dart';
import 'package:gluten_freemwork/framework/api/log_level.dart';
import 'package:gluten_freemwork/framework/extensions/enhanced_logging/impl/log_message_parser.dart';


class PrintLogTarget implements ILogTarget
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	LogMessageParser _messageParser = new LogMessageParser();
	
	IContext _context;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	PrintLogTarget(this._context);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void log(dynamic source, int level, DateTime timestamp, String message, [List<dynamic> params])
	{
		print(timestamp.toString()
				+ ' ' + LogLevel.NAME[level].toString()
				+ ' ' + _context.runtimeType.toString()
				+ ' ' + source.runtimeType.toString()
				+ ' ' + _messageParser.parseMessage(message, params));
	}
}