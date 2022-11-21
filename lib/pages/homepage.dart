import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../models/staffmodel.dart';
import '../providers/databaseproviders.dart';
import 'package:badges/badges.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<StaffModel>> staffProvider =
        ref.watch(staffArrayNotifierProvider);
    return Column(
      children: [
        const Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Συνολικό ποσό",
            style: TextStyle(color: Color(0xFF333366), fontSize: 32),
          ),
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF333366), fontSize: 25),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF333366).withOpacity(0.7), width: 5.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF333366), width: 2.0),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(15),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        staffProvider.when(
          data: (staffArray) {
            return Expanded(
              child: ListView.builder(
                  itemCount: staffArray.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < staffArray.length) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FloatingActionButton(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    onPressed: () => {},
                                    mini: false,
                                    child: const Icon(Icons.remove),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    alignment: FractionalOffset.centerLeft,
                                    child: Image.asset(
                                      "assets/images/staff_icon0${staffArray[index].iconId}.png",
                                      height: 92.0,
                                      width: 92.0,
                                    ),
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    onPressed: () => {},
                                    mini: false,
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                              Badge(
                                animationType: BadgeAnimationType.scale,
                                position:
                                    BadgePosition.topEnd(top: -12, end: -10),
                                badgeContent: const Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Text(
                                    '3',
                                    style: TextStyle(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          //minHeight: 5.0,
                                          minWidth: 70,
                                          //maxHeight: 30.0,
                                          //maxWidth: 30.0,
                                        ),
                                        child: Text(
                                          staffArray[index].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF333366),
                                              fontSize: 20),
                                        )),
                                  ),
                                ),
                              )
                            ],
                          ));
                    } else {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                        child: Row(
                          children: [
                            Expanded(child: Container()),
                            Expanded(
                              //flex: 16,
                              child: FloatingActionButton.extended(
                                icon: const Icon(Icons.save),
                                label: const Text("Αποθήκευση"),
                                backgroundColor: const Color(0xFF333366),
                                foregroundColor: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      );
                    }
                  }),
            );
          },
          error: (e, st) {
            return const Text("error");
          },
          loading: () => Expanded(
            child: Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
