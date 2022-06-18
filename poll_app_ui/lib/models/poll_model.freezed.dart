// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'poll_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PollModel _$PollModelFromJson(Map<String, dynamic> json) {
  return _PollModel.fromJson(json);
}

/// @nodoc
mixin _$PollModel {
  String get title => throw _privateConstructorUsedError;
  String get banner => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get totalVotes => throw _privateConstructorUsedError;
  int get expiresAt => throw _privateConstructorUsedError;
  List<PollCandidateModel>? get candidates =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollModelCopyWith<PollModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollModelCopyWith<$Res> {
  factory $PollModelCopyWith(PollModel value, $Res Function(PollModel) then) =
      _$PollModelCopyWithImpl<$Res>;
  $Res call(
      {String title,
      String banner,
      String description,
      int totalVotes,
      int expiresAt,
      List<PollCandidateModel>? candidates});
}

/// @nodoc
class _$PollModelCopyWithImpl<$Res> implements $PollModelCopyWith<$Res> {
  _$PollModelCopyWithImpl(this._value, this._then);

  final PollModel _value;
  // ignore: unused_field
  final $Res Function(PollModel) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? banner = freezed,
    Object? description = freezed,
    Object? totalVotes = freezed,
    Object? expiresAt = freezed,
    Object? candidates = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      banner: banner == freezed
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalVotes: totalVotes == freezed
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: expiresAt == freezed
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int,
      candidates: candidates == freezed
          ? _value.candidates
          : candidates // ignore: cast_nullable_to_non_nullable
              as List<PollCandidateModel>?,
    ));
  }
}

/// @nodoc
abstract class _$$_PollModelCopyWith<$Res> implements $PollModelCopyWith<$Res> {
  factory _$$_PollModelCopyWith(
          _$_PollModel value, $Res Function(_$_PollModel) then) =
      __$$_PollModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      String banner,
      String description,
      int totalVotes,
      int expiresAt,
      List<PollCandidateModel>? candidates});
}

/// @nodoc
class __$$_PollModelCopyWithImpl<$Res> extends _$PollModelCopyWithImpl<$Res>
    implements _$$_PollModelCopyWith<$Res> {
  __$$_PollModelCopyWithImpl(
      _$_PollModel _value, $Res Function(_$_PollModel) _then)
      : super(_value, (v) => _then(v as _$_PollModel));

  @override
  _$_PollModel get _value => super._value as _$_PollModel;

  @override
  $Res call({
    Object? title = freezed,
    Object? banner = freezed,
    Object? description = freezed,
    Object? totalVotes = freezed,
    Object? expiresAt = freezed,
    Object? candidates = freezed,
  }) {
    return _then(_$_PollModel(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      banner: banner == freezed
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalVotes: totalVotes == freezed
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: expiresAt == freezed
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int,
      candidates: candidates == freezed
          ? _value._candidates
          : candidates // ignore: cast_nullable_to_non_nullable
              as List<PollCandidateModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PollModel implements _PollModel {
  const _$_PollModel(
      {this.title = '',
      this.banner = '',
      this.description = '',
      this.totalVotes = 0,
      this.expiresAt = 0,
      final List<PollCandidateModel>? candidates = const []})
      : _candidates = candidates;

  factory _$_PollModel.fromJson(Map<String, dynamic> json) =>
      _$$_PollModelFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String banner;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int totalVotes;
  @override
  @JsonKey()
  final int expiresAt;
  final List<PollCandidateModel>? _candidates;
  @override
  @JsonKey()
  List<PollCandidateModel>? get candidates {
    final value = _candidates;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PollModel(title: $title, banner: $banner, description: $description, totalVotes: $totalVotes, expiresAt: $expiresAt, candidates: $candidates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PollModel &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.banner, banner) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.totalVotes, totalVotes) &&
            const DeepCollectionEquality().equals(other.expiresAt, expiresAt) &&
            const DeepCollectionEquality()
                .equals(other._candidates, _candidates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(banner),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(totalVotes),
      const DeepCollectionEquality().hash(expiresAt),
      const DeepCollectionEquality().hash(_candidates));

  @JsonKey(ignore: true)
  @override
  _$$_PollModelCopyWith<_$_PollModel> get copyWith =>
      __$$_PollModelCopyWithImpl<_$_PollModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PollModelToJson(this);
  }
}

abstract class _PollModel implements PollModel {
  const factory _PollModel(
      {final String title,
      final String banner,
      final String description,
      final int totalVotes,
      final int expiresAt,
      final List<PollCandidateModel>? candidates}) = _$_PollModel;

  factory _PollModel.fromJson(Map<String, dynamic> json) =
      _$_PollModel.fromJson;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get banner => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  int get totalVotes => throw _privateConstructorUsedError;
  @override
  int get expiresAt => throw _privateConstructorUsedError;
  @override
  List<PollCandidateModel>? get candidates =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PollModelCopyWith<_$_PollModel> get copyWith =>
      throw _privateConstructorUsedError;
}

PollCandidateModel _$PollCandidateModelFromJson(Map<String, dynamic> json) {
  return _PollCandidateModel.fromJson(json);
}

/// @nodoc
mixin _$PollCandidateModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get totalVotes => throw _privateConstructorUsedError;
  int get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PollCandidateModelCopyWith<PollCandidateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PollCandidateModelCopyWith<$Res> {
  factory $PollCandidateModelCopyWith(
          PollCandidateModel value, $Res Function(PollCandidateModel) then) =
      _$PollCandidateModelCopyWithImpl<$Res>;
  $Res call({String title, String description, int totalVotes, int expiresAt});
}

/// @nodoc
class _$PollCandidateModelCopyWithImpl<$Res>
    implements $PollCandidateModelCopyWith<$Res> {
  _$PollCandidateModelCopyWithImpl(this._value, this._then);

  final PollCandidateModel _value;
  // ignore: unused_field
  final $Res Function(PollCandidateModel) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? totalVotes = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalVotes: totalVotes == freezed
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: expiresAt == freezed
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$$_PollCandidateModelCopyWith<$Res>
    implements $PollCandidateModelCopyWith<$Res> {
  factory _$$_PollCandidateModelCopyWith(_$_PollCandidateModel value,
          $Res Function(_$_PollCandidateModel) then) =
      __$$_PollCandidateModelCopyWithImpl<$Res>;
  @override
  $Res call({String title, String description, int totalVotes, int expiresAt});
}

/// @nodoc
class __$$_PollCandidateModelCopyWithImpl<$Res>
    extends _$PollCandidateModelCopyWithImpl<$Res>
    implements _$$_PollCandidateModelCopyWith<$Res> {
  __$$_PollCandidateModelCopyWithImpl(
      _$_PollCandidateModel _value, $Res Function(_$_PollCandidateModel) _then)
      : super(_value, (v) => _then(v as _$_PollCandidateModel));

  @override
  _$_PollCandidateModel get _value => super._value as _$_PollCandidateModel;

  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? totalVotes = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$_PollCandidateModel(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      totalVotes: totalVotes == freezed
          ? _value.totalVotes
          : totalVotes // ignore: cast_nullable_to_non_nullable
              as int,
      expiresAt: expiresAt == freezed
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PollCandidateModel implements _PollCandidateModel {
  const _$_PollCandidateModel(
      {this.title = '',
      this.description = '',
      this.totalVotes = 0,
      this.expiresAt = 0});

  factory _$_PollCandidateModel.fromJson(Map<String, dynamic> json) =>
      _$$_PollCandidateModelFromJson(json);

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int totalVotes;
  @override
  @JsonKey()
  final int expiresAt;

  @override
  String toString() {
    return 'PollCandidateModel(title: $title, description: $description, totalVotes: $totalVotes, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PollCandidateModel &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.totalVotes, totalVotes) &&
            const DeepCollectionEquality().equals(other.expiresAt, expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(totalVotes),
      const DeepCollectionEquality().hash(expiresAt));

  @JsonKey(ignore: true)
  @override
  _$$_PollCandidateModelCopyWith<_$_PollCandidateModel> get copyWith =>
      __$$_PollCandidateModelCopyWithImpl<_$_PollCandidateModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PollCandidateModelToJson(this);
  }
}

abstract class _PollCandidateModel implements PollCandidateModel {
  const factory _PollCandidateModel(
      {final String title,
      final String description,
      final int totalVotes,
      final int expiresAt}) = _$_PollCandidateModel;

  factory _PollCandidateModel.fromJson(Map<String, dynamic> json) =
      _$_PollCandidateModel.fromJson;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  int get totalVotes => throw _privateConstructorUsedError;
  @override
  int get expiresAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PollCandidateModelCopyWith<_$_PollCandidateModel> get copyWith =>
      throw _privateConstructorUsedError;
}
