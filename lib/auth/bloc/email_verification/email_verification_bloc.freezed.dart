// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_verification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EmailVerificationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() verificationEmailSent,
    required TResult Function(AuthUser authUser) authUserChanged,
    required TResult Function() reSendVerificationEmailPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? verificationEmailSent,
    TResult? Function(AuthUser authUser)? authUserChanged,
    TResult? Function()? reSendVerificationEmailPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? verificationEmailSent,
    TResult Function(AuthUser authUser)? authUserChanged,
    TResult Function()? reSendVerificationEmailPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(_AuthUserChanged value) authUserChanged,
    required TResult Function(ReSendVerificationEmailPressed value)
        reSendVerificationEmailPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerificationEmailSent value)? verificationEmailSent,
    TResult? Function(_AuthUserChanged value)? authUserChanged,
    TResult? Function(ReSendVerificationEmailPressed value)?
        reSendVerificationEmailPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEmailSent value)? verificationEmailSent,
    TResult Function(_AuthUserChanged value)? authUserChanged,
    TResult Function(ReSendVerificationEmailPressed value)?
        reSendVerificationEmailPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailVerificationEventCopyWith<$Res> {
  factory $EmailVerificationEventCopyWith(EmailVerificationEvent value,
          $Res Function(EmailVerificationEvent) then) =
      _$EmailVerificationEventCopyWithImpl<$Res, EmailVerificationEvent>;
}

/// @nodoc
class _$EmailVerificationEventCopyWithImpl<$Res,
        $Val extends EmailVerificationEvent>
    implements $EmailVerificationEventCopyWith<$Res> {
  _$EmailVerificationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$VerificationEmailSentImplCopyWith<$Res> {
  factory _$$VerificationEmailSentImplCopyWith(
          _$VerificationEmailSentImpl value,
          $Res Function(_$VerificationEmailSentImpl) then) =
      __$$VerificationEmailSentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerificationEmailSentImplCopyWithImpl<$Res>
    extends _$EmailVerificationEventCopyWithImpl<$Res,
        _$VerificationEmailSentImpl>
    implements _$$VerificationEmailSentImplCopyWith<$Res> {
  __$$VerificationEmailSentImplCopyWithImpl(_$VerificationEmailSentImpl _value,
      $Res Function(_$VerificationEmailSentImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$VerificationEmailSentImpl implements VerificationEmailSent {
  const _$VerificationEmailSentImpl();

  @override
  String toString() {
    return 'EmailVerificationEvent.verificationEmailSent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationEmailSentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() verificationEmailSent,
    required TResult Function(AuthUser authUser) authUserChanged,
    required TResult Function() reSendVerificationEmailPressed,
  }) {
    return verificationEmailSent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? verificationEmailSent,
    TResult? Function(AuthUser authUser)? authUserChanged,
    TResult? Function()? reSendVerificationEmailPressed,
  }) {
    return verificationEmailSent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? verificationEmailSent,
    TResult Function(AuthUser authUser)? authUserChanged,
    TResult Function()? reSendVerificationEmailPressed,
    required TResult orElse(),
  }) {
    if (verificationEmailSent != null) {
      return verificationEmailSent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(_AuthUserChanged value) authUserChanged,
    required TResult Function(ReSendVerificationEmailPressed value)
        reSendVerificationEmailPressed,
  }) {
    return verificationEmailSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerificationEmailSent value)? verificationEmailSent,
    TResult? Function(_AuthUserChanged value)? authUserChanged,
    TResult? Function(ReSendVerificationEmailPressed value)?
        reSendVerificationEmailPressed,
  }) {
    return verificationEmailSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEmailSent value)? verificationEmailSent,
    TResult Function(_AuthUserChanged value)? authUserChanged,
    TResult Function(ReSendVerificationEmailPressed value)?
        reSendVerificationEmailPressed,
    required TResult orElse(),
  }) {
    if (verificationEmailSent != null) {
      return verificationEmailSent(this);
    }
    return orElse();
  }
}

abstract class VerificationEmailSent implements EmailVerificationEvent {
  const factory VerificationEmailSent() = _$VerificationEmailSentImpl;
}

/// @nodoc
abstract class _$$AuthUserChangedImplCopyWith<$Res> {
  factory _$$AuthUserChangedImplCopyWith(_$AuthUserChangedImpl value,
          $Res Function(_$AuthUserChangedImpl) then) =
      __$$AuthUserChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthUser authUser});

  $AuthUserCopyWith<$Res> get authUser;
}

/// @nodoc
class __$$AuthUserChangedImplCopyWithImpl<$Res>
    extends _$EmailVerificationEventCopyWithImpl<$Res, _$AuthUserChangedImpl>
    implements _$$AuthUserChangedImplCopyWith<$Res> {
  __$$AuthUserChangedImplCopyWithImpl(
      _$AuthUserChangedImpl _value, $Res Function(_$AuthUserChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authUser = null,
  }) {
    return _then(_$AuthUserChangedImpl(
      null == authUser
          ? _value.authUser
          : authUser // ignore: cast_nullable_to_non_nullable
              as AuthUser,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthUserCopyWith<$Res> get authUser {
    return $AuthUserCopyWith<$Res>(_value.authUser, (value) {
      return _then(_value.copyWith(authUser: value));
    });
  }
}

/// @nodoc

class _$AuthUserChangedImpl implements _AuthUserChanged {
  const _$AuthUserChangedImpl(this.authUser);

  @override
  final AuthUser authUser;

  @override
  String toString() {
    return 'EmailVerificationEvent.authUserChanged(authUser: $authUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserChangedImpl &&
            (identical(other.authUser, authUser) ||
                other.authUser == authUser));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserChangedImplCopyWith<_$AuthUserChangedImpl> get copyWith =>
      __$$AuthUserChangedImplCopyWithImpl<_$AuthUserChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() verificationEmailSent,
    required TResult Function(AuthUser authUser) authUserChanged,
    required TResult Function() reSendVerificationEmailPressed,
  }) {
    return authUserChanged(authUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? verificationEmailSent,
    TResult? Function(AuthUser authUser)? authUserChanged,
    TResult? Function()? reSendVerificationEmailPressed,
  }) {
    return authUserChanged?.call(authUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? verificationEmailSent,
    TResult Function(AuthUser authUser)? authUserChanged,
    TResult Function()? reSendVerificationEmailPressed,
    required TResult orElse(),
  }) {
    if (authUserChanged != null) {
      return authUserChanged(authUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(_AuthUserChanged value) authUserChanged,
    required TResult Function(ReSendVerificationEmailPressed value)
        reSendVerificationEmailPressed,
  }) {
    return authUserChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerificationEmailSent value)? verificationEmailSent,
    TResult? Function(_AuthUserChanged value)? authUserChanged,
    TResult? Function(ReSendVerificationEmailPressed value)?
        reSendVerificationEmailPressed,
  }) {
    return authUserChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEmailSent value)? verificationEmailSent,
    TResult Function(_AuthUserChanged value)? authUserChanged,
    TResult Function(ReSendVerificationEmailPressed value)?
        reSendVerificationEmailPressed,
    required TResult orElse(),
  }) {
    if (authUserChanged != null) {
      return authUserChanged(this);
    }
    return orElse();
  }
}

abstract class _AuthUserChanged implements EmailVerificationEvent {
  const factory _AuthUserChanged(final AuthUser authUser) =
      _$AuthUserChangedImpl;

  AuthUser get authUser;
  @JsonKey(ignore: true)
  _$$AuthUserChangedImplCopyWith<_$AuthUserChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReSendVerificationEmailPressedImplCopyWith<$Res> {
  factory _$$ReSendVerificationEmailPressedImplCopyWith(
          _$ReSendVerificationEmailPressedImpl value,
          $Res Function(_$ReSendVerificationEmailPressedImpl) then) =
      __$$ReSendVerificationEmailPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ReSendVerificationEmailPressedImplCopyWithImpl<$Res>
    extends _$EmailVerificationEventCopyWithImpl<$Res,
        _$ReSendVerificationEmailPressedImpl>
    implements _$$ReSendVerificationEmailPressedImplCopyWith<$Res> {
  __$$ReSendVerificationEmailPressedImplCopyWithImpl(
      _$ReSendVerificationEmailPressedImpl _value,
      $Res Function(_$ReSendVerificationEmailPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ReSendVerificationEmailPressedImpl
    implements ReSendVerificationEmailPressed {
  const _$ReSendVerificationEmailPressedImpl();

  @override
  String toString() {
    return 'EmailVerificationEvent.reSendVerificationEmailPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReSendVerificationEmailPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() verificationEmailSent,
    required TResult Function(AuthUser authUser) authUserChanged,
    required TResult Function() reSendVerificationEmailPressed,
  }) {
    return reSendVerificationEmailPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? verificationEmailSent,
    TResult? Function(AuthUser authUser)? authUserChanged,
    TResult? Function()? reSendVerificationEmailPressed,
  }) {
    return reSendVerificationEmailPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? verificationEmailSent,
    TResult Function(AuthUser authUser)? authUserChanged,
    TResult Function()? reSendVerificationEmailPressed,
    required TResult orElse(),
  }) {
    if (reSendVerificationEmailPressed != null) {
      return reSendVerificationEmailPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(VerificationEmailSent value)
        verificationEmailSent,
    required TResult Function(_AuthUserChanged value) authUserChanged,
    required TResult Function(ReSendVerificationEmailPressed value)
        reSendVerificationEmailPressed,
  }) {
    return reSendVerificationEmailPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(VerificationEmailSent value)? verificationEmailSent,
    TResult? Function(_AuthUserChanged value)? authUserChanged,
    TResult? Function(ReSendVerificationEmailPressed value)?
        reSendVerificationEmailPressed,
  }) {
    return reSendVerificationEmailPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(VerificationEmailSent value)? verificationEmailSent,
    TResult Function(_AuthUserChanged value)? authUserChanged,
    TResult Function(ReSendVerificationEmailPressed value)?
        reSendVerificationEmailPressed,
    required TResult orElse(),
  }) {
    if (reSendVerificationEmailPressed != null) {
      return reSendVerificationEmailPressed(this);
    }
    return orElse();
  }
}

abstract class ReSendVerificationEmailPressed
    implements EmailVerificationEvent {
  const factory ReSendVerificationEmailPressed() =
      _$ReSendVerificationEmailPressedImpl;
}

/// @nodoc
mixin _$EmailVerificationState {
  bool get verified => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, Unit>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;
  DateTime? get lastEmailSentTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmailVerificationStateCopyWith<EmailVerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailVerificationStateCopyWith<$Res> {
  factory $EmailVerificationStateCopyWith(EmailVerificationState value,
          $Res Function(EmailVerificationState) then) =
      _$EmailVerificationStateCopyWithImpl<$Res, EmailVerificationState>;
  @useResult
  $Res call(
      {bool verified,
      Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
      DateTime? lastEmailSentTime});
}

/// @nodoc
class _$EmailVerificationStateCopyWithImpl<$Res,
        $Val extends EmailVerificationState>
    implements $EmailVerificationStateCopyWith<$Res> {
  _$EmailVerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verified = null,
    Object? authFailureOrSuccessOption = null,
    Object? lastEmailSentTime = freezed,
  }) {
    return _then(_value.copyWith(
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Unit>>,
      lastEmailSentTime: freezed == lastEmailSentTime
          ? _value.lastEmailSentTime
          : lastEmailSentTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailVerificationStateImplCopyWith<$Res>
    implements $EmailVerificationStateCopyWith<$Res> {
  factory _$$EmailVerificationStateImplCopyWith(
          _$EmailVerificationStateImpl value,
          $Res Function(_$EmailVerificationStateImpl) then) =
      __$$EmailVerificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool verified,
      Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
      DateTime? lastEmailSentTime});
}

/// @nodoc
class __$$EmailVerificationStateImplCopyWithImpl<$Res>
    extends _$EmailVerificationStateCopyWithImpl<$Res,
        _$EmailVerificationStateImpl>
    implements _$$EmailVerificationStateImplCopyWith<$Res> {
  __$$EmailVerificationStateImplCopyWithImpl(
      _$EmailVerificationStateImpl _value,
      $Res Function(_$EmailVerificationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verified = null,
    Object? authFailureOrSuccessOption = null,
    Object? lastEmailSentTime = freezed,
  }) {
    return _then(_$EmailVerificationStateImpl(
      verified: null == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Unit>>,
      lastEmailSentTime: freezed == lastEmailSentTime
          ? _value.lastEmailSentTime
          : lastEmailSentTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$EmailVerificationStateImpl implements _EmailVerificationState {
  const _$EmailVerificationStateImpl(
      {required this.verified,
      required this.authFailureOrSuccessOption,
      this.lastEmailSentTime});

  @override
  final bool verified;
  @override
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;
  @override
  final DateTime? lastEmailSentTime;

  @override
  String toString() {
    return 'EmailVerificationState(verified: $verified, authFailureOrSuccessOption: $authFailureOrSuccessOption, lastEmailSentTime: $lastEmailSentTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailVerificationStateImpl &&
            (identical(other.verified, verified) ||
                other.verified == verified) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption) &&
            (identical(other.lastEmailSentTime, lastEmailSentTime) ||
                other.lastEmailSentTime == lastEmailSentTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, verified, authFailureOrSuccessOption, lastEmailSentTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailVerificationStateImplCopyWith<_$EmailVerificationStateImpl>
      get copyWith => __$$EmailVerificationStateImplCopyWithImpl<
          _$EmailVerificationStateImpl>(this, _$identity);
}

abstract class _EmailVerificationState implements EmailVerificationState {
  const factory _EmailVerificationState(
      {required final bool verified,
      required final Option<Either<AuthFailure, Unit>>
          authFailureOrSuccessOption,
      final DateTime? lastEmailSentTime}) = _$EmailVerificationStateImpl;

  @override
  bool get verified;
  @override
  Option<Either<AuthFailure, Unit>> get authFailureOrSuccessOption;
  @override
  DateTime? get lastEmailSentTime;
  @override
  @JsonKey(ignore: true)
  _$$EmailVerificationStateImplCopyWith<_$EmailVerificationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
