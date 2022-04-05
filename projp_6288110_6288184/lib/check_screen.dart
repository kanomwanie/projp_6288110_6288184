import 'package:flutter/material.dart';
import 'server.dart';
import 'login_data.dart' as udata;
import 'med_data.dart' as mdata;

class Medcheck extends StatefulWidget {
  Medcheck({Key? key}) : super(key: key);
  final server api = server();

  @override
  Medchecks createState() => Medchecks();
}

class Medchecks extends State<Medcheck> {
  List<med> allm = [];
  List<usermed> um = [];

  @override
  void initState() {
    super.initState();
    _loadallmed();
    _loadusermed();
  }

  void _loadallmed() {
    widget.api.getall('med').then((A) {
      setState(() {
        allm = A;
      });
    });
  }

  void _loadusermed() {
    widget.api.getall('usermed').then((A) {
      setState(() {
        um = A;
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(
        children: (mdata.checkm(allm, um))
            ? [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Today Meds',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.left,
                ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30, //height of button
            width: 400,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // foreground (text) color
                primary: const Color(0xffedc8f5),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildPopupDialog0(context, mdata.getumed(allm, um)),
                );
              },
              child: const Text('Taken medicine',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                  )),
            ),
          ),
                const SizedBox(
                  height: 20,
                ),

                check(mmed: mdata.getumed(allm, um)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50, //height of button
                  width: 400,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // foreground (text) color
                      primary: const Color(0xffedc8f5),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context, mdata.getumed(allm, um)),
                      );
                    },
                    child: const Text('Check Meds Inventory',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                        )),
                  ),
                ),
              ]
            : [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Today Meds',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 430,
                  child: Text(
                      "You currently don't have any medicine. You can go to medicine database to add medicine."),
                ),
              ]);
    //
  }
}

Widget _buildPopupDialog(BuildContext context, List<med> my) {
  return AlertDialog(
    title: const Text('Inventory'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(mdata.intvcheck(my)),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
Widget _buildPopupDialog0(BuildContext context, List<med> my) {
  return AlertDialog(
    title: const Text('Taken Medicine List'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
    Container(
      height: MediaQuery.of(context).size.height/2, // Change as per your requirement
      width: MediaQuery.of(context).size.width,
      child:taken(mmed: my),
    ),
        const SizedBox(
          height: 20,
        ),
        const Text('Press and hold on medicine name to undo your taken medicine data.',style: TextStyle(color: Colors.grey),),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}
class check extends StatelessWidget {
  const check({
    required this.mmed,
    Key? key,
  }) : super(key: key);
  final List<med> mmed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 390, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: mmed.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  mmed[index].name,
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                subtitle: Text(
                  mdata.shortentext(mmed[index].add),
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.check_circle,
                  ),
                  onPressed: () {},
                ),

              );
            },
          ),
        ),
      ],
    );
  }
}

class taken extends StatelessWidget {
  const taken({
    required this.mmed,
    Key? key,
  }) : super(key: key);
  final List<med> mmed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height/2, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: mmed.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  mmed[index].name,
                ),
                onLongPress: () => {
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
