import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GetUserDataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData(String uId) async {
    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uId).get();
      return userDoc;
    } on FirebaseException catch (e) {
      // Error ko log ya handle karein
      print('Firestore error: ${e.message}');
      rethrow; // Caller ko error handle karne dein
    } catch (e) {
      print('Unknown error: $e');
      rethrow;
    }
  }
}
