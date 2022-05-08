//Packages

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

//Services
import '../services/database_service.dart';
import '../services/navigation_service.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

//Models
import '../model/chat_user.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseService _databaseService;
  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseService>();
    //_auth.signOut();
    _auth.authStateChanges().listen(
      (_user) {
        if (_user != null) {
          if (kDebugMode) {
            //print("Logged in");
          }
          _databaseService.updateUserLastSeenTime(_user.uid);
          _databaseService.getUser(_user.uid).then(
            (_snapshot) {
              Map<String, dynamic> _userData =
                  _snapshot.data()! as Map<String, dynamic>;
              user = ChatUser.fromJSON(
                {
                  "uid": _user.uid,
                  "email": _userData["email"],
                  "image": _userData["image"],
                  "last_active": _userData["last_active"],
                  "name": _userData["name"],
                },
              );
              //print('/home');
            },
          );
          _navigationService.removeAndNavigateToRoute('/home');
        } else {
          _navigationService.removeAndNavigateToRoute('/login');
        }
      },
    );
  }

  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      if (kDebugMode) {
        print(_auth.currentUser);
      }
    } on FirebaseAuthException {
      if (kDebugMode) {
        print("Error Logging in Firebase detected ERROR");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      return _credentials.user!.uid;
    } on FirebaseAuthException {
      if (kDebugMode) {
        print(
            "Error registering user. FireeeeeeeBAAAAAAAAAAAAAAAAAAAAAAAAAAAASEEE hereeeeee");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      final AccessToken accessToken = loginResult.accessToken!;
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      try {
        return await FirebaseAuth.instance.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        // manage Firebase authentication exceptions

        print(e);
        print("Firebase Error");
        rethrow;
      } catch (e) {
        // manage other exceptions
        print(e);
        rethrow;
      }
    }
  }
}
