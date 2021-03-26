import 'package:cloud_firestore/cloud_firestore.dart';

class Customer{
  String id;
  String fullName;
  String address;
  String phone;

  Customer(this.id, this.fullName, this.address, this.phone);

  Customer getCustomer(String id){
    FirebaseFirestore.instance
        .collection('users')
        .doc('$id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var map = documentSnapshot.data();
        return Customer(id, map['fullName'], map['address'], map['phone']);
      }else{
        return null;
      }
    });
  }
}