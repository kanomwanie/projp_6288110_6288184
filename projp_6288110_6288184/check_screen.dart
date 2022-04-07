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
  List<stat> st = [];

  @override
  void initState() {
    super.initState();
    _loadallmed();
    _loadusermed();
    _loadstat();
  }
void reload(){
  _loadallmed();
  _loadusermed();
  _loadstat();
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

  void _loadstat() {
    widget.api.getall('stat').then((A) {
      setState(() {
        st = A;
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
                        builder: (BuildContext context) => _buildPopupDialog0(
                            context,
                            mdata.gettakemed(st, mdata.getumed(allm, um), 'Y'),st)
                      ).then((val) {
                       reload();
                      });
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
                check(mmed: mdata.gettakemed(st, mdata.getumed(allm, um), 'N'),parent: reload,),
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
                          builder: (BuildContext context) => _buildPopupDialog(
                              context, mdata.getumed(allm, um)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //Center Row contents horizontally,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //Center Row contents vertically,
                        children: (mdata
                                    .intvchecknum(mdata.getumed(allm, um)) ==
                                0)
                            ? [
                                const Text('Check Meds Inventory',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepPurple,
                                    )),
                              ]
                            : [
                                const SizedBox(
                                  width: 50,
                                ),
                                const Text('Check Meds Inventory',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepPurple,
                                    )),
                                const SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Text(
                                    mdata
                                        .intvchecknum(mdata.getumed(allm, um))
                                        .toString(),
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                ),
                              ],
                      )),
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
        const Text(
          'Medicine with less amount in inventory than consumption size will not appear on check list.',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
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

Widget _buildPopupDialog0(BuildContext context, List<med> my,List<stat> st) {
  return AlertDialog(
    title: const Text('Taken Medicine List'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height /
              2, // Change as per your requirement
          width: MediaQuery.of(context).size.width,
          child: taken(mmed: my, st: st,),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Press and hold on medicine name to undo your taken medicine data.',
          style: TextStyle(color: Colors.grey),
        ),
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

class check extends StatefulWidget {
  check({
    required this.mmed,required this.parent,
    Key? key,
  }) : super(key: key);
  final List<med> mmed;
  final server api = server();
  final Function parent;

  @override
  checks createState() => checks();
}


class checks extends State<check> {
  dest(String medid) async {
    await widget.api.mtake(udata.A.current.id, medid,DateTime.now());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Medicine Taken.",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    ));
    widget.parent();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 390, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: widget.mmed.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  widget.mmed[index].name,
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                subtitle: Text(
                  mdata.shortentext(widget.mmed[index].add),
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.check_circle,
                  ),
                  onPressed: () {
                    dest(widget.mmed[index].id);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class taken extends StatefulWidget {
 taken({
    required this.mmed,required this.st,
    Key? key,
  }) : super(key: key);
  final List<med> mmed;
  final List<stat> st;
  final server api = server();

  @override
  takens createState() => takens();
}

class takens extends State<taken> {
dest(String medid) async {
  await widget.api.sde(udata.A.current.id, medid,mdata.gettdate(widget.st, medid));
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text(
      "Taken data removed.",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.purple,
  ));
  Navigator.of(context).pop();
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height:
              MediaQuery.of(context).size.height / 2, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: widget.mmed.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  widget.mmed[index].name,
                ),
                onLongPress: () => {
dest(widget.mmed[index].id)
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
