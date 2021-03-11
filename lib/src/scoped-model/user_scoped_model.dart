import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  User _authenticatedUser;
  bool _isLoading = false;

  User get authenticatedUser{
    return _authenticatedUser;
  }
  
  bool get isLoading{
    return _isLoading;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password) async {
    
    _isLoading = true;
    notifyListeners();
    
    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };
    String message;
    bool hasError = false;

    try {
      http.Response response = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCJMifZBzjK32fKohdlON-GdlruDRo3LuM",
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
      
      Map<String, dynamic> responseBody = json.decode(response.body);

      if(responseBody.containsKey('idToken')){
        _authenticatedUser = User(
        id: responseBody['localId'],
        email: responseBody['email'],
        token: responseBody['idToken'],
        userType: 'customer',
      );
      message = "Signed Up Successfully";
      }else{
        if(responseBody['error']['message'] == 'EMAIL_EXISTS'){
          hasError = true;
          message = "Email already exists";
          // print("Email already exists");
        }
      }

      print("Printing the user token: ${_authenticatedUser.token}");

      _isLoading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError,
      };
    } catch (error) {

      _isLoading = false;
      notifyListeners();

      return{
        'message': 'Failed to Sign up',
        'hasError': !hasError,
      };
    }
  }
}
