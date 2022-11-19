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
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: FractionalOffset.centerLeft,
          child: const Image(
            image: AssetImage("assets/img/02.png"),
            height: 92.0,
            width: 92.0,
          ),
        )
      ],
    );
  }
}
