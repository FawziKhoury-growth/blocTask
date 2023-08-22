import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirebaseHelper {
  Future<String> signUpWithEmailPassword(
      String firstName, String lastName, String email, String password) async {
    print("sign up entered");
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addUserToFirestore(
          userCredential.user!.uid, firstName, lastName, email);
      // You can handle the successful registration here.

      print("User signed up: ${userCredential.user!.email}");
      return userCredential.user!.uid;
    } catch (e) {
      // Handle any errors that occur during sign-up.
      print("Error: $e");
      throw (e);
    }
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // You can handle the successful sign-in here.
      print("User signed in: ${userCredential.user!.email}");
    } catch (e) {
      // Handle any errors that occur during sign-in.
      print("Error: $e");
      throw (e);
    }
  }

  Future<void> addUserToFirestore(
      String idUser, String firstName, String lastName, String email) async {
    try {
      // Get a reference to the Firestore collection
      print(idUser);
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      UserModel user = UserModel(
          idUser: idUser,
          firstName: firstName,
          lastName: lastName,
          email: email);
      // Add the data to Firestore as a new document
      await usersCollection.doc(idUser).set(user.toJson());
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  Future<UserModel?> checkUser() async {
    try {
      // Check if a user is signed in
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get a reference to the Firestore collection
        CollectionReference usersCollection =
            FirebaseFirestore.instance.collection('users');

        // Get the document for the signed-in user
        DocumentSnapshot userSnapshot =
            await usersCollection.doc(user.uid).get();

        if (userSnapshot.exists) {
          // Convert the Firestore data to a UserModel object
          // UserModel userModel = UserModel(
          //   idUser: userSnapshot['idUser'],
          //   firstName: userSnapshot['firstName'],
          //   lastName: userSnapshot['lastName'],
          //   email: userSnapshot['email'],
          // );
          UserModel userModel =
              UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);

          return userModel;
        }
      }
    } catch (e) {
      print('Error checking user and retrieving data: $e');
    }

    // Return null if the user is not signed in or data retrieval fails
    return null;
  }

  Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User logged out');
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
