import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/models/staffmodel.dart';
import 'package:tips_calculator/pages/homepage.dart';
import 'package:tips_calculator/providers/pageindexprovider.dart';
import 'package:tips_calculator/providers/savecheckprovider.dart';
import 'package:tips_calculator/providers/staffarrayprovider.dart';
import 'package:tips_calculator/widgets/listofstaff.dart';
import 'package:tips_calculator/widgets/tutorialstaffalert.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../pages/staffsettingspage.dart';
import '../providers/calculateactiveprovider.dart';

class CoachTutorial {
  static GlobalKey<CurvedNavigationBarState> addStaffButton = GlobalKey();

  static GlobalKey iconPicker = GlobalKey();
  static GlobalKey staffNameTextField = GlobalKey();
  static GlobalKey staffWeightTextField = GlobalKey();
  static GlobalKey staffCreateButton = GlobalKey();

  static GlobalKey staffListItem = GlobalKey();
  static GlobalKey staffListPlusButton = GlobalKey();

  static GlobalKey tipsTextField = GlobalKey();
  static GlobalKey calculateButton = GlobalKey();

  static GlobalKey paymentCard = GlobalKey();
  static GlobalKey paymentName = GlobalKey();
  static GlobalKey paymentTotal = GlobalKey();

  List<TargetFocus> targetList = [];

  CoachTutorial() {
    targetList.addAll([
      TargetFocus(keyTarget: addStaffButton, contents: []),
      TargetFocus(
        keyTarget: iconPicker,
        contents: [],
        shape: ShapeLightFocus.RRect,
      ),
      TargetFocus(
          keyTarget: staffNameTextField,
          contents: [],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: staffWeightTextField,
          contents: [],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: staffCreateButton,
          contents: [],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: staffListItem, contents: [], shape: ShapeLightFocus.RRect),
      TargetFocus(keyTarget: staffListPlusButton, contents: []),
      TargetFocus(
          keyTarget: tipsTextField, contents: [], shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: calculateButton,
          contents: [],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: paymentCard, contents: [], shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: paymentName, contents: [], shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: paymentTotal, contents: [], shape: ShapeLightFocus.RRect),
      //TargetFocus(keyTarget: settingspagekey, contents: [])
    ]);
  }

  void startTutorialMode(BuildContext context, WidgetRef ref) async {
    ref.read(pageIndexProvider.notifier).setPageIndex(1);
    StaffSettingsPageState.scrollDown();
    await Future.delayed(const Duration(seconds: 1));

    int targetCount = 0;
    bool staffHasBeenAdded = false;

    TutorialCoachMark(
      targets: targetList,
      onClickTarget: (target) async {
        if (targetCount == 0) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return TutorialStaffAlert();
            },
          );
        } else if (targetCount == 1) {
          TutorialStaffAlertState.animateToIcon();
          await ref
              .read(staffArrayNotifierProvider.notifier)
              .addStaffForTutorial(StaffModel(
                  id: -1, name: "Σερβιτόρος Α", weight: 1.4, iconId: 3));
          staffHasBeenAdded = true;
          await Future.delayed(const Duration(seconds: 1));
          HomePageState.totalTips.text = 150.5.toString();

          ListOfStaff.scrollDown();
        } else if (targetCount == 4) {
          Navigator.pop(context);
          ref.read(pageIndexProvider.notifier).setPageIndex(0);
        } else if (targetCount == 6) {
          //prosthese ta badge
          ref
              .read(calculateActiveProvider.notifier)
              .changeCalculateActiveTo(true);
        } else if (targetCount == 8) {
          ref.read(checkProvider.notifier).changeCheck();
        }
        targetCount++;
      },
      onFinish: () {
        if (staffHasBeenAdded) {
          ref.read(staffArrayNotifierProvider.notifier).removeStaffForTutorial(
              StaffModel(id: -1, name: "Σερβιτόρος Α", weight: 1.4, iconId: 3),
              -1);
        }
      },
      onSkip: () {
        if (staffHasBeenAdded) {
          ref.read(staffArrayNotifierProvider.notifier).removeStaffForTutorial(
              StaffModel(id: -1, name: "Σερβιτόρος Α", weight: 1.4, iconId: 3),
              -1);
        }
      },
    ).show(context: context);
  }
}
