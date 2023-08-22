import 'package:bloctask/navigation/route_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/authentication_bloc/authentication_bloc.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Use a delay to ensure that the context is available

    initDatabase();
  }

  void initDatabase() async {
    Future.delayed(Duration(seconds: 2), () async {
      BlocProvider.of<AuthenticationBloc>(context).add(OnSetCurrentUser());
      RouteNavigator.goToAndRemove("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/logoImage.png')),
    );
  }
}
