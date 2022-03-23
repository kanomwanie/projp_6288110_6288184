import 'package:flutter/cupertino.dart';

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