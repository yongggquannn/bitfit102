import 'package:bitfit102/screens/services/database.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:bitfit102/models/myuser.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
      .map((User? user) => _userFromFirebaseUser(user));
  }

  // Get the currently logged-in user ID
  Future<String?> getCurrentUserId() async {
    final User? user = _auth.currentUser;
    return user?.uid;
  }
  
  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData("New Member", "Beginner", "2.4km", 0 , 0 , 0);
      return _userFromFirebaseUser(user);
    } catch(e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // Handle the scenario where the email already exists
          throw Exception('The email address is already in use. Please use a different email.');
        }
      }
      print(e.toString());
      return null;
    }
  }
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}