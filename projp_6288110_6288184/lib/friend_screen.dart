import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Friend_data.dart' as fdata;
import 'server.dart';
import 'login_data.dart' as udata;
import 'friendrequest_screen.dart';

class Friend extends StatefulWidget {
  Friend({Key? key}) : super(key: key);
  final server api = server();

  @override
  Friends createState() => Friends();
}

class Friends extends State<Friend> {
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
    return Column(
        children: (fdata.checkf(allf))
            ? [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'You have ' +
                      fdata.getfriend(allf).length.toString() +
                      ' friends.',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.left,
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
                      height: 30, //height of button
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
                                _buildPopupDialog(context, udata.A.current.id),
                          );
                        },
                        child: const Text('User code',
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
                      height: 30, //height of button
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
                                _buildPopupDialog2(context),
                          );
                        },
                        child: const Text('Add New Friend',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Listf(
                  frr: fdata.getfrindacc(fdata.getfriend(allf), allu),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Friendreq()),
                );
              },
              child: const Text('Friend Request',
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
                  'You have 0 friends.',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.left,
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
                      height: 30, //height of button
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
                                _buildPopupDialog(context, udata.A.current.id),
                          );
                        },
                        child: const Text('User code',
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
                      height: 30, //height of button
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
                                _buildPopupDialog2(context),
                          );
                        },
                        child: const Text('Add New Friend',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("You currently don't have any friend."),
          const SizedBox(
            height: 461,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Friendreq()),
                );
              },
              child: const Text('Friend Request',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepPurple,
                  )),
            ),
          ),
              ]);

    //
  }
}

class Listf extends StatelessWidget {
  const Listf({required this.frr, Key? key}) : super(key: key);
  final List<user> frr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 480, //        <-- Use Expanded
          child: ListView.builder(
            itemCount: frr.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  frr[index].username,
                  style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                subtitle: Text(frr[index].id),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog4(context, frr[index].username),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog3(context, frr[index].username),
                        );
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

Widget _buildPopupDialog(BuildContext context, String userid) {
  return AlertDialog(
    title: const Text('Your user code is :'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children:  <Widget>[
        Text(userid,
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        const Text("Send this code to your friend to add friend."),
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

Widget _buildPopupDialog2(BuildContext context) {
  return AlertDialog(
    title: const Text('Add Friend'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        TextField(
          decoration: InputDecoration(
            hintText: "User Code",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Type in your friend's user code."),
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
        child: const Text('Close'),
      ),
    ],
  );
}

Widget _buildPopupDialog3(BuildContext context, String tuser) {
  return AlertDialog(
    title: const Text('Unfriend'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Are you sure you want to unfriend with "+ tuser + " ?",
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

Widget _buildPopupDialog4(BuildContext context, String tuser) {
  return AlertDialog(
    title: const Text('Receive Notification'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Do you want to receive "+ tuser +"'s medicine notification?",
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
