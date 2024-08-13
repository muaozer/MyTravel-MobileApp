import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gezi_rehberi/global_data.dart';
import 'package:gezi_rehberi/renkler.dart';

class Kesfet extends StatefulWidget {
  const Kesfet({super.key});

  @override
  State<Kesfet> createState() => _KesfetState();
}

class _KesfetState extends State<Kesfet> {
  int aktifSayfa = 0;
  final PageController sayfaKontrolcusu = PageController();
  List<Map<String, String>> cazibeMerkezleri = [
    {"isim": "Ayasofya Cami", "resim": "resimler/ayasofya_cami.jpg"},
    {"isim": "Kız Kulesi", "resim": "resimler/kiz_kulesi.jpg"},
    {"isim": "Topkapı Sarayı", "resim": "resimler/topkapi_sarayi.jpg"},
    {"isim": "Sultanahmet Cami", "resim": "resimler/sultan_ahmet_cami.jpg"},
    {"isim": "Yerebatan Sarnıcı", "resim": "resimler/yerebatan_sarnici.png"},
    {"isim": "Dolmabahçe Sarayı", "resim": "resimler/dolmabahce_sarayi.jpg"},
    {"isim": "Çamlıca Tepesi", "resim": "resimler/camlica_tepesi.jpg"},
    {"isim": "Galata Kulesi", "resim": "resimler/galata_kulesi.jpg"},
  ];

  void _sayfaDegisti(int indeks) {
    setState(() {
      aktifSayfa = indeks;
    });
  }

  void _begenGorsel() async {
    final Map<String, String> seciliGorsel = cazibeMerkezleri[aktifSayfa];

    await FirebaseFirestore.instance.collection('liked_images').add({
      'isim': seciliGorsel['isim'],
      'resim': seciliGorsel['resim'],
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Görseli global veri sınıfına yönlendirme
    GlobalData().selectedImage = seciliGorsel;

    // Görseli beğenildi olarak işaretleyip güncelleme
    setState(() {
      cazibeMerkezleri.removeAt(aktifSayfa);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: sayfaKontrolcusu,
            itemCount: cazibeMerkezleri.length,
            onPageChanged: _sayfaDegisti,
            itemBuilder: (context, indeks) {
              return GestureDetector(
                onPanUpdate: (details) {},
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        cazibeMerkezleri[indeks]["resim"]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.green, width: 2),
                              color: anaRenk,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.thumb_up,
                                  color: Colors.white),
                              onPressed: _begenGorsel,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.red, width: 2),
                              color: anaRenk,
                            ),
                            child: IconButton(
                              icon:
                                  const Icon(Icons.close, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  cazibeMerkezleri.removeAt(indeks);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 80,
                      right: 80,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: anaRenk,
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            cazibeMerkezleri[aktifSayfa]['isim']!,
                            style: const TextStyle(
                              fontFamily: 'ReemKufiun',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 45,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          cazibeMerkezleri.length,
                          (noktaIndeksi) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: aktifSayfa == noktaIndeksi
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
