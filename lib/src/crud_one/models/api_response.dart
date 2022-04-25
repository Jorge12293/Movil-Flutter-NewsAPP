class APIResponse<T>{
  T? data;
  bool error;
  String errorMensaje;

  APIResponse({this.data,this.error=false,this.errorMensaje=''});
}