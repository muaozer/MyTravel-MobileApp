String validatePassword(String password) {
  String errorMsg = '';

  if (password.length < 8) {
    errorMsg = 'Şifre en az 8 karakter olmalı';
  }
  if (!RegExp(r'(?=.*?[A-Z])').hasMatch(password)) {
    errorMsg += (errorMsg.isEmpty ? '' : '\n') + 'Bir büyük harf içermelidir';
  }
  if (!RegExp(r'(?=.*?[a-z])').hasMatch(password)) {
    errorMsg += (errorMsg.isEmpty ? '' : '\n') + 'Bir küçük harf içermelidir';
  }
  if (!RegExp(r'(?=.*?[0-9])').hasMatch(password)) {
    errorMsg += (errorMsg.isEmpty ? '' : '\n') + 'Bir rakam içermelidir';
  }

  return errorMsg;
}
