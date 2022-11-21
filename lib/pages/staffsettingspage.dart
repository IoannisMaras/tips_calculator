import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/widgets/staffcard.dart';

import '../models/staffmodel.dart';
import '../providers/databaseproviders.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/newstaffalert.dart';

class StaffSettingsPage extends ConsumerStatefulWidget {
  StaffSettingsPage({Key? key}) : super(key: key);

  @override
  _StaffSettingsPageState createState() => _StaffSettingsPageState();
}

class _StaffSettingsPageState extends ConsumerState<StaffSettingsPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<StaffModel>> staffProvider =
        ref.watch(staffArrayNotifierProvider);
    return Center(
      child: Column(
        children: [
          Flexible(
            child: staffProvider.when(
              data: (staffArray) {
                return ListView.builder(
                    itemCount: staffArray.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < staffArray.length) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StaffCard(
                              staff: staffArray[index], cardIndex: index),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                          child: Row(
                            children: [
                              Expanded(flex: 20, child: Container()),
                              Expanded(
                                flex: 16,
                                child: FloatingActionButton.extended(
                                  icon: const Icon(Icons.add),
                                  label: const Text("Προσθήκη"),
                                  backgroundColor: const Color(0xFF333366),
                                  foregroundColor: Colors.white,
                                  onPressed: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return NewStaffAlert();
                                      },
                                    );
                                  },
                                ),
                              ),
                              Expanded(flex: 13, child: Container()),
                            ],
                          ),
                        );
                      }
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
            ),
          ),
        ],
      ),
    );
  }
}
//State notifier prio