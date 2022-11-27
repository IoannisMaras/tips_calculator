import 'package:flutter/material.dart';

class TEST extends StatefulWidget {
  TEST({Key? key}) : super(key: key);

  @override
  State<TEST> createState() => _TESTState();
}

class _TESTState extends State<TEST> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
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
  }
}
