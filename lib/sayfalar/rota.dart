import 'package:flutter/material.dart';

class Haritam extends StatefulWidget {
  const Haritam({super.key});

  @override
  State<Haritam> createState() => _HaritamState();
}

class _HaritamState extends State<Haritam> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Rota",
        style: TextStyle(fontSize: 30, color: Colors.black54),
      ),
    );
  }
}