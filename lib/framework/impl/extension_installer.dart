import 'package:gluten_freemwork/framework/api/i_context.dart';
import 'package:gluten_freemwork/framework/api/i_extension.dart';
import 'package:gluten_freemwork/framework/api/i_logger.dart';
import 'package:organic_injection/src/i_injector.dart';

class ExtensionInstaller {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  Map<Type, bool> _classes = new Map<Type, bool>();

  IContext _context;

  ILogger _logger;

  IInjector _injector;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  ExtensionInstaller(this._context) {
    _logger = _context.getLogger(this);

    _injector = _context.injector;
  }

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void install(IExtension extension) {

    final Type extensionsClass = extension.runtimeType;
    if (_classes[extensionsClass] != null) return;
    _logger.debug("Installing extension {0}", [extension]);
    _classes[extensionsClass] = true;
    extension.extend(_context);
  }
}
