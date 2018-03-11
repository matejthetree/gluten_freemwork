abstract class ICommandMapper
{
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
  ICommandConfigurator toCommand(Type commandClass);
}