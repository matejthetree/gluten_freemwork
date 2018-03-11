import 'package:gluten_freemwork/framework/api/i_hook.dart';
import 'package:organic_injection/organic_injection.dart';


void applyHooks(List<IHook> hooks, [IInjector injector])
{
	hooks.forEach( (IHook hook)
	{
		hook.hook();
	});
}