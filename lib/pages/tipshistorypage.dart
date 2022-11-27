import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/models/tipshistorymodel.dart';
import 'package:tips_calculator/providers/staffarrayprovider.dart';
import 'package:tips_calculator/providers/tipshistoryprovider.dart';

class TipsHistoryPage extends ConsumerStatefulWidget {
  TipsHistoryPage({Key? key}) : super(key: key);

  @override
  _TipsHistoryPageState createState() => _TipsHistoryPageState();
}

class _TipsHistoryPageState extends ConsumerState<TipsHistoryPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<TipsHistoryModel>> tipsHistoryProvider =
        ref.watch(tipsHistoryArrayNotifierProvider);

    return Container(
      color: const Color.fromRGBO(179, 136, 255, 1),
      child: tipsHistoryProvider.when(
          data: ((tipsHistoryArray) {
            return ListView.builder(
                itemCount: tipsHistoryArray.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      Container(
                        child: Text(tipsHistoryArray[index].id.toString()),
                        color: Colors.red,
                      ),
                      Container(
                        child: Text(tipsHistoryArray[index].value.toString()),
                        color: Colors.green,
                      ),
                      Container(
                        child: Text(tipsHistoryArray[index].date.toString()),
                        color: Colors.white,
                      )
                    ],
                  );
                });
          }),
          error: (e, st) {},
          loading: () {
            return Text("loading..");
          }),
    );
  }
}
