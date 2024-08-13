class GlobalData {
  static final GlobalData _instance = GlobalData._internal();
  
  factory GlobalData() => _instance;
  
  GlobalData._internal();
  
  Map<String, String>? selectedImage;
}
