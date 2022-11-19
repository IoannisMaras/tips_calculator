import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/staffmodel.dart';
import '../providers/databaseproviders.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
                        return ListTile(
                            leading: const Icon(Icons.list),
                            trailing: const Text(
                              "GFG",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text("List item $index"));
                      } else {
                        return TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.white.withOpacity(0.04);
                                  }

                                  if (states.contains(MaterialState.focused) ||
                                      states.contains(MaterialState.pressed)) {
                                    return Colors.black.withOpacity(0.12);
                                  }

                                  return null; // Defer to the widget's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              ref
                                  .read(staffArrayNotifierProvider.notifier)
                                  .addStaff(StaffModel(
                                      name: "test1", weight: 1.77, iconId: 2));
                            },
                            child: const Text('Add Staff'));
                      }
                    });
              },
              error: (e, st) {
                return const Text("error");
              },
              loading: () => Center(
                child: LoadingAnimationWidget.threeRotatingDots(
                  color: Colors.white,
                  size: 200,
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