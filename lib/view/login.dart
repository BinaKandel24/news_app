import 'package:flutter/material.dart';
import 'package:news_app/model/login_model.dart';
import 'package:news_app/progress_hud.dart';
import 'package:news_app/service/api_service.dart';
import 'package:news_app/view/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  LoginRequestModel _loginRequestModel;
  bool _isApiCallProcess = false;

  @override
  void initState() {
    _loginRequestModel = new LoginRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: _isApiCallProcess,
      opacity: 0.3,
    );
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: 20.0,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 85.0,
                    horizontal: 20.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0, 10),
                        blurRadius: 20.0,
                      ),
                    ],
                  ),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25.0,
                        ),
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => _loginRequestModel.email = input,
                          validator: (input) => !input.contains('@')
                              ? 'Email Id should be valid'
                              : null,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            prefixIcon: Icon(Icons.email,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (input) =>
                              _loginRequestModel.password = input,
                          validator: (input) => input.length < 5
                              ? 'password must be greater than 5 characters'
                              : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).accentColor,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(hidePassword ? 0.2 : 0.8),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          onPressed: () {
                            if (validateAndSave()) {
                              setState(() {
                                _isApiCallProcess = true;
                              });
                              APIService apiService = new APIService();
                              apiService
                                  .loginResponseModel(_loginRequestModel)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    _isApiCallProcess = false;
                                  });

                                  if (value.token.isNotEmpty) {
                                    final snackBar = SnackBar(
                                      content: Text("Login Successful"),
                                    );

                                    Navigator.pushNamed(context, '/home');
                                  } else {
                                    final snackBar = SnackBar(
                                      content: Text(value.error),
                                    );
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  }
                                }
                              });
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
