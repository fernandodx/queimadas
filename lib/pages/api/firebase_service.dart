import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:queimadas/response_api.dart';

class FirebaseService {

  final _googleSign = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Future<ResponseApi> loginWithEmailAndPassword(String email, String password) async {

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = await result.user;
      print("Login realizado com sucesso!!!");
      print("Nome: ${user.displayName}");
      print("E-mail: ${user.email}");
      print("Foto: ${user.photoUrl}");

      return ResponseApi<FirebaseUser>.ok(result: user);

    }catch(error){
      print("Login with Google error: $error");
      return ResponseApi.error(msg: error.toString());
    }
  }

  Future<ResponseApi> createUserWithEmailAndPassword(String email, String password, {String name, String urlPhoto}) async {

    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final FirebaseUser user = await result.user;

      if(name != null || urlPhoto != null){
        final updateUser = UserUpdateInfo();
        updateUser.photoUrl = urlPhoto ?? "https://image.flaticon.com/icons/svg/147/147144.svg";
        updateUser.displayName = name ?? "";
        user.updateProfile(updateUser);
      }

      return ResponseApi<FirebaseUser>.ok(result: user);

    }catch(error){
      if(error is PlatformException) {
        print("Erro ao criar o usuário: cod - ${error.code} mensagem - ${error.message}");
        return ResponseApi<FirebaseUser>.error(msg: error.toString());
      }
      print("Erro ao criar o usuário: ${error}");
      return ResponseApi<FirebaseUser>.error(msg: error.toString());
    }
  }

  Future<ResponseApi> loginWithGoogle() async {

    try{

      final GoogleSignInAccount account = await _googleSign.signIn();
      final GoogleSignInAuthentication authentication = await account.authentication;

      print("Google User: ${account.email}");

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);

      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser user = await result.user;
      print("Login realizado com sucesso!!!");
      print("Nome: ${user.displayName}");
      print("E-mail: ${user.email}");
      print("Foto: ${user.photoUrl}");

      return ResponseApi<FirebaseUser>.ok(result: user);

    }catch(error){
      print("Login with Google error: $error");
      return ResponseApi.error(msg: error.toString());
    }

  }

  logout() {
    _auth.signOut();
    _googleSign.signOut();
  }




}