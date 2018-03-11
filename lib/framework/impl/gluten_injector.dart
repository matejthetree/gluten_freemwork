import 'package:organic_injection/organic_injection.dart';


class GlutenInjector extends Injector implements IInjector
{
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------
	
	set parent(IInjector value) => this.parentInjector = value;
	
	IInjector get parent => this.parentInjector;
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	IInjector createChild()
	{
		final IInjector childInjector = new GlutenInjector();
		childInjector.parentInjector = this;
		return childInjector;
	}
}