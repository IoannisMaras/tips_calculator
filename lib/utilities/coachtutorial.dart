import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CoachTutorial {

   GlobalKey<CurvedNavigationBarState> homepagekey = GlobalKey();
  GlobalKey staffsettingpagekey = GlobalKey();
  GlobalKey tipshisotrypagekey = GlobalKey();
  GlobalKey settingspagekey = GlobalKey();

  List<TargetFocus> targetList = [];

  CoachTutorial(){
    targetList.addAll([
      TargetFocus(keyTarget:homepagekey , contents: []),
      //TargetFocus(keyTarget: staffsettingpagekey, contents: []),
      //TargetFocus(keyTarget: tipshisotrypagekey, contents: []),
      //TargetFocus(keyTarget: settingspagekey, contents: [])
    ]);
  }

  void startTutorialMode(BuildContext context) {
    TutorialCoachMark(targets: targetList).show(context: context);
  }
   
}