import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tips_calculator/utilities/coachtutorial.dart';

import '../models/staffmodel.dart';
import '../providers/badgeprovider.dart';
import '../providers/staffarrayprovider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ListOfStaff extends ConsumerWidget {
  const ListOfStaff({Key? key}) : super(key: key);
  static ScrollController listViewController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<StaffModel>> staffProvider =
        ref.watch(staffArrayNotifierProvider);

    return staffProvider.when(
      data: (staffArray) {
        return ListView.builder(
            controller: listViewController,
            itemCount: staffArray.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  key: index == staffArray.length - 1
                      ? CoachTutorial.staffListItem
                      : null,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            onPressed: () => {
                              ref
                                  .read(badgeValueProvider.notifier)
                                  .decValue(staffArray[index].id as int)
                            },
                            mini: false,
                            child: const Icon(Icons.remove),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 16.0),
                            alignment: FractionalOffset.centerLeft,
                            child: Image.asset(
                              "assets/images/staff_icon0${staffArray[index].iconId}.png",
                              height: 92.0,
                              width: 92.0,
                            ),
                          ),
                          FloatingActionButton(
                            key: index == staffArray.length - 1
                                ? CoachTutorial.staffListPlusButton
                                : null,
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            onPressed: () => {
                              ref
                                  .read(badgeValueProvider.notifier)
                                  .incValue(staffArray[index].id as int)
                            },
                            mini: false,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      Consumer(
                        builder: (BuildContext context, WidgetRef ref,
                            Widget? child) {
                          Map<int, int> badgeValueArrayProvider =
                              ref.watch(badgeValueProvider);
                          return Badge(
                            toAnimate: true,
                            animationType: BadgeAnimationType.scale,
                            position: BadgePosition.topEnd(top: -12, end: -10),
                            badgeContent: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                badgeValueArrayProvider[
                                        staffArray[index].id as int]
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            badgeColor: const Color(0xFF333366),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(
                                  //   color: Colors.white,
                                  // ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      //minHeight: 5.0,
                                      minWidth: 70,
                                      //maxHeight: 30.0,
                                      //maxWidth: 30.0,
                                    ),
                                    child: AutoSizeText(
                                      staffArray[index].name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Color(0xFF333366),
                                          fontSize: 20),
                                      maxLines: 1,
                                    )),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ));
            });
      },
      error: (e, st) {
        return const Text("error");
      },
      loading: () => Center(
        child: LoadingAnimationWidget.threeRotatingDots(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  static void scrollDown() {
    listViewController.animateTo(
      listViewController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
