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
  @override
  Widget build(BuildContext context) {
    int selected = 0; //attention

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            AsyncValue<List<TipsHistoryModel>> tipsHistoryProvider =
                ref.watch(tipsHistoryArrayNotifierProvider);
            return Container(
              color: const Color(0xFF333366),
              child: tipsHistoryProvider.when(data: ((tipsHistoryArray) {
                return ListView.builder(
                  key: Key('builder ${selected.toString()}'), //attention

                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: tipsHistoryArray.length,
                  itemBuilder: (context, index) {
                    return Text(tipsHistoryArray[index].date.toString());
                  },
                );
              }), error: (e, st) {
                return const Text("error");
              }, loading: () {
                return const Text("loading..");
              }),
            );
          }),
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
                key: Key('builder ${selected.toString()}'), //attention

                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: historyDetailsArray.length,
                itemBuilder: (context, index) {
                  return Text(historyDetailsArray[index].count.toString());
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
