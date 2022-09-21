class ResponseModel{
  bool _isSuccess;
  String _message;
  //public cann't use curly bracket
  ResponseModel( this._isSuccess,  this ._message);
  String get message =>_message;
  bool get isSuccess => _isSuccess;

}