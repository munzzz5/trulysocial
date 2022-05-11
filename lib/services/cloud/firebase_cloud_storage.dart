import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

import 'package:trulysocial/services/cloud/cloud_exceptions.dart';
import 'package:trulysocial/services/cloud/cloud_social_work.dart';
import 'package:trulysocial/services/cloud/cloud_storage_constants.dart';
import 'package:trulysocial/services/cloud/cloud_user.dart';

class FirebaseCloudStorage {
  final socialWorks =
      FirebaseFirestore.instance.collection(firebaseSocialWorkCollection);
  final socialUser =
      FirebaseFirestore.instance.collection(firebaseSocialUserCollection);

  //Stream for all Social works to show user
  Stream<Iterable<SocialWork>> allSocialWorks() => socialWorks
      .snapshots()
      .map((event) => event.docs.map((doc) => SocialWork.fromSnapshot(doc)));

  //Singleton instance
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;

  //SOCIAL WORK CRUD OPERATIONS
  Future<SocialWork> createSocialWork({
    required String title,
    required String description,
    required List<String> workers,
    required String owner,
    required GeoPoint location,
    required DateTime createdAt,
  }) async {
    final socialDocument = await socialWorks.add({
      firebaseSocialWorkTitleField: title,
      firebaseSocialWorkDescriptionField: description,
      firebaseSocialWorkWorkersField: workers,
      firebaseSocialWorkOwnerField: owner,
      firebaseSocialWorkCreatedAtField: createdAt,
      firebaseSocialWorkLocationField: location,
    });
    final fetchedSocialWork = await socialDocument.get();
    return SocialWork(
      id: fetchedSocialWork.id,
      title: fetchedSocialWork.data()![firebaseSocialWorkTitleField],
      description:
          fetchedSocialWork.data()![firebaseSocialWorkDescriptionField],
      workers: fetchedSocialWork.data()![firebaseSocialWorkWorkersField],
      owner: fetchedSocialWork.data()![firebaseSocialWorkOwnerField],
      createdAt: fetchedSocialWork.data()![firebaseSocialWorkCreatedAtField],
      location: fetchedSocialWork.data()![firebaseSocialWorkLocationField],
    );
  }

  Future<Iterable<SocialWork>> getSocialWorks() async {
    try {
      return await socialWorks.get().then((allSocialWorks) => allSocialWorks
          .docs
          .map((currSocialWork) => SocialWork.fromSnapshot(currSocialWork)));
    } catch (e) {
      throw CouldNotGetAllSocialWorkException();
      // print(e);
    }
  }

  Future<void> updateSocialWork({required SocialWork socialWork}) async {
    try {
      await socialWorks.doc(socialWork.id).update(socialWork.toMap());
    } catch (e) {
      throw CouldNotUpdateSocialWorkException();
    }
  }

  Future<void> deleteSocialWork({required String socialWorkId}) async {
    try {
      await socialWorks.doc(socialWorkId).delete();
    } catch (e) {
      throw CouldNotDeleteSocialWorkException();
    }
  }

  Future<CloudUser> createUserFirstTime({required String ownerId}) async {
    try {
      final addedUser = await socialUser.add({
        firebaseUserIdField: ownerId,
        firebaseUserSocialPointsField: 0,
        firebaseUserSocialWorksField: [],
        firebaseUserLocationField: await Location.instance.getLocation().then(
            (location) => GeoPoint(location.latitude!, location.longitude!)),
      });
      final fetchedUser = await addedUser.get();
      return CloudUser(
          fetchedUser.data()![firebaseUserIdField],
          fetchedUser.data()![firebaseUserLocationField],
          fetchedUser.data()![firebaseUserSocialWorksField],
          fetchedUser.data()![firebaseUserSocialPointsField]);
    } catch (e) {
      throw CouldNotCreateCloudUserException();
    }
  }

  Future<CloudUser> getUser({required String ownerUserId}) async {
    try {
      final fetchedUser = await socialUser
          .where(firebaseUserIdField, isEqualTo: ownerUserId)
          .get()
          .then(
            (value) => value.docs.map(
              (doc) => CloudUser.fromSnapshot(doc),
            ),
          );
      return fetchedUser.first;
    } catch (e) {
      throw CouldNotGetCloudUserException();
    }
  }
}
