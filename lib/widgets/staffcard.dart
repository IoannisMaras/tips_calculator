import 'package:flutter/material.dart';
import 'package:tips_calculator/models/staffmodel.dart';

class StaffCard extends StatelessWidget {
  const StaffCard({required this.staff});

  final StaffModel staff;

  @override
  Widget build(BuildContext context) {
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
                const Text(
                  "test",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton.extended(
                      label: Text('EDIT'), // <-- Text
                      backgroundColor: Colors.green.shade600,
                      icon: Icon(
                        // <-- Icon
                        Icons.edit,
                        size: 15.0,
                      ),
                      onPressed: () {},
                    ),
                    FloatingActionButton.extended(
                      label: Text('DELETE'), // <-- Text
                      backgroundColor: Colors.red.shade600,
                      icon: Icon(
                        // <-- Icon
                        Icons.edit,
                        size: 15.0,
                      ),
                      onPressed: () {},
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
