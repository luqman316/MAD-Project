// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class GetUserDataController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<QueryDocumentSnapshot<Object?>>> getUserData(String uId) async {
//     final QuerySnapshot userData =
//         await _firestore.collection('users').where('uId', isEqualTo: uId).get();
//     return userData.docs;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData(String uId) async {
    final DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uId).get();
    return userDoc;
  }
}
