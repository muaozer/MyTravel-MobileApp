import 'package:flutter/material.dart';
import 'package:gezi_rehberi/giris/giris_dao_repository.dart';

class GirisViewModel {
  final TextEditingController kullaniciAdiController = TextEditingController();
  final TextEditingController sifreController = TextEditingController();
  final _repository = GirisDaoRepository();

  Future<bool> girisYap(String kullaniciAdi, String sifre) async {
    final success = await _repository.girisYap(kullaniciAdi, sifre);
    return success;
  }

  void dispose() {
    kullaniciAdiController.dispose();
    sifreController.dispose();
  }
}
