import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:tips_calculator/models/tipshistorymodel.dart';
import 'package:tips_calculator/providers/calculateactiveprovider.dart';
import 'package:tips_calculator/providers/savecheckprovider.dart';
import 'package:tips_calculator/providers/tipshistoryprovider.dart';
import 'package:tips_calculator/utilities/coachtutorial.dart';
import 'package:tips_calculator/widgets/listofpayments.dart';
import 'package:tips_calculator/widgets/listofstaff.dart';

import '../providers/badgeprovider.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  static TextEditingController totalTips = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool check = ref.watch(checkProvider);
    bool buttonActive = ref.watch(calculateActiveProvider);
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
                  key: CoachTutorial.tipsTextField,
                  controller: totalTips,
                  onChanged: ((value) {
                    if (!(totalTips.text == "") &&
                        double.parse(totalTips.text) > 0) {
                      ref
                          .read(calculateActiveProvider.notifier)
                          .changeCalculateActiveTo(true);
                    } else {
                      ref
                          .read(calculateActiveProvider.notifier)
                          .changeCalculateActiveTo(false);
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
                      ref.read(checkProvider.notifier).changeCheck();
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
                  key: CoachTutorial.calculateButton,
                  icon: Icon(check ? Icons.check : Icons.save),
                  label: Text(check ? "Υπολογισμός" : "Αποθήκευση"),
                  backgroundColor: buttonActive
                      ? const Color(0xFF333366)
                      : Colors.grey.shade800,
                  foregroundColor: buttonActive ? Colors.white : Colors.grey,
                  onPressed: buttonActive
                      ? () {
                          if (check) {
                            ref.read(checkProvider.notifier).changeCheck();
                          } else {
                            ref
                                .read(tipsHistoryArrayNotifierProvider.notifier)
                                .addTipsHistory(TipsHistoryModel(
                                    value: totalTips.text.isEmpty
                                        ? 0
                                        : double.parse(totalTips.text),
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
                      child: ListOfPayments(totalTips.text.isEmpty
                          ? 0
                          : double.parse(totalTips.text)),
                    )),
        )
      ],
    );
  }
}
