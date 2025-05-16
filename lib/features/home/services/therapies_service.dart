
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
class TherapiesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getTherapies() async {
     try {
      final therapies = await _firestore.collection('therapies').get();
    
      return therapies.docs.map((e) => e.data()).toList();
     } catch (e) {
      Logger().e(e);
      return [];
  }
}
Future<List<Map<String, dynamic>>> getFastingTherapies() async {
  try {
    final therapies = await _firestore.collection('fasting_therapies').get();
    return therapies.docs.map((e) => e.data()).toList();
  } catch (e) {
    Logger().e(e);
    return [];
  }
}
}