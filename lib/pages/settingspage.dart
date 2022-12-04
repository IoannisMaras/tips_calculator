import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(179, 136, 255, 1),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Ρυθμίσεις",
              style: TextStyle(color: Colors.white, fontSize: 35),
              textAlign: TextAlign.center,
            ),
            const Text(
              "(coming soon)",
              style: TextStyle(color: Colors.white, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.color_lens),
                label: const Text("Επιλογή θέματος"),
                backgroundColor: const Color(0xFF333366),
                foregroundColor: Colors.white,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.language),
                label: const Text("Επιλογή γλώσσας"),
                backgroundColor: const Color(0xFF333366),
                foregroundColor: Colors.white,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.contact_support),
                label: const Text("Επικοινωνία"),
                backgroundColor: const Color(0xFF333366),
                foregroundColor: Colors.white,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.info),
                label: const Text("Πληροφορίες"),
                backgroundColor: const Color(0xFF333366),
                foregroundColor: Colors.white,
                onPressed: () {},
              ),
            ),
            Container(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
