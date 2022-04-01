import 'package:flutter/cupertino.dart';

import 'server.dart';
import 'login_data.dart' as udata;

bool checkf(List<friend> f){
  bool isempty = false;
  var aidee = udata.A.current.fid;
  for(int i=0;i<f.length;i++){
    if(aidee == f[i].id && f[i].add=='T'){
      isempty = true;
      break;
    }
  }
  return isempty;
}

List<friend> getfriend(List<friend> fri){
  List<friend> myfriend = [friend.fromJson({'ID':'CAT', 'F_ID':'000','Added':'A','Noti':'A'}),];
  var aidee = udata.A.current.fid;
  for(int i=0;i<fri.length;i++){
    if(aidee == fri[i].id){
     if(myfriend[0].id=='CAT'){
       myfriend[0] = fri[i];
     }
     else{
       myfriend.add(fri[i]);
     }
    }
  }
  return myfriend;
}

List<user> getfrindacc (List<friend> frr, List<user> allu){
  List<user> myf =[ user.fromJson({'ID':'CAT','username' :'nocurrent', 'password':'000', 'M_id':'000', 'F_id':'000'})];
  for(int i=0;i<frr.length;i++) {
    if (frr[i].add == 'T' && frr[i].id == udata.A.current.fid) {
      for (int j = 0; j < allu.length; j++) {
        if (frr[i].fid == allu[j].id) {
          if (myf[0].id == 'CAT') {
            myf[0] = allu[j];
          }
          else {
            myf.add(allu[j]);
          }
        }
      }
    }
  }
  return myf;
}

List<user> getfrindreq (List<friend> frr, List<user> allu){
  List<user> myf =[ user.fromJson({'ID':'CAT','username' :'nocurrent', 'password':'000', 'M_id':'000', 'F_id':'000'})];
  for(int i=0;i<frr.length;i++) {
    if (frr[i].add == 'F' && frr[i].id == udata.A.current.fid) {
      for (int j = 0; j < allu.length; j++) {
        if (frr[i].fid == allu[j].id) {
          if (myf[0].id == 'CAT') {
            myf[0] = allu[j];
          }
          else {
            myf.add(allu[j]);
          }
        }
      }
    }
  }
  return myf;
}

bool checkfre(List<friend> f){
  bool isempty = false;
  var aidee = udata.A.current.fid;
  for(int i=0;i<f.length;i++){
    if(aidee == f[i].id && f[i].add =='F'){
      isempty = true;
      break;
    }
  }
  return isempty;
}
String getnoti(String id, List<friend> fr){
  String notii = 'F';
  for(int i=0;i<fr.length;i++){
    if(id == fr[i].fid && udata.A.current.fid == fr[i].id){
      notii = fr[i].noti;
      break;
    }
  }

  return notii;
}

String checksned(List<friend> fr, String fid){
  String H = 'A';
  var Q = 'F'+fid;
  for(int i=0;i<fr.length;i++){
    if(fid == fr[i].fid && udata.A.current.fid == fr[i].id){
      if(fr[i].add == 'F'){
        H = 'B';
      }
      else if(fr[i].add == 'T'){
        H = 'C';
      }

      break;
    }
    if(udata.A.current.id == fr[i].fid && Q==fr[i].id){
      if(fr[i].add == 'F'){
        H = 'D';
      }
      else if(fr[i].add == 'T'){
        H = 'C';
      }

      break;
    }
  }

  return H;
}

bool checkuser (String id, List<user> u){
  bool tt = false;
  for(int i=0;i<u.length;i++){
    if(u[i].id==id){
      tt = true;
      break;
    }
  }
  return tt;
}
