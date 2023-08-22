import 'package:bloctask/data/enums/signin_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/authentication_bloc/authentication_bloc.dart';
import '../../business_logic/signin_bloc/signin_bloc.dart';
import '../../navigation/route_navigator.dart';
import '../shared_widgets/custom_button_widget.dart';
import '../shared_widgets/custom_error_widget.dart';
import '../shared_widgets/custom_loading_widget.dart';
import '../shared_widgets/custom_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
      height: MediaQuery.of(context).size.height,
      child: BlocListener<SigninBloc, SigninState>(
        listener: (context, state) {
          if (state.signinStatus == SigninStatus.success) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(OnSetCurrentUser());
            Future.delayed(Duration(microseconds: 200), () {
              RouteNavigator.goToFirst();
            });
          }
        },
        child: BlocBuilder<SigninBloc, SigninState>(
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => {Navigator.pop(context)},
                            child: Image.asset(
                              'assets/icon/xIcon.png',
                              width: 15.5,
                            ),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        'assets/images/logoImage.png',
                        width: 122,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: Column(
                        children: [
                          Text(
                            'You need to login to complete the booking process',
                            style: TextStyle(
                                fontFamily: "MontserratRegular",
                                fontSize: 12,
                                color: Color(0xFF323E48)),
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              onChanged: (value) =>
                                  BlocProvider.of<SigninBloc>(context)
                                      .add(OnEmailChange(email: value)),
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 16.0),
                            CustomTextField(
                              onChanged: (value) =>
                                  BlocProvider.of<SigninBloc>(context)
                                      .add(OnPasswordChange(password: value)),
                              hintText: 'Password',
                              obscureText: true,
                            ),
                            SizedBox(height: 32.0),
                            CustomButtonWidget(
                              title: "Log In",
                              color: Colors.blue,
                              TextColor: Colors.white,
                              radius: 10,
                              onPressed: () {
                                BlocProvider.of<SigninBloc>(context)
                                    .add(OnSignIn());
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don\'t have an account?",
                            style: TextStyle(
                                fontFamily: "MontserratSemiBold", fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              RouteNavigator.goTo("signup");
                            },
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "MontserratSemiBold",
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                state.signinStatus == SigninStatus.loading
                    ? CustomLoadingWidget()
                    : SizedBox.shrink(),
                state.signinStatus == SigninStatus.error
                    ? CustomErrorWidget(errorMessage: state.error)
                    : SizedBox.shrink()
              ],
            );
          },
        ),
      ),
    ));
  }
}
