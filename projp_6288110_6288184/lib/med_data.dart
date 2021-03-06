import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'server.dart';
import 'login_data.dart' as udata;

bool checkm(List<med> allmed, List<usermed> umed){
  bool isempty = false;
  var aidee = udata.A.getcurrent().mid;
  for(int i =0;i<umed.length;i++){
    if(umed[i].id == aidee ){
      for(int j=0;j<allmed.length;j++){
        if(allmed[j].id == umed[i].mid){
          isempty = true;
          break;
        }
      }
    }
    if(isempty){
      break;
    }
  }
  return isempty;
}

List<med> getumed(List<med> allmed, List<usermed> umed){
  List<med> mymed= [med.fromJson({'ID':'CAT','Medicine Name' :'nocurrent', 'Time':'00:00', 'Consumption size':'0', 'Inventory':'0','Additional information':'A' })];
   var aidee = udata.A.getcurrent().mid;
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

String shortentext(String txt){
  String wow = txt;
  if(wow.length >20){
    wow = txt.substring(0,20) + '...';
  }
  return wow;
}
String sizeandintv(String size, String intv, String time){
 return 'Size: '+ size + '   Inventory: '+ intv + '   Time: ' + time;

}

String intvcheck(List<med> mymed){
  var result= "You currently have enough medicine.";
  var temp = 'You should restock the following medicine: ';
  bool R = false;
  for(int i =0;i<mymed.length;i++){
    if(int.parse(mymed[i].intv)<6){
temp = temp + '\n - ' + mymed[i].name + ' ( '+ mymed[i].intv + ' pills left )';
R=true;
    }
  }
  if(R){
    result=temp;
  }
  return result;
}

bool checkinput(String name, String size, String intv){
bool result = true;
  if(name == ''){
   result = false;
  }
  if(size == ''){
    result = false;
  }
  if(intv == ''){
    result = false;
  }
  return result;
}
bool checktime(String time, String type){
  bool r = false;
  if(double.tryParse(time)!=null){
    if(type == 'h'){
      if(int.parse(time)<24){
        r=true;
      }
    }
   else if(type == 'm'){
      if(int.parse(time)<60){
        r=true;
      }
    }
  }
  else if(time == ''){
    r=true;
  }
  return r;
}
bool checknum(String num){
  bool nn = false;
  if(double.tryParse(num)!=null || num == ''){
    nn=true;
  }
  return nn;
}