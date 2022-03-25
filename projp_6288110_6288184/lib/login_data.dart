import 'package:flutter/cupertino.dart';

import 'server.dart';

class currentacc {
  user current = user.fromJson({'ID':'000','username' :'nocurrent', 'password':'000', 'M_id':'000', 'F_id':'000'});
  user B = user.fromJson({'ID':'000','username' :'nocurrent', 'password':'000', 'M_id':'000', 'F_id':'000'});

  user getcurrent(){
    return current;
  }
  void addcurrent(user A){
    current = A;
  }
  void removecurrent(){
    current = B;
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
