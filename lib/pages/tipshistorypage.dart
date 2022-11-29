import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/models/tipshistorymodel.dart';

import '../models/tipshistorydetailsmodel.dart';
import '../providers/historydetailsprovider.dart';
import '../providers/tipshistoryprovider.dart';

class TipsHistoryPage extends StatefulWidget {
  TipsHistoryPage({Key? key}) : super(key: key);

  @override
  State<TipsHistoryPage> createState() => _TipsHistoryPageState();
}

class _TipsHistoryPageState extends State<TipsHistoryPage> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: const Color(0xFF333366),
            child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              AsyncValue<List<TipsHistoryModel>> tipsHistoryProvider =
                  ref.watch(tipsHistoryArrayNotifierProvider);
              return tipsHistoryProvider.when(data: ((tipsHistoryArray) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    //attention

                    shrinkWrap: true,
                    itemCount: tipsHistoryArray.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            if (selected == index) {
                              setState(() {
                                selected = -1;
                              });
                            } else {
                              if (tipsHistoryArray[index].id != null) {
                                ref
                                    .read(historyDetailsProvider.notifier)
                                    .getTipsHistoryDetails(
                                        tipsHistoryArray[index].id as int);
                              }
                              setState(() {
                                selected = index;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: selected == index
                                  ? const Color.fromRGBO(179, 136, 255, 1)
                                  : Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${tipsHistoryArray[index].date.day.toString()}/${tipsHistoryArray[index].date.month.toString()}/${tipsHistoryArray[index].date.year.toString()}",
                                    style: TextStyle(
                                        color: selected == index
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                179, 136, 255, 1),
                                        fontSize: 25),
                                  ),
                                  Text(
                                    "${tipsHistoryArray[index].value.toString()}€",
                                    style: TextStyle(
                                        color: selected == index
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                179, 136, 255, 1),
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                );
              }), error: (e, st) {
                return const Text("error");
              }, loading: () {
                return const Text("loading..");
              });
            }),
          ),
        ),
        const Divider(
          thickness: 15,
          color: Colors.white,
        ),
        Expanded(
          child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            AsyncValue<List<TipsHistoryDetailsModel>>
                tipsHistoryDetailsProvider = ref.watch(historyDetailsProvider);
            return tipsHistoryDetailsProvider.when(data: (historyDetailsArray) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: historyDetailsArray.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(historyDetailsArray[index].name.toString()),
                      Text(historyDetailsArray[index].count.toString()),
                      Text(historyDetailsArray[index].value.toString()),
                    ],
                  );
                },
              );
            }, error: (e, st) {
              return const Text("error");
            }, loading: () {
              return const Text("loading..");
            });
          }),
        )
      ],
    );
  }
}
