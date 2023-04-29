import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<User?> signInWithGoogle() async {
  // Googleサインインのフローを開始
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

  // Googleサインインがキャンセルされた場合はnullを返す
  if (googleUser == null) {
    return null;
  }

  // Googleサインインに成功した場合は認証情報を取得
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // 認証情報からFirebase用のクレデンシャルを作成
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Firebaseにサインイン
  final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

  // サインインしたユーザーを返す
  return userCredential.user;
}

Future<void> signOutGoogle() async {
  // Googleサインアウトのフローを開始
  await _googleSignIn.signOut();

  // Firebaseからもサインアウト
  await _auth.signOut();
}
