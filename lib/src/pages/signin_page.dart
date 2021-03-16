import 'package:restaurant_app/src/scoped-model/main_model.dart';
import 'package:restaurant_app/src/utils/preference_helper.dart';
import 'package:restaurant_app/src/widgets/button.dart';
import 'package:restaurant_app/src/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

import 'signup_page.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _toggleVisibility = true;
  bool _isSignedIn = false;

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String _email;
  String _password;

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18.0)),
      onSaved: (String email){
        _email = email;
      },
      validator: (String email){
        String errorMessage;
        if(!email.contains("@")){
          errorMessage = "Email is incorrect";
        }
        if(email.isEmpty){
          errorMessage = "Email is required";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Your Password',
        hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18.0),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
      onSaved: (String password){
        _password = password;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 100.0),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _buildEmailTextField(),
                        SizedBox(height: 20.0),
                        _buildPasswordTextField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildSignInButton(),
                Divider(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don\'t Have an account ?',
                      style: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SignUpPage()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(){
    return ScopedModelDescendant(
      builder: (BuildContext sctx, Widget child, MainModel model){
        return GestureDetector(
          onTap: (){
            showLoadingIndicator(context, "Signing in...");
            onSubmit(model.authenticate);
          },
          child: Button(btnText: "Sign In"),
        );
      }
    );
  }

  void onSubmit(Function authenticate){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      authenticate(_email,_password).then((final response){
        if(!response['hasError']){
          PreferenceHelper.load().whenComplete((){
            PreferenceHelper.setLoggedIn(true);
            PreferenceHelper.setId(response['data'].id);
            PreferenceHelper.setEmail(_email);
          });
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/mainscreen");
        }else{
          Navigator.of(context).pop();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
              content: Text(response['message']),
            ),
          );
        }
      });
    }
  }
}
