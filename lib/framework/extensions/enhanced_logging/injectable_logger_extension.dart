import 'package:gluten_freemwork/framework/api/i_context.dart';
import 'package:gluten_freemwork/framework/api/i_extension.dart';
import 'package:gluten_freemwork/framework/api/i_logger.dart';
import 'package:gluten_freemwork/framework/extensions/enhanced_logging/impl/logger_provider.dart';

///
///
/// Allows us to inject ILogger for easy log level logging
class InjectableLoggerExtension implements IExtension
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		context.injector.mapToProvider(ILogger,new LoggerProvider(context));
	}
}