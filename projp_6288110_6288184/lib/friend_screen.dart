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


  void reload() {
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

  refresh() {
    setState(() {});
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
                                _buildPopupDialog2(context, allf, allu),
                          ).then((val) {
                            setState(() { });
                          });
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
                  fl: allf,
                  notifyParent: reload,
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
                      ).then((_) {
                        // This block runs when you have returned back to the 1st Page from 2nd.
                        reload();
                      });
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
                                _buildPopupDialog2(context, allf,  allu),
                          ).then((val) {
                            setState(() { });
                          });
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
                      ).then((_) {
                        // This block runs when you have returned back to the 1st Page from 2nd.
                        setState(() {
                          // Call setState to refresh the page.
                        });
                      });
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

class Listf extends StatefulWidget {
  const Listf(
      {required this.frr,
      required this.fl,
      required this.notifyParent,
      Key? key})
      : super(key: key);
  final List<user> frr;
  final List<friend> fl;
  final Function() notifyParent;

  @override
  Listfs createState() => Listfs();
}

class Listfs extends State<Listf> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 480, //        <-- Use Expanded
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
                      icon: (fdata.getnoti(widget.frr[index].id, widget.fl) ==
                              'T')
                          ? const Icon(Icons.notifications_active)
                          : const Icon(Icons.notifications),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog4(
                                    context,
                                    widget.frr[index].username,
                                    fdata.getnoti(
                                        widget.frr[index].id, widget.fl),
                                    widget.frr[index].id)).then((val) {
                          widget.notifyParent();
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog3(context, widget.frr[index]),
                        ).then((val) {
                          widget.notifyParent();
                        });
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
      children: <Widget>[
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


_buildPopupDialog2(BuildContext context, List<friend> f,List<user> u){
  final server api = server();
  final usercontrol = TextEditingController();
  bool w = false;
  String WW = '';
  renotiii() async {
    await api.fre(udata.A.current.id, usercontrol.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Friend request sent.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    ));
    Navigator.of(context).pop();
  }

  return StatefulBuilder(builder: (context, setState)
  {
    return AlertDialog(
      title: const Text('Add Friend'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: usercontrol,
            decoration: const InputDecoration(
              hintText: "User Code",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            child: Text(
              WW,
              style:
              const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            visible: w,
          ),
          const Text("Type in your friend's user code."),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (usercontrol.text != '') {
              if (fdata.checkuser(usercontrol.text, u)) {
                if (fdata.checksned(f, usercontrol.text) == 'A') {
                  // case add to data
                  renotiii();
                } else if (fdata.checksned(f, usercontrol.text) == 'D') {
                  // case request sent
                  setState(() {
                    WW='You already send request to this user.';
                    w=true;});
                } else if (fdata.checksned(f, usercontrol.text) == 'C') {
                  // case added
                  setState(() {
                    WW='You already be friend with this user.';
                    w=true;});

                } else if (fdata.checksned(f, usercontrol.text) == 'B') {
                  // case added
                  setState(() {
                    WW='Your friend have sent friend request to you. Please check "Fried Request".';
                    w=true;});

                }
              } else {
                setState(() {
                  WW="This user doesn't exist.";
                  w=true;});
              }
            }

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
  });
}

Widget _buildPopupDialog3(BuildContext context, user tuser) {
  final server api = server();
  renotiii() async {
    await api.fde(udata.A.current.fid, tuser.id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        'Unfriended.',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
    ));
    Navigator.of(context).pop();
  }

  return AlertDialog(
    title: const Text('Unfriend'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("Are you sure you want to unfriend with " + tuser.username + " ?",
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

Widget _buildPopupDialog4(
  BuildContext context,
  String tuser,
  String notii,
  String ID,
) {
  final server api = server();
  renoti() async {
    await api.fnoti(udata.A.current.fid, ID);
    if (notii == 'F') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Notification on.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ));
    } else if (notii == 'T') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Notification off.",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ));
    }
    Navigator.of(context).pop();
  }

  return AlertDialog(
    title: const Text('Receive Notification'),
    content: Column(
        mainAxisSize: MainAxisSize.min,
        children: (notii == 'T')
            ? [
                Text(
                    "Do you want to receive " +
                        tuser +
                        "'s medicine notification?",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ]
            : [
                Text(
                    "Do you want to stop receiving " +
                        tuser +
                        "'s medicine notification?",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ]),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          renoti();
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
