import 'package:flutter/material.dart';

class Meddata extends StatelessWidget {
  const Meddata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2
      appBar: AppBar(
        title: const Text('DailyMeds'),
      ),
      // 3
      body: Center(
          child: Column(children: <Widget>[
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
        medl(),
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
      ])),
    );
  }
}

class medl extends StatelessWidget {
  medl({Key? key}) : super(key: key);
  static List<String> products = [
    'Painkiller',
    'random1',
    'random2',
  ];
  static List<String> INst = [
    'Take two',
    'Take one',
    'Take me on',
  ];
  final List<FruitDataModel> Fruitdata = List.generate(
      products.length,
      (index) => FruitDataModel(
          products[index], INst[index], '${products[index]} Description...'));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 500, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  products[index],
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                subtitle: Text(INst[index]),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Medinfo(
                            fruitDataModel: Fruitdata[index],
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
  final FruitDataModel fruitDataModel;

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
                          fontWeight: FontWeight.bold, fontSize: 50),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      fruitDataModel.serving,
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
                    fruitDataModel.desc,
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
                          _buildPopupDialog2(context),
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
                          _buildPopupDialog3(context),
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
      children: const <Widget>[
        SizedBox(
          width: 700,
        ),
        Text("Medicine name"),
        TextField(
          decoration: InputDecoration(
            hintText: "Name",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Serving size"),
        TextField(
          decoration: InputDecoration(
            hintText: "Size",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Taken time (if required)"),
        TextField(
          decoration: InputDecoration(
            hintText: "Time",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Additional Data"),
        TextField(
          decoration: InputDecoration(
            hintText: "Additional",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
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

Widget _buildPopupDialog2(BuildContext context) {
  return AlertDialog(
    title: const Text('Edit Medicine'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        SizedBox(
          width: 700,
        ),
        Text("Medicine name"),
        TextField(
          decoration: InputDecoration(
            hintText: "Name",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Serving size"),
        TextField(
          decoration: InputDecoration(
            hintText: "Size",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Taken time (if required)"),
        TextField(
          decoration: InputDecoration(
            hintText: "Time",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Additional Data"),
        TextField(
          decoration: InputDecoration(
            hintText: "Additional",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('EDIT'),
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

Widget _buildPopupDialog3(BuildContext context) {
  return AlertDialog(
    title: const Text('Delete Med data'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[

        Text("Are you sure you want to delete this medicine data?",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
      )
      ,
    ]
    ,
  );
}