import 'package:flutter/material.dart';
import 'server.dart';
import 'login_data.dart' as udata;
import 'med_data.dart' as mdata;

class Meddata extends StatefulWidget {
  Meddata({Key? key}) : super(key: key);
  final server api = server();

  @override
  Meddatas createState() => Meddatas();
}

class Meddatas extends State<Meddata> {
  List<med> allm = [];
  List<usermed> um = [];

  @override
  void initState() {
    super.initState();
    _loadallmed();
    _loadusermed();
  }

  void reload() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2
      appBar: AppBar(
        title: const Text('DailyMeds'),
        leading: GestureDetector(
          onTap: () {    Navigator.pushNamed(context,'/ufc',);/* Write listener code here */ },
          child: const Icon(
            Icons.arrow_back,  // add custom icons also
          ),
        ),
      ),
      // 3
      body: Center(
    child: SingleChildScrollView(
          child: Column(
              children: mdata.checkm(allm, um)
                  ? [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'My medicine',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      medl(
                        fruitDataModel: mdata.getumed(allm, um),
                        parent: reload,
                      ),
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
                                  _buildPopupDialog(context),
                            ).then((_) {
                              // This block runs when you have returned back to the 1st Page from 2nd.
                              reload();
                            });
                          },
                          child: const Text('Add New Med',
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
                        'My medicine',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          "You don't have any medicine in the database. Please press 'Add New Med' to add medicine to the database."),
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
                                  _buildPopupDialog(context),
                            ).then((_) {
                              // This block runs when you have returned back to the 1st Page from 2nd.
                              reload();
                            });
                          },
                          child: const Text('Add New Med',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple,
                              )),
                        ),
                      ),
                    ])),
    ));
  }
}

class medl extends StatelessWidget {
  medl({required this.fruitDataModel, required this.parent, Key? key})
      : super(key: key);
  final List<med> fruitDataModel;
  final Function parent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 500, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: fruitDataModel.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  fruitDataModel[index].name,
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                subtitle: Text(mdata.shortentext(fruitDataModel[index].add)),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Medinfo(
                            fruitDataModel: fruitDataModel[index],
                            parent: parent,
                          )));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class Medinfo extends StatefulWidget {
  final med fruitDataModel;
  final Function parent;

  const Medinfo({Key? key, required this.fruitDataModel, required this.parent})
      : super(key: key);

  @override
  Medinfos createState() => Medinfos();
}

class Medinfos extends State<Medinfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyMeds'),
        leading: GestureDetector(
          onTap: () {   Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Meddata()),
          );/* Write listener code here */ },
          child: const Icon(
            Icons.arrow_back,  // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              height: 130.0,
              width: 500.0,
              decoration: const BoxDecoration(
                color: Color(0xffECECEC),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Text(
                      widget.fruitDataModel.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 45),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      mdata.sizeandintv(widget.fruitDataModel.size,widget.fruitDataModel.intv,widget.fruitDataModel.time),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ) //
              ),
          Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              height: 430.0,
              width: 500.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.fruitDataModel.add,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ) //
              ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 50, //height of button
                width: 180,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // foreground (text) color
                    primary: const Color(0xffedc8f5),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog2(context, widget.fruitDataModel),
                    ).then((_) {
                      // This block runs when you have returned back to the 1st Page from 2nd.
                      widget.parent();
                    });
                  },
                  child: const Text('Edit data',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                      )),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 50, //height of button
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // foreground (text) color
                    primary: const Color(0xffedc8f5),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildPopupDialog3(
                          context,
                          widget.fruitDataModel.name,
                          widget.fruitDataModel.id),
                    ).then((_) {
                      // This block runs when you have returned back to the 1st Page from 2nd.
                      widget.parent();
                    });
                  },
                  child: const Text('Delete data',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepPurple,
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

class FruitDataModel {
  final String name, serving, desc;

  FruitDataModel(this.name, this.serving, this.desc);
}

Widget _buildPopupDialog(BuildContext context) {
  final server api = server();
  final namecontrol = TextEditingController();
  final sizecontrol = TextEditingController();
  final hourcontrol = TextEditingController();
  final mincontrol = TextEditingController();
  final addcontrol = TextEditingController();
  final intvrcontrol = TextEditingController();
  bool w = false;
  bool t = false;
  bool n = false;
  bool n0 = false;
  renotiii() async {
    int min = 0;
    int hour = 8;
    if (hourcontrol.text != '' && mincontrol.text != '') {
      min = int.parse(mincontrol.text);
      hour = int.parse(hourcontrol.text);
    } else if (hourcontrol.text == '' && mincontrol.text != '') {
      hour = 0;
    } else if (hourcontrol.text != '' && mincontrol.text == '') {
      min = 0;
    }
    await api.madd(
        udata.A.current.mid,
        namecontrol.text,
        hour,
        min,
        int.parse(sizecontrol.text),
        int.parse(intvrcontrol.text),
        addcontrol.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Medicine added.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    ));
    Navigator.of(context).pop();
  }

  return StatefulBuilder(builder: (context, setState) {
    return AlertDialog(
      title: const Text('Add Medicine'),
      content: SingleChildScrollView(child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 600,
          ),
          const Text("* = Required", style: TextStyle(color: Colors.grey)),
          const SizedBox(
            width: 100,
          ),
          const Text("Medicine name*"),
          TextField(
            controller: namecontrol,
            decoration: const InputDecoration(
              hintText: "Name",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Consumption size*"),
          TextField(
            controller: sizecontrol,
            decoration: const InputDecoration(
              hintText: "Size",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          Visibility(
            child: const Text(
              'Number only',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 10),
            ),
            visible: n,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Taken time (if have)"),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: TextField(
                  controller: hourcontrol,
                  decoration: const InputDecoration(
                    hintText: "Hours",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                width: 23,
              ),
              const Text(
                ":",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 23,
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: mincontrol,
                  decoration: const InputDecoration(
                    hintText: "Mins",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            child: const Text(
              'Please input number between 0-23 for hour and 0-59 for min.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 10),
            ),
            visible: t,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
              "*If there is no specific time the system will set the notification in to default time. (8:00)",
              style: TextStyle(color: Colors.grey,fontSize: 10)),
          const SizedBox(
            height: 10,
          ),
          const Text("Inventory*"),
          TextField(
            controller: intvrcontrol,
            decoration: const InputDecoration(
              hintText: "Current amount of pills you have.",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          Visibility(
            child: const Text(
              'Number only',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 10),
            ),
            visible: n0,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Additional Data"),
          TextField(
            controller: addcontrol,
            decoration: const InputDecoration(
              hintText: "Additional",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            child: const Text(
              'Please input in all required filed.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 10),
            ),
            visible: w,
          ),

        ],
      )),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (mdata.checkinput(
                    namecontrol.text, sizecontrol.text, intvrcontrol.text) &&
                mdata.checktime(hourcontrol.text, 'h') &&
                mdata.checktime(mincontrol.text, 'm') &&
                mdata.checknum(intvrcontrol.text) &&
                mdata.checknum(sizecontrol.text)) {
              renotiii();
            } else {
              if (!mdata.checkinput(
                  namecontrol.text, sizecontrol.text, intvrcontrol.text)) {
                setState(() {
                  w = true;
                });
              }
              if (!mdata.checktime(hourcontrol.text, 'h') ||
                  !mdata.checktime(mincontrol.text, 'm')) {
                setState(() {
                  t = true;
                });
              }
              if (!mdata.checknum(intvrcontrol.text)) {
                setState(() {
                  n0 = true;
                });
              }
              if (!mdata.checknum(sizecontrol.text)) {
                setState(() {
                  n = true;
                });
              }
            }
          },
          child: const Text('ADD'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  });
}

Widget _buildPopupDialog2(BuildContext context, med W) {
  final server api = server();
  final namecontrol = TextEditingController();
  final sizecontrol = TextEditingController();
  final hourcontrol = TextEditingController();
  final mincontrol = TextEditingController();
  final addcontrol = TextEditingController();
  final intvrcontrol = TextEditingController();
  bool w = false;
  bool t = false;
  bool n = false;
  bool n0 = false;

renotiii(String name, String size, String intv, String h, String m, String add) async {
    int min = 0;
    int hour = 8;
    if (h != '' && m != '') {
      min = int.parse(m);
      hour = int.parse(h);
    } else if (h == '' && m != '') {
      hour = 0;
    } else if (h != '' && m == '') {
      min = 0;
    }
   var res =  await api.mup(W.id,
       name,
        hour,
        min,
        int.parse(size),
        int.parse(intv),
        add);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Medicine Updated.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    ));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Meddata()),
    );

  }

  return StatefulBuilder(builder: (context, setState) {
    return AlertDialog(
      title: const Text('Edit Medicine'),
      content:  SingleChildScrollView(child:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            width: 700,
          ),
          const Text("* = Required", style: TextStyle(color: Colors.grey)),
          const SizedBox(
            width: 100,
          ),
          const Text("Medicine name*"),
          TextField(
            controller: namecontrol..text = W.name,
            onChanged: (text) => {},
            decoration: const InputDecoration(
              hintText: "Name",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Consumption size*"),
          TextField(
            controller: sizecontrol..text = W.size,
            onChanged: (text) => {},
            decoration: const InputDecoration(
              hintText: "Size",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          Visibility(
            child: const Text(
              'Number only',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 10),
            ),
            visible: n,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Taken time (if have)"),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: TextField(
                  controller: hourcontrol..text = W.time[0] + W.time[1],
                  onChanged: (text) => {},
                  decoration: const InputDecoration(
                    hintText: "Hours",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                width: 23,
              ),
              const Text(
                ":",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 23,
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: mincontrol
                    ..text =
                        W.time[W.time.length - 2] + W.time[W.time.length - 1],
                  onChanged: (text) => {},
                  decoration: const InputDecoration(
                    hintText: "Mins",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            child: const Text(
              'Please input number between 0-23 for hour and 0-59 for min.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 10),
            ),
            visible: t,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
              "*If there is no specific time the system will set the notification in to default time. (8:00)",
              style: TextStyle(color: Colors.grey,fontSize: 10)),
          const SizedBox(
            height: 10,
          ),
          const Text("Inventory*"),
          TextField(
            controller: intvrcontrol..text = W.intv,
            onChanged: (text) => {},
            decoration: const InputDecoration(
              hintText: "Current amount of pills you have.",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          Visibility(
            child: const Text(
              'Number only',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 10),
            ),
            visible: n0,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Additional Data"),
          TextField(
            controller: addcontrol..text = W.add,
            onChanged: (text) => {},
            decoration: const InputDecoration(
              hintText: "Additional",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),

          Visibility(
            child: const Text(
              'Please input in all required filed.',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            visible: w,
          ),

        ],
      )),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (mdata.checkinput(
                    namecontrol.text, sizecontrol.text, intvrcontrol.text) &&
                mdata.checktime(hourcontrol.text, 'h') &&
                mdata.checktime(mincontrol.text, 'm') &&
                mdata.checknum(intvrcontrol.text) &&
                mdata.checknum(sizecontrol.text)) {

              //String name, String size, String intv, String h, String m, String add
             renotiii(namecontrol.text, sizecontrol.text, intvrcontrol.text,hourcontrol.text, mincontrol.text,addcontrol.text);


            } else {
              if (!mdata.checkinput(
                  namecontrol.text, sizecontrol.text, intvrcontrol.text)) {
                setState(() {
                  w = true;
                });
              }
              if (!mdata.checktime(hourcontrol.text, 'h') ||
                  !mdata.checktime(mincontrol.text, 'm')) {
                setState(() {
                  t = true;
                });
              }
              if (!mdata.checknum(intvrcontrol.text)) {
                setState(() {
                  n0 = true;
                });
              }
              if (!mdata.checknum(sizecontrol.text)) {
                setState(() {
                  n = true;
                });
              }
            }
          },
          child: const Text('Edit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  });
}

Widget _buildPopupDialog3(BuildContext context, String mname, String id) {
  final server api = server();
  renotiii() async {
    await api.mde(udata.A.current.mid, id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Medicine removed',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    ));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Meddata()),
    );
  }

  return AlertDialog(
    title: const Text('Delete Medicine data'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Are you sure you want to delete " + mname + " ?",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          renotiii();
        },
        child: const Text('Yes'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('No'),
      ),
    ],
  );
}
