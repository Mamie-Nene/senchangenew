import 'package:senchange/src/methods/storage_management.dart';

class HttpHeadersGlobalVariable {

  getToken() async{
    //return await SecureStorageService.getToken('access_token');

    return  await StorageManagement.getStorage('access_token');
  }

  getHeaders(){
    final token = getToken();

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }


}