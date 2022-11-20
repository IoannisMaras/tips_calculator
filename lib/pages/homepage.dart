import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Συνολοικό ποσό",
            style: TextStyle(color: Color(0xFF333366), fontSize: 32),
          ),
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF333366), fontSize: 25),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF333366).withOpacity(0.7), width: 5.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF333366), width: 2.0),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(15),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(child: Container()),
          ],
        )
      ],
    );
  }
}
