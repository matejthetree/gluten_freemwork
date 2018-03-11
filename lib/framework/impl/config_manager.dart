import 'package:gluten_freemwork/framework/api/i_config.dart';
import 'package:gluten_freemwork/framework/api/i_context.dart';
import 'package:gluten_freemwork/framework/api/i_logger.dart';
import 'package:gluten_freemwork/framework/api/i_matcher.dart';
import 'package:gluten_freemwork/framework/impl/object_processor.dart';
import 'package:organic_injection/organic_injection.dart';

class ConfigManager {
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final ObjectProcessor _objectProcessor = new ObjectProcessor();

  final Map _configs = new Map();

  final List<IConfig> _queue = [];

  IInjector _injector;

  ILogger _logger;

  bool _initialized = false;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  ConfigManager(IContext context) {
    _injector = context.injector;
    _logger = context.getLogger(this);
    addConfigHandler(new ObjectMatcher(), _handleObject);

    context.initialize(_initialize);
  }

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void addConfig(dynamic config) {
    if (_configs[config] == null) {
      _configs[config] = true;
      _objectProcessor.processObject(config);
    }
  }

  void addConfigHandler(IMatcher matcher, Function handler) {
    _objectProcessor.addObjectHandler(matcher, handler);
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  void _initialize() {
    if (!_initialized) {
      _initialized = true;
      _processQueue();
    }
  }

  void _handleObject(dynamic object) {
    if (_initialized) {
      _logger.debug(
          "Already initialized. Injecting into config object {0}", [object]);
      _processObject(object);
    } else {
      _logger.debug("Not yet initialized. Queuing config object {0}", [object]);
      _queue.add(object);
    }
  }

  void _processQueue() {
    _queue.forEach((IConfig config) {
        _logger.debug(
            "Now initializing. Injecting into config object {0}", [config]);
        _processObject(config);
    });

    _queue.clear();
  }

  void _processObject(IConfig object) {
    _injector.injectInto(object);
    if (object != null && object is IConfig) object.configure();
  }
}

class ObjectMatcher implements IMatcher {
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  bool matches(dynamic item) {
    return item is! Type;
  }
}
