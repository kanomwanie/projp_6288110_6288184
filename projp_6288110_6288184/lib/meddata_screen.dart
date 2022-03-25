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
      ),
      // 3
      body: Center(
          child: Column(children: mdata.checkm(allm, um)
          ?[
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
                builder: (BuildContext context) => _buildPopupDialog(context),
              );
            },
            child: const Text('Add New Med',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                )),
          ),
        ),
      ]
              :[
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
           const Text("You don't have any medicine in the database. Please press 'Add New Med' to add medicine to the database."),
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
                    builder: (BuildContext context) => _buildPopupDialog(context),
                  );
                },
                child: const Text('Add New Med',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                    )),
              ),
            ),
          ]
          )),
    );
  }
}

class medl extends StatelessWidget {
  medl({required this.fruitDataModel, Key? key}) : super(key: key);
  final List<med> fruitDataModel;

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

class Medinfo extends StatelessWidget {
  final med fruitDataModel;

  const Medinfo({Key? key, required this.fruitDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DailyMeds'),
      ),
      body: Column(
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
                      fruitDataModel.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 45),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      mdata.sizeandintv(fruitDataModel),
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
                    fruitDataModel.add,
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
                          _buildPopupDialog2(context, fruitDataModel.name),
                    );
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
                      builder: (BuildContext context) =>
                          _buildPopupDialog3(context, fruitDataModel.name),
                    );
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
    );
  }
}

class FruitDataModel {
  final String name, serving, desc;

  FruitDataModel(this.name, this.serving, this.desc);
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Add Medicine'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: 700,
        ),
        const Text("Medicine name"),
        const TextField(
          decoration: InputDecoration(
            hintText: "Name",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Serving size"),
        const TextField(
          decoration: InputDecoration(
            hintText: "Size",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Taken time (if required)"),
        Row(
          children: const [
            SizedBox(
              width: 100,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Hours",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              width: 23,
            ),
            Text(":",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(
              width: 23,
            ),
            SizedBox(
              width: 100,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Mins",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Additional Data"),
        const TextField(
          decoration: InputDecoration(
            hintText: "Additional",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
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
}

Widget _buildPopupDialog2(BuildContext context, String mname) {
  return AlertDialog(
    title: const Text('Edit Medicine'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: 700,
        ),
        Text(mname),
        const TextField(
          decoration: InputDecoration(
            hintText: "Name",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Serving size"),
        const TextField(
          decoration: InputDecoration(
            hintText: "Size",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Taken time (if required)"),
        const TextField(
          decoration: InputDecoration(
            hintText: "Time",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text("Additional Data"),
        const TextField(
          decoration: InputDecoration(
            hintText: "Additional",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
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
}

Widget _buildPopupDialog3(BuildContext context, String mname) {
  return AlertDialog(
    title: const Text('Delete Med data'),
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
          Navigator.of(context).pop();
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
