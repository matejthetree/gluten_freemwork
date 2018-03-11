import 'package:gluten_freemwork/framework/api/i_config.dart';
import 'package:gluten_freemwork/framework/extensions/context_view/context_view.dart';
import 'package:gluten_freemwork/framework/extensions/view_manager/api/i_view_manager.dart';
import 'package:organic_injection/src/injectables/injectable.dart';

class ContextViewListenerConfig implements IConfig
{
  @override
  List<In> getInjectas() => [InFn(configure,params: [InFd(IViewManager),InFd(ContextView)])];


	void configure(IViewManager viewManager, ContextView contextView)
	{
		viewManager.addContainer(contextView.view);
	}
}