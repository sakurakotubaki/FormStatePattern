// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonImpl _$$PersonImplFromJson(Map<String, dynamic> json) => _$PersonImpl(
      gender: json['gender'] ?? Gender,
      kana: json['kana'] as String? ?? '',
      password: json['password'] as int? ?? 0,
    );

Map<String, dynamic> _$$PersonImplToJson(_$PersonImpl instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'kana': instance.kana,
      'password': instance.password,
    };
