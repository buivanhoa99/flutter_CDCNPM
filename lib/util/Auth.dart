import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Auth{
  static bool signIn(String email, String password){
    FirebaseAuth.instance.signInWithEmailAndPassword(email:email, password: password).then((value)  {
      print("login success!");
      return true;
    }).catchError((onError){
      print("login failure"+onError.toString());
      return false;
    });
    return true;
  }
  static bool customerRegister(String email, String password, String fullName, String address, String phone){
    FirebaseAuth.instance.createUserWithEmailAndPassword(email:email, password: password).then((value) {
      //upload info customer
      var idUser = FirebaseAuth.instance.currentUser.uid;
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      users.doc(idUser).set({
        'id': idUser,
        'fullName': fullName,
        'address': address,
        'phone': phone
      }).then((value) => print("Add Customer Success!!"))
          .catchError((error) => print("Failed to add customer: $error"));

      return true;
    }).catchError((onError) {
      print("register failure"+onError.toString());
      return false;
    });
    return true;

  }
  static void signOut(){
    FirebaseAuth.instance.signOut();
  }

}
