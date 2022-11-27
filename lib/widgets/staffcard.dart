import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/models/staffmodel.dart';
import 'package:tips_calculator/widgets/editstaffalert.dart';

import '../providers/staffarrayprovider.dart';

class StaffCard extends ConsumerWidget {
  const StaffCard({required this.staff, required this.cardIndex});

  final StaffModel staff;
  final int cardIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          height: 124.0,
          margin: const EdgeInsets.only(left: 46.0),
          decoration: BoxDecoration(
            color: const Color(0xFF333366),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  staff.name,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Μονάδες :${staff.weight}",
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      onPressed: () => {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return EditStaffAlert(staff);
                          },
                        )
                      },
                      mini: true,
                      child: const Icon(Icons.edit),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      onPressed: () => {
                        ref
                            .read(staffArrayNotifierProvider.notifier)
                            .removeStaff(staff, cardIndex)
                      },
                      mini: true,
                      child: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: FractionalOffset.centerLeft,
          child: Image.asset(
            "assets/images/staff_icon0${staff.iconId}.png",
            height: 92.0,
            width: 92.0,
          ),
        )
      ],
    );
  }
}
