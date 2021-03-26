import 'package:cloud_firestore/cloud_firestore.dart';
class Product{
  int id;
  String name;
  int number;
  int price;

  Product(this.id, this.name, this.number, this.price);

  void addProduct(){
    id = DateTime.now().millisecondsSinceEpoch;
    CollectionReference products = FirebaseFirestore.instance.collection('products');
    products.doc('$id').set({
      'id': id,
      'number': number,
      'price': price
    }).then((value) => print("Add Product Success!!"))
        .catchError((error) => print("Failed to add product: $error"));
  }
  void updateProduct(){
    CollectionReference products = FirebaseFirestore.instance.collection('products');
    products.doc('$id').update({
      'number': number,
      'price': price
    }).then((value) => print("Update Product Success!!"))
        .catchError((error) => print("Failed to Update product: $error"));
  }
  void deleteProduct(){
    CollectionReference products = FirebaseFirestore.instance.collection('products');
    products.doc('$id').delete().then((value) => print("Update Product Success!!"))
        .catchError((error) => print("Failed to Update product: $error"));
  }

  static Product getProduct(int id){
    FirebaseFirestore.instance
        .collection('products')
        .doc('$id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var map = documentSnapshot.data();
        return Product(id, map['name'], map['number'], map['price']);
      }else{
        return null;
      }
    });
  }
  static List<Product> getAllProduct(){
    List<Product> products = [];
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((map) {
        products.add(Product(map['id'], map['name'], map['number'], map['price']));
      });
      return products;
    });
  }
}