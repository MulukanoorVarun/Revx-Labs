import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/CustomSnackBar.dart';
import 'package:revxpharma/Components/ShakeWidget.dart';
import 'package:revxpharma/Patient/logic/cubit/login/login_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/login/login_state.dart';
import 'package:revxpharma/Services/AuthService.dart';
import 'package:revxpharma/Utils/Preferances.dart';
import 'package:revxpharma/Utils/color.dart';

class LogInWithEmail extends StatefulWidget {
  @override
  State<LogInWithEmail> createState() => _LogInWithEmailState();
}

class _LogInWithEmailState extends State<LogInWithEmail> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  String _validateEmail = '';
  String _validatepwd = '';

  void _validatefeilds() {
    setState(() {
      _validateEmail =
          !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(_emailController.text)
              ? 'Please enter a valid email'
              : '';
      _validatepwd = _pwdController.text.isEmpty
          ? 'Please enter a password'
          : _pwdController.text.length < 8
              ? 'Password must be at least 8 characters long'
              : !RegExp(r'^(?=.*[a-z])').hasMatch(_pwdController.text)
                  ? 'Password must contain at least one lowercase letter'
                  : !RegExp(r'^(?=.*[A-Z])').hasMatch(_pwdController.text)
                      ? 'Password must contain at least one uppercase letter'
                      : !RegExp(r'^(?=.*[0-9])').hasMatch(_pwdController.text)
                          ? 'Password must contain at least one number'
                          : !RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])')
                                  .hasMatch(_pwdController.text)
                              ? 'Password must contain at least one special character'
                              : '';
      if (_validateEmail.isEmpty && _validatepwd.isEmpty) {
        Map<String, dynamic> data = {
          "email": _emailController.text,
          "password": _pwdController.text,
        };
        context.read<LoginCubit>().postLogin(data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.settings?.success == 1) {
            PreferenceService().saveString('access_token', state.loginModel.data?.access ?? "");
            PreferenceService().saveString('refresh_token', state.loginModel.data?.refresh ?? "");
            PreferenceService().saveInt('expiry_time', state.loginModel.data?.expiryTime ?? 0);
            PreferenceService().saveString('role', state.loginModel.data?.role ?? "");
            AuthService.saveTokens(
                state.loginModel.data?.access ?? "",
                state.loginModel.data?.refresh ?? "",
                state.loginModel.data?.expiryTime ?? 0);
            if(state.loginModel.data?.role=='Patient'){
              context.push('/dashboard');
              CustomSnackBar.show(context, state.message ?? '');
            }

          } else {
            CustomSnackBar.show(context, state.message ?? '');
          }
        } else if (state is LoginError) {
          CustomSnackBar.show(context, state.message ?? '');
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Welcome Text
                  Text(
                    'Welcome!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter"),
                  ),

                  SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      "assets/login.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  // Phone Number Input Field
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25), // Shadow color
                          spreadRadius: 1, // Adjusts the size of the shadow
                          blurRadius: 2, // How blurry the shadow is
                          offset: Offset(0, 2), // Position of the shadow
                        ),
                      ],
                    ),
                    child: Material(
                      elevation: 0, // Set elevation to 0 when using BoxShadow
                      borderRadius: BorderRadius.circular(30.0),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            _validateEmail = '';
                          });
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline,
                              color: Color(0xff808080)),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          border:
                              InputBorder.none, // Removes the default border
                        ),
                      ),
                    ),
                  ),
                  if (_validateEmail.isNotEmpty) ...[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                      width: MediaQuery.of(context).size.width,
                      child: ShakeWidget(
                        key: Key("value"),
                        duration: Duration(milliseconds: 700),
                        child: Text(
                          _validateEmail,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    SizedBox(height: 15),
                  ],
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25), // Shadow color
                          spreadRadius: 1, // Adjusts the size of the shadow
                          blurRadius: 2, // How blurry the shadow is
                          offset: Offset(0, 2), // Position of the shadow
                        ),
                      ],
                    ),
                    child: Material(
                      elevation: 0, // Set elevation to 0 when using BoxShadow
                      borderRadius: BorderRadius.circular(30.0),
                      child: TextField(
                        onTap: () {
                          setState(() {
                            _validatepwd = '';
                          });
                        },
                        controller: _pwdController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline,
                              color: Color(0xff808080)),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          border:
                              InputBorder.none, // Removes the default border
                        ),
                      ),
                    ),
                  ),
                  if (_validatepwd.isNotEmpty) ...[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                      width: MediaQuery.of(context).size.width,
                      child: ShakeWidget(
                        key: Key("value"),
                        duration: Duration(milliseconds: 700),
                        child: Text(
                          _validatepwd,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    SizedBox(height: 15),
                  ],

                  SizedBox(height: 50),
                  // Get OTP Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: state is LoginLoading ? null : _validatefeilds,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: primaryColor,
                        disabledBackgroundColor:
                            primaryColor, // Same color when disabled
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Rounded corners
                        ),
                      ),
                      child: state is LoginLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1,
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 20),
                  // OR Text
                  Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sign in with Google Button
                  Container(
                    width: double.infinity, // Full width
                    height: 50.0, // Set height for the button
                    margin: EdgeInsets.symmetric(
                        horizontal: 10.0), // Margin for spacing
                    child: Material(
                      color: Colors.white, // Button background color
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: 2, // Shadow effect
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          // Implement Sign in with Google functionality
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/google.png', // Google icon asset
                              height: 24.0,
                            ),
                            SizedBox(
                                width: 12.0), // Spacing between icon and text
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity, // Full width
                    height: 50.0, // Set height for the button
                    margin: EdgeInsets.symmetric(horizontal: 10.0), // Margin for spacing
                    child: Material(
                      color: Colors.white, // Button background color
                      borderRadius: BorderRadius.circular(30.0),
                      elevation: 2, // Shadow effect
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          // Implement Sign in with Apple functionality
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/apple.png', // Apple icon asset
                              height: 24.0,
                            ),
                            SizedBox(
                                width: 12.0), // Spacing between icon and text
                            Text(
                              'Sign in with Apple',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Registration Link
                  InkWell(
                    onTap: () {
                      context.push('/registarion');
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't you have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                                color: primaryColor, // Register link color
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
