import 'package:gluten_freemwork/framework/api/i_bundle.dart';
import 'package:gluten_freemwork/framework/api/i_context.dart';
import 'package:gluten_freemwork/framework/api/log_level.dart';

class MVCSBundle implements IBundle
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend( IContext context ) 
	{
		context.logLevel = LogLevel.DEBUG;
		
		context.install(
				[ContextViewExtension,
				 PrintLoggingExtension,
				 ViewManagerExtension,
				 ViewProcessorMapExtension,
				 StageCrawlerExtension,
				 StageSyncExtension,
				 MessageDispatcherExtension,
				 MessageCommandMapExtension,
				 MediatorMapExtension]);
		
		context.configure([ContextViewListenerConfig]);
	}
}