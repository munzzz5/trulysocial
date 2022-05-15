class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCreateSocialWorkException extends CloudStorageException {}

class CouldNotGetAllSocialWorkException extends CloudStorageException {}

class CouldNotGetFromIdSocialWorkException extends CloudStorageException {}

class CouldNotUpdateSocialWorkException extends CloudStorageException {}

class CouldNotDeleteSocialWorkException extends CloudStorageException {}

class CouldNotCreateCloudUserException extends CloudStorageException {}

class CouldNotUpdateCloudUserException extends CloudStorageException {}

class CouldNotGetCloudUserException extends CloudStorageException {}
