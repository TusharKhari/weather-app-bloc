import 'package:firebase_auth/firebase_auth.dart';


 // firebase auth
class AuthRepo {
  final auth = FirebaseAuth.instance;

// sign up
  Future<void> signUp({required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      
      throw e;
    }
  }

// signin
  Future<void> signIn({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      
     } catch (e) {
      
      throw e;
    }
  }

// logout
  Future<void> logOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      
      throw e;
    }
  }

// if user signed in get its info
  User? getCurrentUser() {
    User? currentUser = auth.currentUser;
    return currentUser;
  }
}
