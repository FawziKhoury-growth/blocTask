import 'package:bloctask/data/enums/authentication_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/authentication_bloc/authentication_bloc.dart';
import '../../navigation/route_navigator.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.authenticationStatus ==
              AuthenticationStatus.unauthenticated) {
            // BlocProvider.of<AuthenticationBloc>(context)
            //     .add(OnUpdateCurrentUser());
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF3C4955),
                  ),
                  child: Image.asset("assets/images/logoLetterImage.png"),
                ),
                state.authenticationStatus == AuthenticationStatus.authenticated
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.person,
                                  size: 60, color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${state.currentUser.firstName} ${state.currentUser.lastName}',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            ListTile(
                              title: const Text('Sign Out'),
                              onTap: () async {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(OnSignOut());
                              },
                            ),
                          ],
                        ),
                      )
                    : ListTile(
                        title: const Text('Sign in'),
                        onTap: () {
                          Navigator.pop(context);
                          RouteNavigator.goTo("signin");
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
