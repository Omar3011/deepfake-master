import 'package:deepfake/Service/crud.dart';
import 'package:deepfake/constant/link_apis.dart';

class AuthRepo {
  Crud crud = Crud();

  signUp(Map<String, dynamic> data) async {
    var response = await crud.postData(AppLinks.signUp, data);
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  signIn(Map<String, dynamic> data) async {
    var response = await crud.postData(AppLinks.login, data);
    print(response);
    return response.fold((l) => l, (r) => r);
  }
}
 
/*

if (response["status" == "success"]) {
      print("=================================================success");
      return "success";
    } else {
      print("=================================================falure");
      return response;
    }
    */