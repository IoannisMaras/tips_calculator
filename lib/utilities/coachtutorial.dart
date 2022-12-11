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

  CoachTutorial();

  void startTutorialMode(BuildContext context, WidgetRef ref) async {
    if (ref.read(staffArrayNotifierProvider).isLoading ||
        ref.read(staffArrayNotifierProvider).hasError) {
      return;
    }
    fillTargetList(ref);
    bool isdoubletap = false;

    ref.read(pageIndexProvider.notifier).setPageIndex(1);
    StaffSettingsPageState.scrollDown();
    await Future.delayed(const Duration(seconds: 1));

    bool alertIsOpen = false;
    bool staffHasBeenAdded = false;

    TutorialCoachMark(
      targets: targetList,
      onClickTarget: (target) async {
        if (!isdoubletap && target.keyTarget == addStaffButton) {
          isdoubletap = !isdoubletap;

          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return TutorialStaffAlert();
            },
          );
          alertIsOpen = true;
        } else if (isdoubletap && target.keyTarget == iconPicker) {
          isdoubletap = !isdoubletap;

          TutorialStaffAlertState.animateToIcon();
          await ref
              .read(staffArrayNotifierProvider.notifier)
              .addStaffForTutorial(StaffModel(
                  id: -1, name: "Σερβιτόρος Α", weight: 1.4, iconId: 3));
          staffHasBeenAdded = true;
          await Future.delayed(const Duration(seconds: 1));
          HomePageState.totalTips.text = 150.5.toString();

          ListOfStaff.scrollDown();
        } else if (!isdoubletap && target.keyTarget == staffCreateButton) {
          isdoubletap = !isdoubletap;

          Navigator.pop(context);
          alertIsOpen = false;
          ref.read(pageIndexProvider.notifier).setPageIndex(0);
        } else if (isdoubletap && target.keyTarget == staffListPlusButton) {
          isdoubletap = !isdoubletap;
          //prosthese ta badge
          ref
              .read(calculateActiveProvider.notifier)
              .changeCalculateActiveTo(true);
        } else if (!isdoubletap && target.keyTarget == calculateButton) {
          isdoubletap = !isdoubletap;
          ref.read(checkProvider.notifier).changeCheck();
        }
      },
      onFinish: () {
        if (staffHasBeenAdded) {
          ref.read(staffArrayNotifierProvider.notifier).removeStaffForTutorial(
              StaffModel(id: -1, name: "Σερβιτόρος Α", weight: 1.4, iconId: 3),
              -1);
        }
        if (alertIsOpen) {
          Navigator.pop(context);
        }
      },
      onSkip: () {
        if (staffHasBeenAdded) {
          ref.read(staffArrayNotifierProvider.notifier).removeStaffForTutorial(
              StaffModel(id: -1, name: "Σερβιτόρος Α", weight: 1.4, iconId: 3),
              -1);
        }
        if (alertIsOpen) {
          Navigator.pop(context);
        }
      },
    ).show(context: context);
  }

  void fillTargetList(WidgetRef ref) {
    int staffArrayLength = 0;
    ref
        .read(staffArrayNotifierProvider)
        .whenData((value) => staffArrayLength = value.length);
    targetList.addAll([
      TargetFocus(keyTarget: addStaffButton, contents: [
        TargetContent(
          align: staffArrayLength > 2 ? ContentAlign.top : ContentAlign.bottom,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: staffArrayLength < 2 ? 100 : 0,
              ),
              const Text(
                "Προσθήκη Θέσης",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Ας αρχίσουμε προσθέτοντας μια θέση του καταστήματος και να δούμε τι επιλογές έχουμε για αυτή την θέση",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                height: staffArrayLength > 2 ? 100 : 0,
              ),
            ],
          ),
        )
      ]),
      TargetFocus(
        keyTarget: iconPicker,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "Εικόνα Θέσης",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Κάνοντας scroll μπορούμε να διαλέξουμε μια από τις διαθέσιμες εικόνες που αντιπροσωπεύουν καλύτερα την θέση που θέλουμε να δημιουργήσουμε",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
      ),
      TargetFocus(
          keyTarget: staffNameTextField,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Όνομα Θέσης",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Συμπληρώνουμε το όνομα της θέσης που θέλουμε να δημιουργήσουμε",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: staffWeightTextField,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Μονάδες Θέσης",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Και τέλος τις μονάδες της θέσεις. Όσες περισσότερες μονάδες έχει μια θέση τόσο μεγαλύτερο είναι το ποσοστό που θα παίρνει",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: staffCreateButton,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Δημιουργία Θέσης",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Αφού έχουμε συμπληρώσει το όνομα και τις μονάδες πατάμε το κουμπί «Δημιουργία» για να προσθέσουμε την θέση",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: staffListItem,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Η Καινούρια Θέση",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Εδώ φαίνεται μια καινούρια θέση με όνομα Σερβιτόρος Α και μονάδες 2.0",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
          shape: ShapeLightFocus.RRect),
      TargetFocus(keyTarget: staffListPlusButton, contents: [
        TargetContent(
          align: ContentAlign.top,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              Text(
                "Πλήθος της Θέσης",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Πατώντας το κουμπί «+» ή «-» αντίστοιχα , αυξομειώνουμε το πλήθος των ατόμων που θα μοιραστούν τα φιλοδωρήματα",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ]),
      TargetFocus(
          keyTarget: tipsTextField,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Συνολικό Ποσό",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Συμπληρώνουμε το συνολικό ποσό φιλοδωρημάτων που θα μοιραστεί σε όλες τις θέσεις",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: calculateButton,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Υπολογισμός",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Και πατώντας το κουμπί υπολογισμός, η εφαρμογή θα μας εμφανίσει αναλυτικά το ποσό που αναλογεί στον καθένα από την εκάστοτε θέση",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: paymentCard,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Αναλυτικά",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Μπορούμε να δούμε πλέον το ποσό που δικαιούται ο κάθε Σερβιτόρος Α",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
          shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: paymentName, contents: [], shape: ShapeLightFocus.RRect),
      TargetFocus(
          keyTarget: paymentTotal, contents: [], shape: ShapeLightFocus.RRect),
      //TargetFocus(keyTarget: settingspagekey, contents: [])
    ]);
  }
}
