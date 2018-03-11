import 'package:gluten_freemwork/framework/extensions/matching/type_matcher.dart';


abstract class ITypeMatcherFactory
{
	TypeMatcher clone();
}