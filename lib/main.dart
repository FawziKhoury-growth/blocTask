import 'package:bloc/bloc.dart';
import 'package:bloctask/business_logic/guest_room_bloc/guest_room_bloc.dart';

import 'package:bloctask/business_logic/property_bloc/property_bloc.dart';
import 'package:bloctask/business_logic/signin_bloc/signin_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/authentication_bloc/authentication_bloc.dart';

import 'business_logic/registration_bloc/registration_bloc.dart';
import 'navigation/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RegistrationBloc>(
        create: (context) => RegistrationBloc(),
      ),
      BlocProvider<SigninBloc>(
        create: (context) => SigninBloc(),
      ),
      BlocProvider<PropertyBloc>(
        create: (context) => PropertyBloc(),
      ),
      BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(),
      ),
      BlocProvider<GuestRoomBloc>(
        create: (context) => GuestRoomBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/loadingScreen',
      navigatorKey: RouteGenerator.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: BlocProvider(
      //   create: (context) => CounterBloc(),
      //   child: const HomePage(),
      // ),
    );
  }
}





// Future<void> main() async {
//   Bloc.observer = SimpleBlocObserver();
//   CounterCubit()
//     ..increment()
//     ..close();  
 
//   print("closed");
// }

// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);

//   void increment() => emit(state + 1);

//   @override
//   void onChange(Change<int> change) {
//     // TODO: implement onChange
//     super.onChange(change);
//     print(change);
//   }
// }


// class SimpleBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     print('${bloc.runtimeType} $change');
//   }
// }