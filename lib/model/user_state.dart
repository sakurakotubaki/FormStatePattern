import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

// 性別のenumを引数つきコンストラクタで定義
enum Gender {
  male(value: '男性'),
  woman(value: '女性');

  final String value;
  const Gender({required this.value});
}

@freezed
class Person with _$Person {
  const factory Person({
    @Default(Gender) gender,
    @Default('') String kana,
    @Default(0) int password,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json)
      => _$PersonFromJson(json);
}
