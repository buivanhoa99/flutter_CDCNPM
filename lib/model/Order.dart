import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  int id;
  String idUser;
  int number;
  int total;
  String idProduct;
  String timeCreated;
  String status;

  Order(this.id, this.idUser, this.number, this.total, this.idProduct,
      this.timeCreated, this.status);

  void addOrder(){
    id = DateTime.now().millisecondsSinceEpoch;
    CollectionReference products = FirebaseFirestore.instance.collection('orders');
    products.doc('$id').set({
      'id': id,
      'idUser': idUser,
      'number': number,
      'total': total,
      'idProduct': idProduct,
      'timeCreated': timeCreated,
      'status': status
    }).then((value) => print("Add Order Success!!"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  void updateOrder(){
    CollectionReference products = FirebaseFirestore.instance.collection('orders');
    products.doc('$id').set({
      'idUser': idUser,
      'number': number,
      'total': total,
      'idProduct': idProduct,
      'timeCreated': timeCreated,
      'status': status
    }).then((value) => print("update Order Success!!"))
        .catchError((error) => print("Failed to update order: $error"));
  }

  void deleteOrder(){
    CollectionReference products = FirebaseFirestore.instance.collection('orders');
    products.doc('$id').delete().then((value) => print("update Order Success!!"))
        .catchError((error) => print("Failed to update order: $error"));
  }

  static Order getOrder(int id){
    FirebaseFirestore.instance
        .collection('orders')
        .doc('$id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var map = documentSnapshot.data();
        return Order(map['id'], map['idUser'], map['number'], map['total'], map['idProduct'], map['timeCreated'], map['status']);
      }else{
        return null;
      }
    });
  }
  static List<Order> getAllOrder(){
    List<Order> orders = [];
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((map) {
         orders.add(Order(map['id'], map['idUser'], map['number'], map['total'], map['idProduct'], map['timeCreated'], map['status']));
      });
      return orders;
    });
  }
}