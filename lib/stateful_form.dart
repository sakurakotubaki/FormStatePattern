import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_example/const/regular_expression.dart';
import 'package:form_example/model/user_state.dart';

class StatefulForm extends StatefulWidget {
  const StatefulForm({super.key});

  @override
  State<StatefulForm> createState() => _StatefulFormState();
}

class _StatefulFormState extends State<StatefulForm> {
  // 性別のラジオボタンの状態変数
  Gender? _gender = Gender.male;
  // 一意なキーを参照するためのグローバルキー
  final _formKey = GlobalKey<FormState>();
  // エラーメッセージの状態変数
  String _errorMessage = '';
  // 数字のエラーメッセージの状態変数
  String _numberErrorMessage = '';
  // form用のコントローラー
  final _kanaController = TextEditingController();
  final _passwordController = TextEditingController();

  // コントローラーの破棄
  @override
  void dispose() {
    _kanaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Stateful Form'),
      ),
      // Formでラップすることで、Formの子要素のTextFormFieldのvalidatorを使える
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // ラジオボタンを配置
            ListTile(
              title: Text(Gender.male.value),
              leading: Radio<Gender>(
                value: Gender.male,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(Gender.woman.value),
              leading: Radio<Gender>(
                value: Gender.woman,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.centerLeft, child: Text('12文字まで入力可能')),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: TextFormField(
                controller: _kanaController,
                inputFormatters: [LengthLimitingTextInputFormatter(12)],
                validator: (value) {
                  final regExp = RegExp(RegularExpression().kana);
                  if (!regExp.hasMatch(value!)) {
                    setState(() {
                      _errorMessage = 'カタカナのみ入力できます';
                    });
                    return '';
                  }
                  setState(() {
                    _errorMessage = '';
                  });
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: TextFormField(
                controller: _passwordController,
                inputFormatters: [LengthLimitingTextInputFormatter(12)],
                validator: (value) {
                  final regExp = RegExp(RegularExpression().password);
                  if (!regExp.hasMatch(value!)) {
                    setState(() {
                      _numberErrorMessage = '半角数字のみ入力できます';
                    });
                    return '';
                  }
                  setState(() {
                    _numberErrorMessage = '';
                  });
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _numberErrorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var users = Person().copyWith(
                      gender: _gender!,
                      kana: _kanaController.text,
                      password: int.parse(_passwordController.text),
                    );
                    debugPrint(users.toString());
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
