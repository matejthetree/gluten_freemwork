import 'package:gluten_freemwork/framework/api/i_context.dart';
import 'package:gluten_freemwork/framework/api/i_extension.dart';
import 'package:gluten_freemwork/framework/extensions/enhanced_logging/impl/print_log_target.dart';


///
///
/// all framework logs will be printed out in the console
class PrintLoggingExtension implements IExtension
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		context.addLogTarget(new PrintLogTarget(context));
	}
}