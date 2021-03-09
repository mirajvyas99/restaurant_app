import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/main_model.dart';
import 'signin_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toggleVisibility = true;
  // bool _toggleConfirmVisibility = true;

  String _email;
  String _username;
  String _password;
  // String _confirmPassword;

  GlobalKey<FormState> _formKey = GlobalKey();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18.0)),
      onSaved: (String email) {
        _email = email.trim();
      },
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Email is incorrect";
        }
        if (email.isEmpty) {
          errorMessage = "Email is required";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildUserNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: 'Username',
          hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18.0)),
      onSaved: (String username) {
        _username = username.trim();
      },
      validator: (String username) {
        String errorMessage;
        if (username.isEmpty) {
          errorMessage = "Username is required";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Password',
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
      onSaved: (String password) {
        _password = password.trim();
      },
      validator: (String password) {
        String errorMessage;
        if (password.length < 6) {
          errorMessage = "Password must be more than 6 characters";
        }
        if (password.isEmpty) {
          errorMessage = "Password is required";
        }
        return errorMessage;
      },
    );
  }

  // Widget _buildConfirmPasswordTextField() {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       hintText: 'Confirm Password',
  //       hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18.0),
  //       suffixIcon: IconButton(
  //         onPressed: () {
  //           setState(() {
  //             _toggleConfirmVisibility = !_toggleConfirmVisibility;
  //           });
  //         },
  //         icon: _toggleConfirmVisibility
  //             ? Icon(Icons.visibility_off)
  //             : Icon(Icons.visibility),
  //       ),
  //     ),
  //     obscureText: _toggleConfirmVisibility,
  //     onSaved: (String value){},
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50.0),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _buildUserNameTextField(),
                        SizedBox(height: 20.0),
                        _buildEmailTextField(),
                        SizedBox(height: 20.0),
                        _buildPasswordTextField(),
                        // SizedBox(height: 20.0),
                        // _buildConfirmPasswordTextField(),
                        // SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildSignUpButton(),
                Divider(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already Have an account ?',
                      style: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => SignInPage()));
                      },
                      child: Text(
                        'Sign In',
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

  Widget _buildSignUpButton() {
    return ScopedModelDescendant(
      builder: (BuildContext sctx, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            onSubmit(model.authenticate);
          },
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
          ),
        );
      },
    );
  }

  void onSubmit(Function authenticate) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }
    print("The Email: $_email, The Password: $_password");
    authenticate(_email, _password);
  }
}
