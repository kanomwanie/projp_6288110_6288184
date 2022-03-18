// @dart=2.9
import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void start() async {
  // Log into database
  final db = await Db.create(
      'mongodb+srv://kanomwan:Kanomwan_876536@cluster0.bqksu.mongodb.net/DM?retryWrites=true&w=majority');
  await db.open();

  // Create serverp
  const port = 8081;
  final serv = Sevr();
getname(String name){
  return(db.collection(name));
}
  final corsPaths = ['/getall/:id', '/addmed', '/take/:id', '/sign', '/fadd', '/fnoti', '/medup/:id', '/facc', '/deletemed/:id', '/deletef/:id'];
  for (var route in corsPaths) {
    serv.options(route, [
          (req, res) {
        setCors(req, res);
        return res.status(200);
      }
    ]);
  }

  serv.get('/getall/:id', [

    setCors,
        (ServRequest req, ServResponse res) async {
          var coll = getname(req.params['id']);
      final contacts = await coll.find().toList();
          final size = await contacts.length;
          print(contacts);
      return res.status(200).json({'data': contacts, 'size': size});
    }
  ]);

  serv.post('/addmed/:id', [
    setCors,
        (ServRequest req, ServResponse res) async {
          var coll = getname('med');
          var um = getname('user-med');
      await coll.insertOne(req.body[0]);
          await um.insertOne({'ID': req.params['id'], 'Med_ID': req.body[0].id});
      return res.status(200).json({'data': 'Medicine added'});
    }
  ]);
  serv.post('/sign', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('user');
      await coll.insertOne(req.body[0]);
      return res.status(200).json({'data': 'Signup successful'});
    }
  ]);
  serv.post('/fadd', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('friend');
      await coll.insertOne(req.body[0]);
      return res.status(200).json({'data': 'Friend requested'});
    }
  ]);
  serv.post('/fnoti', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('friend');
      var v1 = await coll.findOne({"ID": req.body[0].id,'F_ID': req.body[0].fid});
      if(v1["Noti"] =='T'){
        v1["Noti"] = 'F';
      }
      if(v1["Noti"] =='F'){
        v1["Noti"] = 'T';
      }
      await coll.save(v1);
      return res.status(200).json({'data': 'Notification updated'});
    }
  ]);
  serv.post('/take/:id', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('med');
      var v1 = await coll.findOne({"ID": req.params['id']});
      v1["Inventory"] = v1['Inventory']-v1['size'];
      await coll.save(v1);
      return res.status(200).json({'data': 'Notification updated'});
    }
  ]);
  serv.post('/medup/:id', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('med');
      var v1 = await coll.findOne({"ID": req.params['id']});
      v1["ID"] = req.body[0].id;
      v1["Medicine Name"] = req.body[0].name;
      v1["Time"] = req.body[0].time;
      v1["Consumption size"] = req.body[0].size;
      v1["Inventory"] = req.body[0].intv;
      if(req.body[0].add != null){
        v1["Additional information"] = req.body[0].add;
      }
      await coll.save(v1);
      return res.status(200).json({'data': 'Medicine updated'});
    }
  ]);
  serv.post('/facc', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('friend');
      var v1 = await coll.findOne({"ID": req.body[0].id,'F_ID': req.body[0].fid});
      v1["Added"] = 'T';
      await coll.save(v1);
      return res.status(200).json({'data': 'Friend request accepted'});
    }
  ]);
  serv.delete('/deletemed', [
    setCors,
        (ServRequest req, ServResponse res) async {
          var coll = getname('med');
          var um = getname('user-med');
          var v1 = await coll.findOne({"ID": req.body[0].mid});
          var v2 = await um.findOne({'ID': req.body[0].id, 'Med_ID':req.body[0].mid});
      await coll.remove(v1);
          await um.remove(v2);
      return res.status(200);
    }
  ]);
  serv.delete('/deletef', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('friend');
      var v1 = await coll.findOne({'ID': req.body[0].id, 'F_ID':req.body[0].fid});
      await coll.remove(v1);
      return res.status(200);
    }
  ]);
  // Listen for connections
  serv.listen(port, callback: () {
    print('Server listening on port: $port');
  });
}


void setCors(ServRequest req, ServResponse res) {
  res.response.headers.add('Access-Control-Allow-Origin', '*');
  res.response.headers.add('Access-Control-Allow-Methods', 'GET, POST, DELETE');
  res.response.headers
      .add('Access-Control-Allow-Headers', 'Origin, Content-Type');
}