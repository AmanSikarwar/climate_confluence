import 'package:climate_confluence/common/data/models/failures.dart';
import 'package:climate_confluence/common/data/models/value_objects.dart';
import 'package:climate_confluence/common/data/models/value_validators.dart';
import 'package:fpdart/fpdart.dart';

class UserBio extends ValueObject<String> {
  factory UserBio(String input) {
    return UserBio._(validateMaxStringLength(input, 150));
  }

  factory UserBio.empty() => UserBio('');

  const UserBio._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class SchoolName extends ValueObject<String> {
  factory SchoolName(String input) {
    return SchoolName._(
      validateMaxStringLength(input, 50)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateStringSingleLine),
    );
  }

  factory SchoolName.empty() => SchoolName('');

  const SchoolName._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class City extends ValueObject<String> {
  factory City(String input) {
    return City._(
      validateMaxStringLength(input, 50)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateStringSingleLine),
    );
  }

  factory City.empty() => City('');

  const City._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

enum IndianStatesAndUnionTerritories {
  // States
  andhraPradesh,
  arunachalPradesh,
  assam,
  bihar,
  chhattisgarh,
  goa,
  gujarat,
  haryana,
  himachalPradesh,
  jharkhand,
  karnataka,
  kerala,
  madhyaPradesh,
  maharashtra,
  manipur,
  meghalaya,
  mizoram,
  nagaland,
  odisha,
  punjab,
  rajasthan,
  sikkim,
  tamilNadu,
  telangana,
  tripura,
  uttarPradesh,
  uttarakhand,
  westBengal,

  // Union Territories
  andamanAndNicobarIslands,
  chandigarh,
  dadraAndNagarHaveliAndDamanAndDiu,
  delhi,
  jammuAndKashmir,
  ladakh,
  lakshadweep,
  puducherry,

  unknown;

  @override
  String toString() {
    return name.split(RegExp('(?=[A-Z])')).join(' ').toUpperCase();
  }
}

enum Gender {
  male,
  female,
  other,
  unknown;

  @override
  String toString() {
    return name[0].toUpperCase() + name.substring(1);
  }
}

enum EducationalQualification {
  highSchool,
  intermediate,
  bachelors,
  masters,
  phd,
  postDoc,
  other,
  unknown;

  @override
  String toString() {
    return name[0].toUpperCase() + name.substring(1);
  }
}
