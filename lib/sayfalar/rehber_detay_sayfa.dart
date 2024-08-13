import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gezi_rehberi/renkler.dart';

class RehberDetaySayfasi extends StatelessWidget {
  final String Ayasofya;
  final String resim;
  final String aciklama;

  RehberDetaySayfasi({
    required this.Ayasofya,
    required this.resim,
    required this.aciklama,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: yazirenk6),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'resimler/my_travel.png',
                height: 40,
              ),
            ),
            Text(
              Ayasofya,
              style: TextStyle(
                fontFamily: 'ReemKufiun',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: yazirenk6,
              ),
            ),
          ],
        ),
        backgroundColor: yazirenk2,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              resim,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                aciklama,
                style: TextStyle(
                  fontFamily: 'ReemKufiun',
                  fontSize: 16,
                  color: yazirenk5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: yazirenk1,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.volume_up, color: yazirenk5, size: 30),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            ),
            Container(
              height: 300,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: yazirenk1),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(41.0075058, 28.9780077),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(41.0075058, 28.9780077),
                    infoWindow: InfoWindow(
                      title: Ayasofya,
                    ),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
