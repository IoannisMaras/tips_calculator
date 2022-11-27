import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/models/tipshistorymodel.dart';

import '../providers/tipshistoryprovider.dart';

class TipsHistoryPage extends StatefulWidget {
  TipsHistoryPage({Key? key}) : super(key: key);

  @override
  State<TipsHistoryPage> createState() => _TipsHistoryPageState();
}

class _TipsHistoryPageState extends State<TipsHistoryPage> {
  @override
  Widget build(BuildContext context) {
    int selected = 0; //attention

    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      AsyncValue<List<TipsHistoryModel>> tipsHistoryProvider =
          ref.watch(tipsHistoryArrayNotifierProvider);
      return Container(
        color: const Color.fromRGBO(179, 136, 255, 1),
        child: tipsHistoryProvider.when(
            data: ((tipsHistoryArray) {
              return ListView.builder(
                key: Key('builder ${selected.toString()}'), //attention

                padding: EdgeInsets.only(left: 13.0, right: 13.0, bottom: 25.0),
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Column(children: <Widget>[
                    const Divider(
                      height: 17.0,
                      color: Colors.white,
                    ),
                    ExpansionTile(
                        key: Key(index.toString()), //attention
                        initiallyExpanded: index == selected, //attention

                        leading: const Icon(
                          Icons.person,
                          size: 50.0,
                          color: Colors.white,
                        ),
                        title: Text('Faruk AYDIN ${index}',
                            style: const TextStyle(
                                color: Color(0xFF09216B),
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold)),
                        subtitle: const Text(
                          'Software Engineer',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(25.0),
                              child: Text(
                                'DETAİL ${index} \n' +
                                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using "Content here, content here", making it look like readable English.',
                              ))
                        ],
                        onExpansionChanged: ((newState) {
                          if (newState)
                            setState(() {
                              Duration(seconds: 20000);
                              selected = index;
                              print(selected);
                            });
                          else
                            setState(() {
                              selected = -1;
                              print(selected);
                            });
                        })),
                  ]);
                },
              );
            }),
            error: (e, st) {},
            loading: () {
              return Text("loading..");
            }),
      );
    });
  }
}
