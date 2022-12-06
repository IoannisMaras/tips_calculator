import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/utilities/coachtutorial.dart';

import '../models/staffmodel.dart';
import '../providers/staffarrayprovider.dart';

class TutorialStaffAlert extends StatefulWidget {
  TutorialStaffAlert({Key? key}) : super(key: key);

  @override
  State<TutorialStaffAlert> createState() => TutorialStaffAlertState();
}

class TutorialStaffAlertState extends State<TutorialStaffAlert> {
  int _index = 0;

  static PageController pageController = PageController(viewportFraction: 0.7);

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _weightController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    //pageController.dispose(); Can not dispose static controller
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
                          key: CoachTutorial.iconPicker,
                          itemCount: 7,
                          controller: pageController,
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
                      child: Container(
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF333366),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            key: CoachTutorial.staffNameTextField,
                            child: AnimatedTextKit(
                                isRepeatingAnimation: true,
                                animatedTexts: [
                                  TyperAnimatedText('Σερβιτόρος Α',
                                      speed: const Duration(milliseconds: 140)),
                                  TyperAnimatedText('Μπαρμαν',
                                      speed: const Duration(milliseconds: 140)),
                                  TyperAnimatedText('Μάγειρας',
                                      speed: const Duration(milliseconds: 140)),
                                  TyperAnimatedText('Υποδοχή',
                                      speed: const Duration(milliseconds: 140)),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        key: CoachTutorial.staffWeightTextField,
                        width: double.infinity,
                        height: 65,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF333366),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: AnimatedTextKit(
                                isRepeatingAnimation: true,
                                animatedTexts: [
                                  TyperAnimatedText('2.00',
                                      speed: const Duration(milliseconds: 140)),
                                  TyperAnimatedText('1.50',
                                      speed: const Duration(milliseconds: 140)),
                                  TyperAnimatedText('0.75',
                                      speed: const Duration(milliseconds: 140)),
                                  TyperAnimatedText('1.00',
                                      speed: const Duration(milliseconds: 140)),
                                ]),
                          ),
                        ),
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
                            key: CoachTutorial.staffCreateButton,
                            icon: const Icon(Icons.add_circle),
                            label: const Text("Δημιουργία"),
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            onPressed: () async {},
                          ),
                          FloatingActionButton.extended(
                            icon: const Icon(Icons.cancel),
                            label: const Text("Ακυρωση"),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            onPressed: () {
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

  static void animateToIcon() {
    pageController.animateTo(500,
        duration: Duration(seconds: 1), curve: Curves.linear);
  }
}
