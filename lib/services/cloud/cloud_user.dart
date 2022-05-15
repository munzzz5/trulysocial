import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trulysocial/services/cloud/cloud_storage_constants.dart';

import '../auth/auth_user.dart';

class CloudUser {
  final String id;
  final GeoPoint? location;
  final List<String>? socialWorks;
  final int? socialPoints;

  CloudUser(this.id, this.location, this.socialWorks, this.socialPoints);
  CloudUser.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()[firebaseUserIdField] as String,
        location = doc.data()[firebaseUserLocationField] as GeoPoint,
        socialWorks = doc.data()[firebaseUserSocialWorksField] as List<String>,
        socialPoints = doc.data()[firebaseUserSocialPointsField] as int;

  Map<String, Object?> toMap() {
    return {
      firebaseUserIdField: id,
      firebaseUserLocationField: location,
      firebaseUserSocialPointsField: socialPoints,
      firebaseUserSocialWorksField: socialWorks,
    };
  }
}
