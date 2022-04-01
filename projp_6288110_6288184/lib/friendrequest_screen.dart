import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Friend_data.dart' as fdata;
import 'server.dart';
import 'login_data.dart' as udata;

class Friendreq extends StatefulWidget {
  Friendreq({Key? key}) : super(key: key);
  final server api = server();

  @override
  Friendreqs createState() => Friendreqs();
}

class Friendreqs extends State<Friendreq> {
  List<friend> allf = [];
  List<user> allu = [];

  @override
  void initState() {
    super.initState();
    _loadallmed();
    _loadusermed();
  }

  void _loadallmed() {
    widget.api.getall('friend').then((A) {
      setState(() {
        allf = A;
      });
    });
  }

  void _loadusermed() {
    widget.api.getall('user').then((A) {
      setState(() {
        allu = A;
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
          child: Column(
              children: (fdata.checkfre(allf))
                  ? [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Friend Request',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Listf(frr: fdata.getfrindreq(allf, allu)),
                      const SizedBox(
                        height: 10,
                      ),
                    ]
                  : [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Friend Request',
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
                          "You currently don't have any friend request."),
                      const SizedBox(
                        height: 10,
                      ),
                    ])),
    );
    //
  }
}

class Listf extends StatefulWidget {
  Listf({required this.frr, Key? key}) : super(key: key);
  final server api = server();
  final List<user> frr;

  @override
  Listfs createState() => Listfs();
}

class Listfs extends State<Listf> {
  deletereq(int index) async {
    await widget.api.fde(udata.A.current.fid, widget.frr[index].id);
    widget.frr.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Friend request declined.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    ));
    setState(() {});
  }

  addreq(int index) async {
    await widget.api.facc(udata.A.current.fid, widget.frr[index].id);
    widget.frr.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Friend request accepted.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: widget.frr.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  widget.frr[index].username,
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                subtitle: Text(widget.frr[index].id),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        addreq(index);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        deletereq(index);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
