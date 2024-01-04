// 他のページでも使うかもしれないのでシングルトンでグローバルに正規表現を定義
class RegularExpression {
  late String kana;
  late String password;

  static final RegularExpression _instance = RegularExpression._internal();

  factory RegularExpression() => _instance;

  RegularExpression._internal() {
    // カタカナの正規表現
    kana = r'^[ァ-ヶー]+$';
    // 半角数値のみの正規表現
    password = r'^[0-9]+$';
  }
}
