import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/databaseproviders.dart';

class StaffSettingsPage extends ConsumerStatefulWidget {
  StaffSettingsPage({Key? key}) : super(key: key);

  @override
  _StaffSettingsPageState createState() => _StaffSettingsPageState();
}

class _StaffSettingsPageState extends ConsumerState<StaffSettingsPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue staffArray = ref.watch(staffArrayNotifierProvider);
    return Container(
      color: const Color.fromRGBO(179, 136, 255, 1),
      child: staffArray.when(
          data: (data) {
            return Text(data);
          },
          error: error,
          loading: loading),
    );
  }
}
//State notifier prio