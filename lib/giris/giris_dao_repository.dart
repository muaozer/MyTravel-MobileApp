import 'package:firebase_auth/firebase_auth.dart';

class GirisDaoRepository {
  Future<bool> girisYap(String kullaniciAdi, String sifre) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: kullaniciAdi,
        password: sifre,
      );
      return userCredential.user != null;
    } on FirebaseAuthException catch (e) {
      print('Giriş hatası: $e');
      return false;
    }
  }
}
