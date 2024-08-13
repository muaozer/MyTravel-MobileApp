import 'package:flutter/material.dart';
import 'package:gezi_rehberi/kayit/kayit_view_model.dart';
import 'package:gezi_rehberi/kayit/dogrulayicilar.dart';
import 'package:gezi_rehberi/kayit/widgets/custom_input_field.dart';
import 'package:gezi_rehberi/renkler.dart';

class KayitOlmaEkrani extends StatefulWidget {
  @override
  _KayitOlmaEkraniState createState() => _KayitOlmaEkraniState();
}

class _KayitOlmaEkraniState extends State<KayitOlmaEkrani> {
  final _formKey = GlobalKey<FormState>();
  final _viewModel = KayitViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yazirenk1,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "MyTravel",
                style: TextStyle(
                    fontFamily: 'ReemKufiun',
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Hesap Oluştur",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 35),
              CustomInputField(
                labelText: "Kullanıcı Adı",
                controller: _viewModel.kullaniciAdiController,
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen kullanıcı adınızı giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomInputField(
                labelText: "E-posta",
                controller: _viewModel.emailController,
                prefixIcon: Icons.email_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen e-posta adresinizi giriniz';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Geçerli bir e-posta adresi giriniz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomInputField(
                labelText: "Şifre",
                controller: _viewModel.sifreController,
                obscureText: true,
                prefixIcon: Icons.password_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifrenizi giriniz';
                  } else {
                    String validationMessage = validatePassword(value);
                    if (validationMessage.isNotEmpty) {
                      return validationMessage;
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomInputField(
                labelText: "Şifrenizi tekrar giriniz",
                controller: _viewModel.sifreTekrarController,
                obscureText: true,
                prefixIcon: Icons.password_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifrenizi tekrar giriniz';
                  } else if (value != _viewModel.sifreController.text) {
                    return 'Şifreler birbiriyle uyuşmuyor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _viewModel.kayitOl(context);
                    _formKey.currentState?.reset();
                  }
                },
                child: const Text('Kayıt Ol'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Zaten hesabım var mı?"),
                  TextButton(
                    onPressed: () => _viewModel.navigateToLogin(context),
                    child: const Text('Giriş Yap'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
