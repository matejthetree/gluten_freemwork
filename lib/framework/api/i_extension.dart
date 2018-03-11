import 'package:gluten_freemwork/framework/api/i_context.dart';


abstract class IExtension 
{
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context);
}