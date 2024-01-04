import 'package:form_example/model/user_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'form_notifier.g.dart';

@riverpod
class GenderNotifier extends _$GenderNotifier {
  @override
  Gender build() {
    return Gender.male;
  }

  void updateGender(Gender gender) {
    state = gender;
  }
}

@riverpod
class FormNotifier extends _$FormNotifier {
  @override
  Person build() {
    return const Person();
  }

  void kanaChanged(String value) {
    state = state.copyWith(kana: value);
  }

  void passwordChanged(String value) {
    state = state.copyWith(password: int.parse(value));
  }
}
