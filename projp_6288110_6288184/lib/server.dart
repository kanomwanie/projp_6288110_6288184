import 'package:dio/dio.dart';

class server {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8081/'));
//get all data
  Future getall(String name) async {
    var url = '/getall/' + name;
    final response = await _dio.get(url);
    var A;
    if (name == 'user') {
      A = (response.data['data'] as List).map<user>((json) => user.fromJson(json)).toList();
    }
    if (name == 'med') {
      A = (response.data['data'] as List).map<med>((json) => med.fromJson(json)).toList();
    }
    if (name == 'friend') {
      A = (response.data['data'] as List).map<friend>((json) => friend.fromJson(json)).toList();
    }
    if (name == 'user-med') {
      A = (response.data['data'] as List).map<usermed>((json) => usermed.fromJson(json)).toList();
    }
    return A;
  }
// register
  Future sign(String user, String pass) async {
    final size = await _dio.post('/getall/user');
    final A = int.parse(size.data['size'])+1;
    var B;
    if (A.toString().length == 1) {
      B ='000'+A.toString();
    }
    if (A.toString().length == 2) {
      B ='00'+A.toString();
    }
    if (A.toString().length == 3) {
      B ='00'+A.toString();
    }
    if (A.toString().length > 3) {
      B = A.toString();
    }
    final response = await _dio.post('/sign', data: {'ID': B, 'Username': user, 'Password': pass, 'M_id':'M'+B,'F_ID': 'F'+B});
    return response.data['data'];
  }
// add med
  Future madd(String ID, String name, String time,int hour, int min, int sizes, int intv, String add) async {
    final size = await _dio.post('/getall/med');
    final A = int.parse(size.data['size'])+1;
    final times T = times._(hour,min);
    var B;
    if (A.toString().length == 1) {
      B ='000'+A.toString();
    }
    if (A.toString().length == 2) {
      B ='00'+A.toString();
    }
    if (A.toString().length == 3) {
      B ='00'+A.toString();
    }
    if (A.toString().length > 3) {
      B = A.toString();
    }
    final response = await _dio.post('/addmed/'+ID, data: {'ID': B, 'Medicine Name': name, 'Time': T.gettime(), 'Consumption size':sizes,'Inventory': intv, 'Additional information': add});
    return response.data['data'];
  }
//request friend
  Future fre(String id, String fid) async {
    final response = await _dio.post('/fadd', data: {'ID': id, 'F_ID': fid, 'Added': 'F', 'Noti':'F'});
    return response.data['data'];
  }
//recieve noti
  Future fnoti(String id, String fid) async {
    final response = await _dio.post('/fnoti', data: {'id': id, 'fid': fid});
    return response.data['data'];
  }
  //med taken
  Future mtake(String id) async {
    final response = await _dio.post('/take/'+id);
    return response.data['data'];
  }
  //med update
  Future mup(String ID, String name, String time,int hour, int min, int sizes, int intv, String add) async {
    final times T = times._(hour,min);
    final response = await _dio.post('/medup/'+ID, data: {'ID': ID, 'Medicine Name': name, 'Time': T.gettime(), 'Consumption size':sizes,'Inventory': intv, 'Additional information': add});
    return response.data['data'];
  }
  // friend accept
  Future facc(String id, String fid) async {
    final response = await _dio.post('/facc', data: {'id': id, 'fid': fid});
    return response.data['data'];
  }
  //delete med
  Future mde(String id,String mid) async {
    final response = await _dio.delete('/deletemed', data: {'id': id, 'mid': mid});
    return response.data;
  }
  //delete friend
  Future fde(String id,String fid) async {
    final response = await _dio.delete('/deletef', data: {'id': id, 'fid': fid});
    return response.data;
  }
}

class user {
  final String id;
  final String username;
  final String password;
  final String mid;
  final String fid;

  const user._(this.id, this.username, this.password, this.mid, this.fid);

  factory user.fromJson(Map json) {
    final id = json['ID'];
    final username = json['Username'].toString();
    final password = json['Password'].toString();
    final mid = json['M_id'];
    final fid = json['F_id'];
    return user._(id, username, password, mid, fid);
  }
}

class med {
  final String id;
  final String name;
  final String time;
  final String size;
  final String intv;
  final String add;

  const med._(this.id, this.name, this.time, this.size, this.intv, this.add);

  factory med.fromJson(Map json) {
    final id = json['ID'];
    final name = json['Medicine Name'];
    final time = json['Time'];
    final size = json['Consumption size'];
    final intv = json['Inventory'];
    var add = ' ';
    if (json['Additional information'] != null) {
      add = json['Additional information'];
    }

    return med._(id, name, time, size, intv, add);
  }
}

class friend {
  final String id;
  final String fid;
  final String add;
  final String noti;

  const friend._(this.id, this.fid, this.add, this.noti);

  factory friend.fromJson(Map json) {
    final id = json['ID'];
    final fid = json['F_ID'];
    final add = json['Added'];
    final noti = json['Noti'];

    return friend._(id, fid, add, noti);
  }
}

class usermed {
  final String id;
  final String mid;

  const usermed._(this.id, this.mid);

  factory usermed.fromJson(Map json) {
    final id = json['ID'];
    final mid = json['Med_ID'];

    return usermed._(id, mid);
  }
}

class times {
  final int h;
  final int m;

  const times._(this.h, this.m);
String gettime (){
  var a = h.toString();
  var b = m.toString();
  if(h<10){
   a= '0'+h.toString();
  }
  if(m<10){
     b= '0'+m.toString();
  }
  return a+":"+b;
}
}
