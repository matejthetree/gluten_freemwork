
class Pin
{
  //-----------------------------------
  //
  // Private Properties
  //
  //-----------------------------------

  final Map<dynamic, bool> _instances = new Map<dynamic, bool>();


  //-----------------------------------
  //
  // Constructor
  //
  //-----------------------------------

  Pin();

  //-----------------------------------
  //
  // Public Methods
  //
  //-----------------------------------

  void detain(dynamic instance)
  {
    if (_instances[instance] == null)
    {
      _instances[instance] = true;
    }
  }

  void release(dynamic instance)
  {
    if (_instances[instance] != null)
    {
      _instances.remove(instance);
    }
  }

  void releaseAll()
  {
    _instances.forEach( (dynamic instance, bool pinned) => release(instance));
  }
}