import 'package:flutter/cupertino.dart';
import 'notify.dart' as notii;
import 'server.dart';
import 'med_data.dart' as mdata;



class currentacc {
  user current = user.fromJson({'ID':'000','username' :'nocurrent', 'password':'000', 'M_id':'000', 'F_id':'000'});
  user B = user.fromJson({'ID':'000','username' :'nocurrent', 'password':'000', 'M_id':'000', 'F_id':'000'});
List<med> notio = [];
  List<List<med>> Fnotio = [];
  List<String> friend =[];
  user getcurrent(){
    return current;
  }
  void addcurrent(user A){
    current = A;
  }
  void removecurrent(){
    current = B;
  }

  void noti(){
    if(notio.isNotEmpty){
      for(int i=0;i<notio.length;i++){
        times B;
        if(notio[i].time[1]==':'){
          B = times(notio[i].time[0], notio[i].time[notio[i].time.length-2]+notio[i].time[notio[i].time.length-1]);
        }
        else{
        B = times(notio[i].time[0]+notio[i].time[1], notio[i].time[notio[i].time.length-2]+notio[i].time[notio[i].time.length-1]);
        }

        notii.createWaterReminderNotification(B, notio[i].name);
      }
    }
    if(friend.isNotEmpty && friend.length==Fnotio.length){
      for(int i=0;i<friend.length;i++){
        for(int j=0;j<Fnotio[i].length;j++) {
          debugPrint(notio[i].time);
          times B = times(Fnotio[i][j].time[0]+Fnotio[i][j].time[1], Fnotio[i][j].time[Fnotio[i][j].time.length-2]+Fnotio[i][j].time[Fnotio[i][j].time.length-1]);
          notii.createWaterReminderNotification2(B, notio[i].name,friend[i]);
        }

      }
    }

    }
  void addnotio(List<med> AW,  List<List<med>> FAW,List<String> F){
    notio=AW;
    Fnotio=FAW;
    friend=F;
    notii.cancelScheduledNotifications();
    noti();
  }
  }

currentacc A = currentacc();

bool login(String u, String p, List<user> B){
  bool C = false ;
for(int i=0;i<B.length;i++){
  if(u==B[i].username && p==B[i].password){
    C= true;
    A.addcurrent(B[i]);
    break;

  }
}
  return C;
}

bool sign(String u, String p, List<user> B){
  bool C = false ;
  int W=0;
  for(int i=0;i<B.length;i++){
    if(u==B[i].username){
      break;
    }
    W++;
  }
  if(W==B.length){
    C=true;
  }
  return C;
}

List<String> getnamef(List<user> ff){
  List<String> AA=[];
  for(int i=0;i<ff.length;i++){
    AA.add(ff[i].username);
  }
  return AA;
}

List<List<med>> getallfmed(List<user> f, List<usermed> um, List<med> allmed){
  List<List<med>> AB=[];
  for(int i=0;i<f.length;i++){
    AB.add(getumed(allmed, um, f[i].mid));
  }
  return AB;
}

List<med> getumed(List<med> allmed, List<usermed> umed, String aidee){
  List<med> mymed= [med.fromJson({'ID':'CAT','Medicine Name' :'nocurrent', 'Time':'00:00', 'Consumption size':'0', 'Inventory':'0','Additional information':'A' })];
  for(int i =0;i<umed.length;i++){
    if(umed[i].id == aidee ){
      for(int j=0;j<allmed.length;j++){
        if(allmed[j].id == umed[i].mid){
          if(mymed[0].id=='CAT'){
            mymed[0]=allmed[j];
          }
          else{
            mymed.add(allmed[j]);
          }
        }
      }
    }
  }
  return mymed;
}

List<user> getfrindacc (List<friend> frr, List<user> allu){
  List<user> myf =[ user.fromJson({'ID':'CAT','username' :'nocurrent', 'password':'000', 'M_id':'000', 'F_id':'000'})];
  for(int i=0;i<frr.length;i++) {
    if (frr[i].add == 'T' && frr[i].id == A.current.fid&&frr[i].noti=='T') {
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