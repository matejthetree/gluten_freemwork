import 'package:gluten_freemwork/framework/api/i_matcher.dart';


abstract class ITypeFilter extends IMatcher
{
	List<Type> get allOfTypes;

	List<Type> get anyOfTypes;

	List<Type> get noneOfTypes;
	
	String get descriptor;
}