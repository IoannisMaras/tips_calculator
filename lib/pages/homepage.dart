import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/models/staffmodel.dart';
import 'package:tips_calculator/models/tipshistorydetailsmodel.dart';
import 'package:tips_calculator/models/tipshistorymodel.dart';
import 'package:tips_calculator/providers/tipshistoryprovider.dart';
import 'package:tips_calculator/widgets/listofpayments.dart';
import 'package:tips_calculator/widgets/listofstaff.dart';

import '../providers/badgeprovider.dart';
import '../providers/historydetailsprovider.dart';
import '../providers/staffarrayprovider.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

bool check = true;
final TextEditingController _totalTips = TextEditingController();
bool buttonActive = false;

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            "Συνολικό ποσό",
            style: TextStyle(color: Color(0xFF333366), fontSize: 32),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                child: TextField(
                  controller: _totalTips,
                  onChanged: ((value) {
                    if (!(_totalTips.text == "") &&
                        double.parse(_totalTips.text) > 0) {
                      setState(() {
                        buttonActive = true;
                      });
                    } else {
                      buttonActive = false;
                    }
                  }),
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(color: Color(0xFF333366), fontSize: 25),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0xFF333366).withOpacity(0.7),
                          width: 5.0),
                    ),
                    hintText: "0",
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Expanded(
                flex: 3,
                child: FloatingActionButton.extended(
                  icon: Icon(check ? Icons.restart_alt : Icons.undo),
                  label: Text(check ? "Καθαρισμός" : "Επιστροφή"),
                  backgroundColor: const Color(0xFF333366),
                  foregroundColor: Colors.white,
                  onPressed: () {
                    if (!check) {
                      setState(() {
                        check = !check;
                      });
                    } else {
                      ref.read(badgeValueProvider.notifier).clearAllBadges();
                    }
                  },
                ),
              ),
              Expanded(child: Container()),
              Expanded(
                flex: 3,
                //flex: 16,
                child: FloatingActionButton.extended(
                  icon: Icon(check ? Icons.check : Icons.save),
                  label: Text(check ? "Υπολογισμός" : "Αποθήκευση"),
                  backgroundColor: buttonActive
                      ? const Color(0xFF333366)
                      : Colors.grey.shade800,
                  foregroundColor: buttonActive ? Colors.white : Colors.grey,
                  onPressed: buttonActive
                      ? () {
                          if (check) {
                            setState(() {
                              check = !check;
                            });
                          } else {
                            ref
                                .read(tipsHistoryArrayNotifierProvider.notifier)
                                .addTipsHistory(TipsHistoryModel(
                                    value: _totalTips.text.isEmpty
                                        ? 0
                                        : double.parse(_totalTips.text),
                                    date: DateTime.now()));
                          }
                        }
                      : null,
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: check
                  ? const ListOfStaff()
                  : Container(
                      color: const Color(0xFF333366),
                      child: ListOfPayments(_totalTips.text.isEmpty
                          ? 0
                          : double.parse(_totalTips.text)),
                    )),
        )
      ],
    );
  }
}
