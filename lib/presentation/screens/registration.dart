import 'package:bloctask/data/models/user_model.dart';
import 'package:bloctask/navigation/route_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/authentication_bloc/authentication_bloc.dart';
import '../../business_logic/registration_bloc/registration_bloc.dart';
import '../../data/enums/registration_enum.dart';
import '../shared_widgets/custom_button_widget.dart';
import '../shared_widgets/custom_error_widget.dart';
import '../shared_widgets/custom_loading_widget.dart';
import '../shared_widgets/custom_text_field.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.registrationStatus == RegistrationStatus.success) {
          BlocProvider.of<AuthenticationBloc>(context).add(OnUpdateCurrentUser(
              UserModel(
                  idUser: state.id,
                  firstName: state.firstName,
                  lastName: state.lastName,
                  email: state.email)));
          BlocProvider.of<RegistrationBloc>(context).add(OnClearEvent());
          RouteNavigator.goToFirst();
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Color(0xFFF9F9F9)),
          height: MediaQuery.of(context).size.height,
          child: BlocBuilder<RegistrationBloc, RegistrationState>(
            buildWhen: (previous, current) {
              print("rebuilding the bloc");
              return (previous != current);
            },
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                            child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontFamily: "MontserratMedium",
                              fontSize: 16,
                              color: Color(0xFF323E48)),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CustomTextField(
                                hintText: "First Name",
                                onChanged: (value) =>
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(OnFirstNameChange(value)),
                              ),
                              SizedBox(height: 16.0),
                              CustomTextField(
                                onChanged: (value) =>
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(OnLastNameChange(value)),
                                hintText: 'Last Name',
                              ),
                              SizedBox(height: 16.0),
                              CustomTextField(
                                onChanged: (value) =>
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(OnEmailChange(value)),
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 16.0),
                              CustomTextField(
                                onChanged: (value) =>
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(OnPasswordChange(value)),
                                hintText: 'Password',
                                obscureText: true,
                              ),
                              SizedBox(height: 32.0),
                              CustomButtonWidget(
                                  title: "NEXT",
                                  color: Colors.blue,
                                  TextColor: Colors.white,
                                  radius: 10,
                                  onPressed: () {
                                    BlocProvider.of<RegistrationBloc>(context)
                                        .add(OnButtonClicked());
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  state.registrationStatus == RegistrationStatus.loading
                      ? CustomLoadingWidget()
                      : SizedBox.shrink(),
                  state.registrationStatus == RegistrationStatus.error
                      ? CustomErrorWidget(errorMessage: state.error)
                      : SizedBox.shrink()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
