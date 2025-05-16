
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
class TreatmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getTreatments() async {
     try {
      final treatments = await _firestore.collection('therapies').get();
    
      return treatments.docs.map((e) => e.data()).toList();
     } catch (e) {
      Logger().e(e);
      return [];
  }
}
Future<List<Map<String, dynamic>>> getFastingTreatments() async {
  try {
    final treatments = await _firestore.collection('fasting_therapies').get();
    return treatments.docs.map((e) => e.data()).toList();
  } catch (e) {
    Logger().e(e);
    return [];
  }
}
}