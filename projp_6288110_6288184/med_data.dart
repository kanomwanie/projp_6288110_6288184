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

List<med> gettakemed(List<stat> allstat, List<med> mymed, String take){
  List<med>W =[];
  List<med>M =[];
  List<med>N =mymed;
  for(int i =0;i<allstat.length;i++){
    if(allstat[i].date.day == DateTime.now().day&&allstat[i].date.month == DateTime.now().month &&allstat[i].date.year == DateTime.now().year&&allstat[i].id == udata.A.current.id){
      for(int j=0;j<mymed.length;j++){
        if(allstat[i].mid == mymed[j].id&&checkinttake(mymed[j])){
          M.add(mymed[j]);
        }
      }
    }
  }
  for(int i=0;i<N.length;i++){
    for(int j=0;j<M.length;j++){
      if(M[j]==N[i]&&checkinttake(N[i])){
        N[i]=med.fromJson({'ID':'CAT','Medicine Name' :'nocurrent', 'Time':'00:00', 'Consumption size':'0', 'Inventory':'0','Additional information':'A' });
      }

    }
    if(!checkinttake(N[i])&& N[i].id!='CAT'){
      N[i]=med.fromJson({'ID':'CAT','Medicine Name' :'nocurrent', 'Time':'00:00', 'Consumption size':'0', 'Inventory':'0','Additional information':'A' });
    }
  }

  if(take=='Y'){
    W=M;
  }
  else if(take=='N'){
    W=removenull(N);
  }
  return W;
 }

 bool checkinttake(med my){
  bool take = false;
  if(int. parse(my.intv)>=int. parse(my.size)){
take = true;
  }
  return take;
 }
int intvchecknum(List<med> mymed){
  var result= 0;
  bool R = false;
  for(int i =0;i<mymed.length;i++){
    if(int.parse(mymed[i].intv)<6){
  result++;
    }
  }
  return result;
}

String gettdate(List<stat> allstat, String mymed){
  String W='';
  for(int i =0;i<allstat.length;i++){
    if(allstat[i].date.day == DateTime.now().day&&allstat[i].date.month == DateTime.now().month &&allstat[i].date.year == DateTime.now().year&&allstat[i].id == udata.A.current.id&&allstat[i].mid==mymed){
      W=allstat[i].dates;
      }
    }

  return W;
}
List<med> removenull(List<med> Q){
  List<med> O=Q;
  var count=0;
  var B=true;
  while(B){
    if(Q[count].id=='CAT'){
      O.removeAt(count);
    }
    else{
    count++;}
    var Y=0;
    for(int i=0;i<O.length;i++){
      if(O[i].id=='CAT'){
        Y++;
      }

    }
    if(Y==0){
      B=false;
    }
  }
  return O;
}