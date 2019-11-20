import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:queimadas/response_api.dart';

class FirebaseService {

  final _googleSign = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

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

      return ResponseApi.ok();

    }catch(error){
      print("Login with Google error: $error");
      return ResponseApi.error(msg: error.toString());
    }

  }




}