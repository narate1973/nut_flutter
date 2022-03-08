import 'package:firebase_auth/firebase_auth.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/requests/login_request.dart';

abstract class FirebaseService {
  Future<void> login({required LoginRequest request});
  Future<void> signOut();
  Future<String?> getTokenID();
  bool isSiginIn();
}

class FirebaseServiceImpl implements FirebaseService {
  final _authInstance = FirebaseAuth.instance;
  @override
  Future<void> login({required LoginRequest request}) async {
    await _authInstance.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  @override
  Future<void> signOut() {
    return _authInstance.signOut();
  }

  @override
  Future<String?> getTokenID() async {
    return _authInstance.currentUser?.getIdToken();
  }

  @override
  bool isSiginIn() {
    return _authInstance.currentUser != null;
  }
}
