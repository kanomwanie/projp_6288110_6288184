import 'package:flutter/cupertino.dart';

import 'server.dart';
import 'login_data.dart' as udata;

List<DateTime> Dweekly(DateTime current){
  List<DateTime> AB =[];
 for(int i=1;i<=7;i++){
   if(i< current.weekday){
AB.add(current.add(Duration(days: -(current.weekday-i))));
   }
   else if(i == current.weekday){
     AB.add(current);
   }
   else if(i>current.weekday){
     AB.add(current.add(Duration(days: (i-current.weekday))));
   }
 }
  return AB;
}

List <List<DateTime>> Dmonthly(DateTime current){
  List <List<DateTime>> AB =[];
  List<DateTime> M=[];
  DateTime W = DateTime.parse(current.year.toString()+'-0'+ current.month.toString() +"-01" );
  for(int i=0;i<31;i++){
    if(W.add(Duration(days: i)).month == W.month){

     M.add(W.add(Duration(days: i)));
      if(W.add(Duration(days: i)).weekday == 6){
       AB.add(M);
       M=[];
      }
    }


  }

  return AB;
}
List <List<DateTime>> Dyearly(DateTime current){
  List <List<DateTime>> AB =[];
  List<DateTime> M=[];
  DateTime W = DateTime.parse(current.year.toString()+'-01-01');
  for(int i=0;i<366;i++){
    if(W.add(Duration(days: i)).year == W.year){

      M.add(W.add(Duration(days: i)));
      if(W.add(Duration(days: i+1)).month != W.add(Duration(days: i)).month){
        AB.add(M);
        M=[];
      }
    }


  }

  return AB;
}

List<String> Checktake(List<DateTime> date, List<stat> statall, String mid){
  String E = 'N';
  int M = 0;
  String V = '';
  List<DateTime> P=[];
  List<String> U=[];
  for(int i=0;i<date.length;i++){
    bool B = true;
    for(int j=0;j<statall.length;j++){
      if(statall[j].date.day == date[i].day && statall[j].date.month == date[i].month && statall[j].date.year == date[i].year && statall[j].mid == mid && statall[j].id == udata.A.current.id){
        E='S';
B=false;
      }
    }
    if(B){
      M++;
      P.add(date[i]);
    }
  }
  if(M==0){
    E='Y';
  }
  else if(E=='S'){
    for(int i=0;i<P.length;i++){
      V = V + P[i].day.toString()+' '+ getmonth(P[i].month) + ' '+ P[i].year.toString()+"\n";
    }
  }
  U.add(E);
  U.add(V);
  return U;
}

bool checktakew(DateTime W, List<stat> statall, String mid){
  bool O = false;
  for(int i=0;i<statall.length;i++){
    if(statall[i].date.day == W.day && statall[i].date.month == W.month && statall[i].date.year == W.year && statall[i].mid==mid&& statall[i].id == udata.A.current.id){
      O=true;
      break;
    }
  }
  return O;
}

String getmonth(int M){
  String R='';
  if(M==1){
    R='January';
  }
  else if(M==2){
    R='February';
  }
  else if(M==3){
    R='March';
  }
  else if(M==4){
    R='April';
  }
  else if(M==5){
    R='May';
  }
  else if(M==6){
    R='June';
  }
  else if(M==7){
    R='July';
  }
  else if(M==8){
    R='August';
  }
  else if(M==9){
    R='September';
  }
  else if(M==10){
    R='October';
  }
  else if(M==11){
    R='November';
  }
  else if(M==12){
    R='December';
  }

  return R;
}

String printmonth(List<DateTime> WW){
  String result = WW[0].day.toString()+ ' ' + getmonth(WW[0].month) + ' '+WW[0].year.toString();
  if(WW.length>1){
    result = WW[0].day.toString()+ ' to ' + WW[WW.length-1].day.toString() + " " + getmonth(WW[0].month) + ' '+WW[0].year.toString();
  }
  return result;
}

List<String> getweeklist(int B){
  List<String> A=[];
  for(int i=1;i<B+1;i++){
    A.add('Week '+ i.toString());
  }
  return A;
}