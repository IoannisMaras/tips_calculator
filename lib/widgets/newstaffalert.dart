import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/staffmodel.dart';
import '../providers/anyalertopenprovider.dart';
import '../providers/staffarrayprovider.dart';

class NewStaffAlert extends StatefulWidget {
  NewStaffAlert({Key? key}) : super(key: key);

  @override
  State<NewStaffAlert> createState() => _NewStaffAlertState();
}

class _NewStaffAlertState extends State<NewStaffAlert> {
  int _index = 0;

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        //contentPadding: EdgeInsets.zero,
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF333366), width: 10),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Flexible(flex: 1, child: Container()),
                    const Text(
                      "Εικόνα:",
                      style: TextStyle(color: Color(0xFF333366), fontSize: 32),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                          itemCount: 7,
                          controller: PageController(viewportFraction: 0.7),
                          onPageChanged: (int index) =>
                              setState(() => _index = index),
                          itemBuilder: (_, i) {
                            return Transform.scale(
                                scale: i == _index ? 1 : 0.9,
                                child: Card(
                                  color: const Color.fromRGBO(179, 136, 255, 1),
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/staff_icon0${i + 1}.png",
                                      // height: 92.0,
                                      // width: 92.0,
                                    ),
                                  ),
                                ));
                          }),
                    ),
                    Container(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Όνομα",
                            hintText: "πχ Σερβιτόρος"),
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _weightController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Μονάδες",
                            hintText: "πχ 1.5"),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            try {
                              final text = newValue.text;
                              if (text.isNotEmpty) double.parse(text);
                              return newValue;
                            } catch (e) {}
                            return oldValue;
                          }),
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton.extended(
                            icon: const Icon(Icons.add_circle),
                            label: const Text("Δημιουργία"),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            onPressed: () async {
                              await ref
                                  .read(staffArrayNotifierProvider.notifier)
                                  .addStaff(StaffModel(
                                      name: _nameController.text,
                                      weight:
                                          double.parse(_weightController.text),
                                      iconId: _index + 1));
                                       ref
                                        .read(anyAlertOpenProvider.notifier)
                                        .state = false;
                              Navigator.pop(context);
                             
                            },
                          ),
                          FloatingActionButton.extended(
                            icon: const Icon(Icons.cancel),
                            label: const Text("Ακυρωση"),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              ref
                                        .read(anyAlertOpenProvider.notifier)
                                        .state = false;
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
