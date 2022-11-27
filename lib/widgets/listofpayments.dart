import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/staffmodel.dart';
import '../providers/badgeprovider.dart';
import '../providers/staffarrayprovider.dart';

class ListOfPayments extends ConsumerWidget {
  final double totalTips;
  const ListOfPayments(this.totalTips, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<StaffModel>> staffProvider =
        ref.watch(staffArrayNotifierProvider);

    Map<int, int> badgeValueArrayProvider = ref.watch(badgeValueProvider);
    return staffProvider.when(
      data: (staffArray) {
        double totalWeight =
            calculateTotalWeight(staffArray, badgeValueArrayProvider);
        return ListView.builder(
            itemCount: staffArray.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                          flex: 5,
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
                              child: Column(
                                children: [
                                  Text(
                                    staffArray[index].name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color(0xFF333366), fontSize: 20),
                                  ),
                                  Text(
                                    (badgeValueArrayProvider[
                                                    staffArray[index].id as int]
                                                as int) ==
                                            0
                                        ? "0€"
                                        : "${(totalTips * (staffArray[index].weight / totalWeight)).toStringAsFixed(2)}€",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Expanded(child: Container()),
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

  double calculateTotalWeight(
      List<StaffModel> staffArray, Map<int, int> badgeArray) {
    double totalWeight = 0;
    for (StaffModel staff in staffArray) {
      totalWeight += staff.weight * badgeArray[staff.id as int]!;
    }
    return totalWeight;
  }
}
