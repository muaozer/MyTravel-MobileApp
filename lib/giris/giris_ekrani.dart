import 'package:flutter/material.dart';
import 'package:gezi_rehberi/sayfalar/bottom_navigation.dart';
import 'package:gezi_rehberi/giris/giris_view_model.dart';
import 'package:gezi_rehberi/giris/validators.dart';
import 'package:gezi_rehberi/kayit/register_screen.dart';
import 'package:gezi_rehberi/kayit/widgets/custom_input_field.dart';
import 'package:gezi_rehberi/renkler.dart';

class GirisEkrani extends StatefulWidget {
  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  final _formKey = GlobalKey<FormState>();
  final _girisViewModel = GirisViewModel();

  @override
  void dispose() {
    _girisViewModel.dispose();
    super.dispose();
  }

  void _girisYap() async {
    if (_formKey.currentState!.validate()) {
      final success = await _girisViewModel.girisYap(
        _girisViewModel.kullaniciAdiController.text,
        _girisViewModel.sifreController.text,
      );
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: const Text("Giris Basarili")),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: const Text("Giris Basarisiz")),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yazirenk1,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  "MyTravel",
                  style: TextStyle(
                      fontFamily: 'ReemKufiun',
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Hesabınıza giriş yapın",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 35),
                CustomInputField(
                  labelText: 'Kullanici Adi',
                  controller: _girisViewModel.kullaniciAdiController,
                  validator: Validators.validateUsername,
                ),
                const SizedBox(height: 10),
                CustomInputField(
                  labelText: 'Sifre',
                  controller: _girisViewModel.sifreController,
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _girisYap,
                  child: const Text('Giris Yap'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hesabim yok mu?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KayitOlmaEkrani(),
                          ),
                        );
                      },
                      child: const Text('Kayit Ol'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
