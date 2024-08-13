import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class KayitDaoRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> kayitOl({
    required String kullaniciAdi,
    required String email,
    required String sifre,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: sifre,
      );
      
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'kullaniciAdi': kullaniciAdi,
        'email': email,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Hata yönetimi
      throw Exception('Kayıt işlemi sırasında hata: $e');
    }
  }
}
