import 'package:cloud_firestore/cloud_firestore.dart';

class ReadSaveDeleteUser {
  final Stream<QuerySnapshot> dataStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> SaveUser(id, login, name) {
    return users
        .doc('$id')
        .set({'login': login, 'name': name})
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add Message: $error"));
  }
}

class ReadSaveDeleteBasket {

  readShop(userId){
   return FirebaseFirestore.instance.collection('shops').doc(userId).collection('Купить').snapshots();
  }

  Future<void> saveShop(id, shop) {
    CollectionReference shops = FirebaseFirestore.instance.collection('shops').doc(id).collection('Купить');
    return shops
        .doc('$shop')
        .set({'name': shop})
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add Message: $error"));
  }

  Future<void> deleteShop(id,shop) {
    CollectionReference shops = FirebaseFirestore.instance.collection('shops').doc(id).collection('Купить');
    return shops.doc('$shop').delete();
  }

}

class ReadSaveDeleteBuy {

  readShop(userId){
    return FirebaseFirestore.instance.collection('shops').doc(userId).collection('Куплено').snapshots();
  }

  Future<void> saveShop(id, shop) {
    CollectionReference shops = FirebaseFirestore.instance.collection('shops').doc(id).collection('Куплено');
    return shops
        .doc('$shop')
        .set({'name': shop})
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add Message: $error"));
  }

  Future<void> deleteShop(id,shop) {
    CollectionReference shops = FirebaseFirestore.instance.collection('shops').doc(id).collection('Куплено');
    return shops.doc('$shop').delete();
  }
}
