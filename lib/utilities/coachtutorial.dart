import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/providers/pageindexprovider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CoachTutorial {
  GlobalKey<CurvedNavigationBarState> homepagekey = GlobalKey();
  GlobalKey staffsettingpagekey = GlobalKey();
  GlobalKey tipshisotrypagekey = GlobalKey();
  GlobalKey settingspagekey = GlobalKey();

  List<TargetFocus> targetList = [];

  CoachTutorial() {
    targetList.addAll([
      TargetFocus(keyTarget: homepagekey, contents: []),
      //TargetFocus(keyTarget: staffsettingpagekey, contents: []),
      //TargetFocus(keyTarget: tipshisotrypagekey, contents: []),
      //TargetFocus(keyTarget: settingspagekey, contents: [])
    ]);
  }

  void startTutorialMode(BuildContext context, WidgetRef ref) {
    ref.read(pageIndexProvider.notifier).setPageIndex(0);
    // TutorialCoachMark(
    //   targets: targetList,
    //   onClickTarget: (target) {

    //   },
    // ).show(context: context);
  }
}
