import 'package:dio/dio.dart';
class server {
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8081/'));

  Future<List<user>> getall(String name) async {
    var url = '/getall/'+name;
    final response = await _dio.get(url);
    var A;
    if(name == 'user'){
      A = (response.data['contacts'] as List)
          .map<user>((json) => user.fromJson(json))
          .toList();
    }
    if(name == 'med'){
      A = (response.data['contacts'] as List)
          .map<med>((json) => med.fromJson(json))
          .toList();
    }
    if(name == 'med'){
      A = (response.data['contacts'] as List)
          .map<med>((json) => med.fromJson(json))
          .toList();
    }
    if(name == 'friend'){
      A = (response.data['contacts'] as List)
          .map<friend>((json) => friend.fromJson(json))
          .toList();
    }
    if(name == 'user-med'){
      A = (response.data['contacts'] as List)
          .map<usermed>((json) => usermed.fromJson(json))
          .toList();
    }
    return A;
  }

  Future<user> createContact(String name) async {
    final response = await _dio.post('', data: {'name': name});
    return user.fromJson(response.data);
  }

  Future deleteContact(String id) async {
    final response = await _dio.delete('/$id');
    return response.data;
  }
}

class user{
  final String id;
  final String username;
  final String password;
  final String mid;
  final String fid;

  const user._(this.id, this.username, this.password, this.mid, this.fid);

  factory user.fromJson(Map json) {
    final id = json['ID'];
    final username = json['username'];
    final password = json['password'];
    final mid = json['M_id'];
    final fid = json['F_id'];
    return user._(id, username, password, mid, fid);
  }
}

class med{
  final String id;
  final String name;
  final String time;
  final String size;
  final String intv;
  final String add;

  const med._(this.id, this.name, this.time, this.size, this.intv, this.add);

  factory med.fromJson(Map json) {
    final id = json['ID'];
    final name = json['username'];
    final time = json['password'];
    final size = json['M_id'];
    final intv = json['F_id'];
    var add = ' ';
    if(json['Additional information']!=null){
      add = json['Additional information'];
    }

    return med._(id, name, time, size, intv, add);
  }
}

class friend{
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

class usermed{
  final String id;
  final String mid;

  const usermed._(this.id, this.mid);

  factory usermed.fromJson(Map json) {
    final id = json['ID'];
    final mid = json['Med_ID'];

    return usermed._(id, mid);
  }
}