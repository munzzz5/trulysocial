import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trulysocial/services/cloud/cloud_storage_constants.dart';

class CloudUser {
  final String user;
  final GeoPoint? location;
  final List<String>? socialWorks;
  final int? socialPoints;

  CloudUser(this.user, this.location, this.socialWorks, this.socialPoints);
  CloudUser.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc)
      : user = doc.data()[firebaseUserIdField] as String,
        location = doc.data()[firebaseUserLocationField] as GeoPoint,
        socialWorks = doc.data()[firebaseUserSocialWorksField] as List<String>,
        socialPoints = doc.data()[firebaseUserSocialPointsField] as int;
}
