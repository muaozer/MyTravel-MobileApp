import 'package:flutter/material.dart';
import 'package:gezi_rehberi/kayit/kayit_dao_repository.dart';
import 'package:gezi_rehberi/sayfalar/bottom_navigation.dart';
import 'package:gezi_rehberi/giris/giris_ekrani.dart';

class KayitViewModel {
  final kullaniciAdiController = TextEditingController();
  final emailController = TextEditingController();
  final sifreController = TextEditingController();
  final sifreTekrarController = TextEditingController();

  final KayitDaoRepository _repository = KayitDaoRepository();

  void dispose() {
    kullaniciAdiController.dispose();
    emailController.dispose();
    sifreController.dispose();
    sifreTekrarController.dispose();
  }

  Future<void> kayitOl(BuildContext context) async {
    if (_validateForm(context)) {
      try {
        await _repository.kayitOl(
          kullaniciAdi: kullaniciAdiController.text,
          email: emailController.text,
          sifre: sifreController.text,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigation(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt işlemi sırasında hata: $e')),
        );
      }
    }
  }

  bool _validateForm(BuildContext context) {
    final formState = Form.of(context);
    if (formState == null || formState.validate()) {
      return false;
    }

    if (sifreController.text != sifreTekrarController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Şifreler aynı değil')),
      );
      return false;
    }

    return true;
  }

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GirisEkrani()),
    );
  }
}
