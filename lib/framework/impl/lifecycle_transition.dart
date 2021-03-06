import 'package:gluten_freemwork/framework/api/lifecycle_error.dart';
import 'package:gluten_freemwork/framework/impl/lifecycle.dart';
import 'package:gluten_freemwork/framework/impl/message_dispatcher.dart';


class LifecycleTransition
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------
	
	final List<String> _fromStates = new List<String>();
	
	final MessageDispatcher _dispatcher = new MessageDispatcher();
	
	final List _callbacks = [];
	
	Symbol _name;
	
	Lifecycle _lifecycle;
	
	String _transitionState;
	
	String _finalState;
	
	Symbol _preTransitionMessage;
	
	Symbol _transitionMessage;
	
	Symbol _postTransitionMessage;
	
	String _initialState;
	
	bool _reverse = false;
	
  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------
	
	LifecycleTransition(this._name, this._lifecycle);
	
  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------
	
	LifecycleTransition fromStates(List<String> states)
	{
		states.forEach( (String state)
		{
			_fromStates.add(state);
		});
		return this;
	}
	
	LifecycleTransition toStates(String transitionState, String finalState)
	{
		_transitionState = transitionState;
		_finalState = finalState;
		return this;
	}

	LifecycleTransition inReverse()
	{
		_reverse = true;
		return this;
	}
	
	LifecycleTransition addBeforeHandler(Function handler)
	{
		_dispatcher.addMessageHandler(_name, handler);
		return this;
	}
	
	void enter([Function callback])
	{
		if (_lifecycle.state == _finalState)
		{
			if (callback != null)
				callback(null, _name);
			
			return;
		}
		
		if (_lifecycle.state == _transitionState)
		{
			if (callback != null)
				_callbacks.add(callback);
			return;
		}
		
		if (_invalidTransition())
		{
			_reportError("Invalid transition", [callback]);
			return;
		}
		
		_initialState = _lifecycle.state;
		
		if (callback != null)
			_callbacks.add(callback);
		
		_setState(_transitionState);
		
		_dispatcher.dispatchMessage(_name, enterCallback, _reverse);
	}
	
	void enterCallback(error)
	{
		if (error != null)
		{
			_setState(_initialState);
			_reportError(error, _callbacks);
			return;
		}
		
//		_dispatch(_preTransitionMessage);
//    _dispatch(_transitionMessage);
    
    _setState(_finalState);
    
    final List callbacks = _callbacks;
    _callbacks.length = 0;
    
    callbacks.forEach( (callback) {
    	callback(null, _name);
    });
    
//    _dispatch(_postTransitionMessage);
	}
	
  //-----------------------------------
  //
  // Private Methods
  //
  //-----------------------------------
	
	bool _invalidTransition()
	{
		return _fromStates.length > 0
				&& _fromStates.indexOf(_lifecycle.state) == -1;
	}
	
	void _setState(String state)
	{
		if (state != null)
			_lifecycle.setCurrentState(state);
	}
	
//	void _dispatch(Symbol messageName)
//	{
//		if (messageName != '' && _lifecycle.hasEventListener(messageName))
//			_lifecycle.dispatchEvent(messageName);
//	}
	
	void _reportError(dynamic message, List callbacks)
	{

		throw new LifecycleError(message);

	}
}