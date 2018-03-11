import 'package:gluten_freemwork/framework/api/i_lifecycle.dart';
import 'package:gluten_freemwork/framework/api/lifecycle_error.dart';
import 'package:gluten_freemwork/framework/api/lifecycle_message.dart';
import 'package:gluten_freemwork/framework/api/lifecycle_state.dart';
import 'package:gluten_freemwork/framework/impl/lifecycle_transition.dart';
import 'package:gluten_freemwork/framework/impl/message_dispatcher.dart';

class Lifecycle implements ILifecycle {
  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  String _state = LifecycleState.UNINITIALIZED;

  String get state => _state;

  dynamic _target;

  dynamic get target => _target;

  bool get uninitialized => (_state == LifecycleState.UNINITIALIZED);

  bool get initialized =>
      _state != LifecycleState.UNINITIALIZED &&
      _state != LifecycleState.INITIALIZING;

  bool get active => _state == LifecycleState.ACTIVE;

  bool get suspended => _state == LifecycleState.SUSPENDED;

  bool get destroyed => _state == LifecycleState.DESTROYED;

  //-----------------------------------
  //
  // Public Properties
  //
  //-----------------------------------

  final Map _reversedEventTypes = new Map();

  int _reversePriority;

  LifecycleTransition _initialize;

  LifecycleTransition _suspend;

  LifecycleTransition _resume;

  LifecycleTransition _destroy;

  MessageDispatcher _dispatcher;

  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  Lifecycle(this._target) {
    if (target != null) _dispatcher = target as MessageDispatcher;

    _configureTransitions();
  }

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void initialize([Function callback = null]) {
    _initialize.enter(callback);
  }

  void suspend([Function callback = null]) {
    _suspend.enter(callback);
  }

  void resume([Function callback = null]) {
    _resume.enter(callback);
  }

  void destroy([Function callback = null]) {
    _destroy.enter(callback);
  }

  ILifecycle beforeInitializing(Function handler) {
    if (!uninitialized) _reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);

    _initialize.addBeforeHandler(handler);
    return this;
  }

  ILifecycle whenInitializing(Function handler) {
    if (initialized) _reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);

    return this;
  }

  ILifecycle afterInitializing(Function handler) {
    if (initialized) _reportError(LifecycleError.LATE_HANDLER_ERROR_MESSAGE);
    return this;
  }

  ILifecycle beforeSuspending(Function handler) {
    _suspend.addBeforeHandler(handler);
    return this;
  }

  ILifecycle whenSuspending(Function handler) {
    return this;
  }

  ILifecycle afterSuspending(Function handler) {
    return this;
  }

  ILifecycle beforeResuming(Function handler) {
    _resume.addBeforeHandler(handler);
    return this;
  }

  ILifecycle whenResuming(Function handler) {
    return this;
  }

  ILifecycle afterResuming(Function handler) {
    return this;
  }

  ILifecycle beforeDestroying(Function handler) {
    _destroy.addBeforeHandler(handler);
    return this;
  }

  ILifecycle whenDestroying(Function handler) {
    return this;
  }

  ILifecycle afterDestroying(Function handler) {
    return this;
  }

  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------

  void setCurrentState(String state) {
    if (_state == state) return;
    _state = state;
  }

  void _addReversedEventTypes(List types) {
    types.forEach((type) {
      _reversedEventTypes[type] = true;
    });
  }

  void _configureTransitions() {
    _initialize = new LifecycleTransition(LifecycleMessage.PRE_INITIALIZE, this)
        .fromStates([LifecycleState.UNINITIALIZED]).toStates(
            LifecycleState.INITIALIZING, LifecycleState.ACTIVE);

    _suspend = new LifecycleTransition(LifecycleMessage.PRE_SUSPEND, this)
        .fromStates([LifecycleState.ACTIVE])
        .toStates(LifecycleState.SUSPENDING, LifecycleState.SUSPENDED)
        .inReverse();

    _resume = new LifecycleTransition(LifecycleMessage.PRE_RESUME, this)
        .fromStates([LifecycleState.SUSPENDED]).toStates(
            LifecycleState.RESUMING, LifecycleState.ACTIVE);

    _destroy = new LifecycleTransition(LifecycleMessage.PRE_DESTROY, this)
        .fromStates([LifecycleState.SUSPENDED, LifecycleState.ACTIVE])
        .toStates(LifecycleState.DESTROYING, LifecycleState.DESTROYED)
        .inReverse();
  }

  int flipPriority(String type, int priority) {
    return (priority == 0 && _reversedEventTypes[type])
        ? _reversePriority++
        : priority;
  }

  void _reportError(String message) {
    LifecycleError error = new LifecycleError(message);
    throw error;
  }
}
