import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:save_enerrgy/screens/loginScreen/models/AuthAdminRes.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiManager{
  static Future<UserDataRes> createAccount(String email,String pass,String name,String phone, String gender)async{
    var url = Uri.https('solar-system-pi-black.vercel.app', '/v1/users/signup');
    var response = await http.post(url,body: {
      "fullName": name,
      "email": email,
      "password": pass,
      "gender": gender,
      "phoneNumber": phone,
    });
    var json = jsonDecode(response.body);
    return UserDataRes.fromJson(json);
  }
  static Future<UserDataRes> loginAccount(String email,String pass)async{
    var url = Uri.https('solar-system-pi-black.vercel.app', '/v1/users/signin');
    var response = await http.post(url,body: {
      "email": email,
      "password": pass,
    });
    var json = jsonDecode(response.body);
    return UserDataRes.fromJson(json);
  }
  static Future<UserDataRes> getDataUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('solar-system-pi-black.vercel.app', '/v1/users',{
      'id':prefs.getString('tokenAdmin')
    });
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return UserDataRes.fromJson(json);
  }

  static Future<UserDataRes> connectDevice()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('solar-system-pi-black.vercel.app', '/v1/devices/1',);
    var response = await http.put(url,body: {
      'id':prefs.getString('tokenAdmin')
    });
    var json = jsonDecode(response.body);
    return UserDataRes.fromJson(json);
  }
}

