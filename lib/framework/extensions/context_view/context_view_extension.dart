import 'package:gluten_freemwork/framework/api/i_context.dart';
import 'package:gluten_freemwork/framework/api/i_extension.dart';
import 'package:gluten_freemwork/framework/api/i_logger.dart';
import 'package:gluten_freemwork/framework/extensions/context_view/context_view.dart';
import 'package:gluten_freemwork/framework/extensions/matching/instance_of_type.dart';
import 'package:organic_injection/organic_injection.dart';


class ContextViewExtension implements IExtension
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	IInjector _injector;
	
	ILogger _logger;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	void extend(IContext context)
	{
		_injector = context.injector;
		_logger = context.getLogger(this);
		
		context
			..beforeInitializing(_beforeInitializing)
			..addConfigHandler(
				instanceOfType(ContextView), 
				_handleContextView);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	void _handleContextView(ContextView contextView)
	{
		if (_injector.hasMapping(ContextView))
		{
			_logger.warn('A contextView has already been installed, ignoring {0}', [contextView.view]);
		}
		else
		{
			_logger.debug("Mapping {0} as contextView", [contextView.view]);
    	_injector.mapToValue(ContextView,contextView);
		}
	}
	
	void _beforeInitializing()
	{
		if (!_injector.hasMapping(ContextView))
		{
			_logger.error("A ContextView must be installed if you install the ContextViewExtension.");
		}
	}
}