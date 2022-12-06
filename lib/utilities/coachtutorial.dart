import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/models/staffmodel.dart';
import 'package:tips_calculator/providers/pageindexprovider.dart';
import 'package:tips_calculator/providers/staffarrayprovider.dart';
import 'package:tips_calculator/widgets/listofstaff.dart';
import 'package:tips_calculator/widgets/tutorialstaffalert.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../pages/staffsettingspage.dart';

class CoachTutorial {
  static GlobalKey<CurvedNavigationBarState> addStaffButton = GlobalKey();
  static GlobalKey iconPicker = GlobalKey();
  static GlobalKey staffNameTextField = GlobalKey();
  static GlobalKey staffWeightTextField = GlobalKey();
  static GlobalKey staffCreateButton = GlobalKey();

  static GlobalKey staffListItem = GlobalKey();
  static GlobalKey staffListPlusButton = GlobalKey();

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
        } else if (targetCount == 4) {
          ref.read(pageIndexProvider.notifier).setPageIndex(0);

          Navigator.pop(context);

          ListOfStaff.scrollDown();
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
