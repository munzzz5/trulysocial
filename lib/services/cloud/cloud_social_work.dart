import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trulysocial/services/cloud/cloud_storage_constants.dart';

class SocialWork {
  final String id;
  final String title;
  final String description;
  final List<String> workers;
  final String owner;
  final DateTime createdAt;
  final GeoPoint location;

  SocialWork({
    required this.id,
    required this.title,
    required this.description,
    required this.workers,
    required this.owner,
    required this.createdAt,
    required this.location,
  });

  SocialWork.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()[firebaseSocialWorkTitleField] as String,
        description = doc.data()[firebaseSocialWorkDescriptionField] as String,
        workers = doc.data()[firebaseSocialWorkWorkersField] as List<String>,
        owner = doc.data()[firebaseSocialWorkOwnerField] as String,
        createdAt = doc.data()[firebaseSocialWorkCreatedAtField] as DateTime,
        location = doc.data()[firebaseSocialWorkLocationField] as GeoPoint;

  Map<String, Object?> toMap() {
    return {
      firebaseSocialWorkIdField: id,
      firebaseSocialWorkTitleField: title,
      firebaseSocialWorkDescriptionField: description,
      firebaseSocialWorkWorkersField: workers,
      firebaseSocialWorkOwnerField: owner,
      firebaseSocialWorkCreatedAtField: createdAt,
      firebaseSocialWorkLocationField: location,
    };
  }
}
