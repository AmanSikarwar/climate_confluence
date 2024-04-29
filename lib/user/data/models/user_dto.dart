import 'package:climate_confluence/common/data/models/value_objects.dart';
import 'package:climate_confluence/user/data/models/user.dart';
import 'package:climate_confluence/user/data/models/value_objects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@Collection<UserDto>('users')
@freezed
class UserDto with _$UserDto {
  factory UserDto({
    @Id() required String id,
    required String name,
    required String email,
    required String gender,
    required String phoneNumber,
    required String schoolName,
    required String educationalQualification,
    required String city,
    required String state,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? photoUrl,
    String? bio,
  }) = _UserDto;
  const UserDto._();

  factory UserDto.fromJson(Map<String, Object?> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.fromDomain(User user) => UserDto(
        id: user.id.getOrCrash(),
        name: user.name.getOrCrash(),
        email: user.emailAddress.getOrCrash(),
        gender: user.gender.name,
        phoneNumber: user.phoneNumber.getOrCrash(),
        schoolName: user.schoolName.getOrCrash(),
        educationalQualification: user.educationalQualification.name,
        city: user.city.getOrCrash(),
        state: user.state.name,
        createdAt: user.createdAt.toUtc(),
        updatedAt: user.updatedAt.toUtc(),
        photoUrl: user.photoUrl?.getOrCrash(),
        bio: user.bio?.getOrCrash(),
      );

  User toDomain() => User(
        id: UniqueId.fromUniqueString(id),
        name: Name(name),
        emailAddress: EmailAddress(email),
        gender: Gender.values.firstWhere(
          (element) => element.name == gender,
        ),
        phoneNumber: PhoneNumber(phoneNumber),
        schoolName: SchoolName(schoolName),
        educationalQualification: EducationalQualification.values.firstWhere(
          (element) => element.name == educationalQualification,
        ),
        city: City(city),
        state: IndianStatesAndUnionTerritories.values.firstWhere(
          (element) => element.name == state,
        ),
        createdAt: createdAt.toLocal(),
        updatedAt: updatedAt.toLocal(),
        photoUrl: photoUrl != null ? Url(photoUrl!) : null,
        bio: bio != null ? UserBio(bio!) : null,
      );
}

final userDtoRef = UserDtoCollectionReference();
