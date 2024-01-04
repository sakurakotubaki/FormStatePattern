import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_example/const/regular_expression.dart';
import 'package:form_example/model/user_state.dart';
import 'package:form_example/usecase/form_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormConsumer extends HookConsumerWidget {
  const FormConsumer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 一意なキーを参照するためのグローバルキー
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final genderNotifier = ref.watch(genderNotifierProvider);
    // form用のコントローラー
    final _kanaController = useTextEditingController();
    final _passwordController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Form Consumer'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // ラジオボタンを配置
            ListTile(
              title: Text(Gender.male.value),
              leading: Radio<Gender>(
                value: Gender.male,
                groupValue: genderNotifier,
                onChanged: (Gender? value) {
                  ref
                      .read(genderNotifierProvider.notifier)
                      .updateGender(value!);
                },
              ),
            ),
            ListTile(
              title: Text(Gender.woman.value),
              leading: Radio<Gender>(
                value: Gender.woman,
                groupValue: genderNotifier,
                onChanged: (Gender? value) {
                  ref
                      .read(genderNotifierProvider.notifier)
                      .updateGender(value!);
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.centerLeft, child: Text('12文字まで入力可能')),
            ),
            const SizedBox(height: 20),
            // TextFormFieldを配置
            TextFormField(
              controller: _kanaController,
              inputFormatters: [LengthLimitingTextInputFormatter(12)],
              // 入力された値を取得するためのコールバック
              onChanged: (String value) {
                // 入力された値が12文字を超えた場合
                if (value.length > 12) {
                  // エラーメッセージを表示
                  // _errorMessage.value = '12文字以内で入力してください';
                  ref.read(formNotifierProvider.notifier).kanaChanged(value);
                } else {
                  // エラーメッセージを非表示
                  ref.read(formNotifierProvider.notifier).kanaChanged(value);
                }
              },
              // 入力された値が正規表現にマッチしなかった場合
              validator: (String? value) {
                if (value != null) {
                  if (!RegExp(RegularExpression().kana).hasMatch(value)) {
                    // エラーメッセージを表示
                    return 'カタカナで入力してください';
                  }
                }
                return null;
              },
            ),
            // パスワードの入力フォーム
            TextFormField(
              controller: _passwordController,
              inputFormatters: [LengthLimitingTextInputFormatter(12)],
              // 入力された値を取得するためのコールバック
              onChanged: (String value) {
                // 入力された値が12文字を超えた場合
                if (value.length > 12) {
                  // エラーメッセージを表示
                  ref
                      .read(formNotifierProvider.notifier)
                      .passwordChanged(value);
                } else {
                  // エラーメッセージを非表示
                  ref
                      .read(formNotifierProvider.notifier)
                      .passwordChanged(value);
                }
              },
              // 入力された値が正規表現にマッチしなかった場合
              validator: (String? value) {
                if (value != null) {
                  if (!RegExp(RegularExpression().password).hasMatch(value)) {
                    // エラーメッセージを表示
                    return '半角数字のみで入力してください';
                  }
                }
                return null;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var users = const Person().copyWith(
                      gender: genderNotifier.value,
                      kana: _kanaController.text,
                      password: int.parse(_passwordController.text),
                    );
                    debugPrint('Riverpodで保存しました: $users');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('送信に成功しました!')),
                    );
                  }
                },
                child: const Text('送信')),
          ],
        ),
      ),
    );
  }
}
