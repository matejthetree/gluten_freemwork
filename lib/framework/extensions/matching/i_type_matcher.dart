import 'package:gluten_freemwork/framework/extensions/matching/i_type_filter.dart';

abstract class ITypeMatcher
{
	ITypeFilter createTypeFilter();
}