import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gezi_rehberi/renkler.dart';
import 'rehber_detay_sayfa.dart';

class Rehber extends StatefulWidget {
  const Rehber({super.key});

  @override
  State<Rehber> createState() => _RehberState();
}

class _RehberState extends State<Rehber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yazirenk1,
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('liked_images').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
              'Beğenilen görsel yok',
              style: TextStyle(fontSize: 30, color: Colors.black54),
            ));
          }

          final documents = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              final isim = doc['isim'];
              final resim = doc['resim'];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RehberDetaySayfasi(
                        Ayasofya: isim,
                        resim: resim,
                        aciklama:
                            "Ayasofya, 537 yılında Bizans İmparatoru I. Justinianus tarafından inşa edilen, İstanbul'da bulunan ve zamanla kilise, cami ve müze olarak kullanılmış, tarihin en önemli mimari eserlerinden biridir.",
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: anaRenk,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20.0),
                          ),
                          child: Image.asset(
                            resim,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isim,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'ReemKufiun',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
