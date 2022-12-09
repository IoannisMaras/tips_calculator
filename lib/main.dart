import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tips_calculator/pages/homepage.dart';
import 'package:tips_calculator/pages/settingspage.dart';
import 'package:tips_calculator/pages/staffsettingspage.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tips_calculator/pages/tipshistorypage.dart';
import 'package:tips_calculator/providers/pageindexprovider.dart';
import 'package:tips_calculator/utilities/coachtutorial.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(179, 136, 255, 1),
        useMaterial3: true,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        backgroundColor: const Color.fromRGBO(179, 136, 255, 1),
        //primaryColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    CoachTutorial coachTutorial = CoachTutorial();
    int pageIndex = ref.watch(pageIndexProvider);
    final CurvedNavigationBarState? navBarState =
        bottomNavigationKey.currentState;
    navBarState?.setPage(pageIndex);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color.fromRGBO(179, 136, 255, 1),
          extendBody: true,
          appBar: AppBar(
            title: Row(
              children: [
                const Flexible(
                    child: AutoSizeText(
                  "Φιλοδωρήματα ",
                  style: TextStyle(color: Color(0xFF333366)),
                  maxLines: 1,
                )),
                Flexible(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    coachTutorial.startTutorialMode(context, ref);
                  },
                  icon: const Icon(
                    Icons.help,
                    color: Color(0xFF333366),
                    size: 35,
                  ))
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            key: bottomNavigationKey,
            height: 50,
            items: const <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Color(0xFF333366),
              ),
              Icon(
                Icons.supervisor_account,
                size: 30,
                color: Color(0xFF333366),
              ),
              Icon(
                Icons.list,
                size: 30,
                color: Color(0xFF333366),
              ),
              Icon(
                Icons.settings,
                size: 30,
                color: Color(0xFF333366),
              ),
            ],
            onTap: (index) {
              ref.read(pageIndexProvider.notifier).setPageIndex(index);
            },
          ),
          body: IndexedStack(index: pageIndex, children: [
            HomePage(),
            StaffSettingsPage(),
            TipsHistoryPage(),
            SettingsPage()
          ])),
    );
  }
}
