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
  final corsPaths = ['/getall/:id', '/addmed', '/take/:id', '/sign', '/fadd', '/fnoti', '/medup/:id', '/facc', '/deletemed/:id', '/deletef/:id','/deletes'];
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
      return res.status(200).json({'data': contacts, 'size': size});
    }
  ]);

  serv.post('/addmed/:id', [
    setCors,
        (ServRequest req, ServResponse res) async {
          var coll = getname('med');
          var um = getname('usermed');
      await coll.insertOne(req.body);
          await um.insertOne({'ID': req.params['id'], 'Med_ID': req.body['ID']});
      return res.status(200).json({'data': 'Medicine added'});
    }
  ]);
  serv.post('/sign', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('user');
      var A = req.body['Username'];
      await coll.insertOne(req.body);
      var TT =  await coll.findOne(where.eq('ID', req.body['ID']));
      return res.json(TT);
    }
  ]);
  serv.post('/fadd', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('friend');
      await coll.insertOne(req.body);
      return res.status(200).json({'data': 'Friend requested'});
    }
  ]);
  serv.post('/fnoti', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('friend');
      var v1 = await coll.findOne({"ID": req.body['id'],'F_ID': req.body['fid']});
      if(v1["Noti"] =='T'){
        v1["Noti"] = 'F';
      }
      else if(v1["Noti"] =='F'){
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
      var coll2 = getname('stat');
      await coll2.insertOne(req.body);
      var v1 = await coll.findOne({"ID": req.params['id']});
      v1["Inventory"] = v1['Inventory']-v1['Consumption size'];
      await coll.save(v1);
      return res.status(200).json({'data': 'Taken'});
    }
  ]);
  serv.post('/medup/:id', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('med');
      var v1 = await coll.findOne({"ID": req.params['id']});
      v1['Medicine Name']= req.body['Medicine Name'];
      v1['Time']= req.body['Time'];
      v1['Consumption size']= req.body['Consumption size'];
      v1['Inventory']= req.body['Inventory'];
      v1['Additional information']= req.body['Additional information'];

      await coll.save(v1);
      return res.status(200).json(v1);
    }
  ]);
  serv.post('/facc', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('friend');
      var v1 = await coll.findOne({"ID": req.body['id'],'F_ID': req.body['fid']});
      v1["Added"] = 'T';
      await coll.save(v1);
      return res.status(200).json({'data': 'Friend request accepted'});
    }
  ]);
  serv.delete('/deletemed', [
    setCors,
        (ServRequest req, ServResponse res) async {
          var coll = getname('med');
          var um = getname('usermed');
          var v1 = await coll.findOne({"ID": req.body['mid']});
          var v2 = await um.findOne({'ID': req.body['id'], 'Med_ID':req.body['mid']});
      await coll.remove(v1);
          await um.remove(v2);
      return res.status(200);
    }
  ]);
  serv.delete('/deletef', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('friend');
      var v1 = await coll.findOne({'ID': req.body['id'],'F_ID': req.body['fid']});
      await coll.remove(v1);
      return res.status(200);
    }
  ]);
  serv.delete('/deletes', [
    setCors,
        (ServRequest req, ServResponse res) async {
      var coll = getname('stat');
      var coll2 = getname('med');
      var v2 = await coll2.findOne({"ID": req.body['mid']});
      v2["Inventory"] = v2['Inventory']+v2['Consumption size'];
      var v1 = await coll.findOne({'ID': req.body['id'],'Med_ID': req.body['mid'],'Date-Time':req.body['date']});
 await coll.remove(v1);
await coll2.save(v2);
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