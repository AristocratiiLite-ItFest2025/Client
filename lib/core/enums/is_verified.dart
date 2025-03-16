// ignore_for_file: constant_identifier_names

enum IsVerified { NGO, SPONSOR, PERSON }

extension UserTypeExtension on IsVerified {
  String get value {
    switch (this) {
      case IsVerified.NGO:
        return 'NGO';
      case IsVerified.SPONSOR:
        return 'SPONSOR';
      case IsVerified.PERSON:
        return 'PERSON';
    }
  }

  static IsVerified fromString(String value) {
    switch (value) {
      case 'NGO':
        return IsVerified.NGO;
      case 'SPONSOR':
        return IsVerified.SPONSOR;
      case 'PERSON':
        return IsVerified.PERSON;
      default:
        throw ArgumentError('Invalid user type: $value');
    }
  }
}

