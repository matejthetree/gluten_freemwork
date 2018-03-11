import 'package:gluten_freemwork/framework/api/i_context.dart';
import 'package:organic_injection/organic_injection.dart';

class LoggerProvider implements IProvider {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  IContext _context;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  LoggerProvider(this._context);

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  dynamic apply({Type type}) {
    return _context.getLogger(type);
  }

  void destroy() {}
}
