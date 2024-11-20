# FlutterKaigi 2024

このリポジトリ（の `chore/flutter_kaigi_2024` ブランチ）は、FlutterKaigi 2024 のセッション __「体験!マクロ時代のFlutterアプリ開発」__ のためのマクロ体験用の Flutter プロジェクトです。

以下の手順に従って環境を構築し、セッションを聞きながら手元でマクロを体験してみてください。

## 環境構築

1. このリポジトリをクローンします。

```
$ git clone -b chore/flutter_kaigi_2024 git@github.com:chooyan-eng/macros_practice.git
```

2. Flutter を master チャンネルの最新版に更新します

※ 以下は `flutter` コマンドで PC 全体で利用する Flutter バージョンを変更する方法です。FVM などを利用する場合は適宜読み替えてください。

```
$ cd macros_practice
$ flutter channel master
$ flutter upgrade
$ flutter pub get 
```

3. pub.get します

```
$ flutter pub get 
```

4. 動作確認

`lib/playground/hello_world.dart` を開き、`sayHello()` 関数の定義元を開くと以下のコードが表示されることを確認してください。

```dart
part of 'package:macros_practice/playground/hello_world.dart';

// Hello, FlutterKaigi!
void sayHello() {
      print(name);
    }
```

さらに、変数名 `name` を `myName` に変更すると、`sayHello()` 関数の実装が以下のように変化していることを確認してください。

```dart
void sayHello() {
      print(myName);
    }
```

## マクロを使ってみる

試しに `RouteMacro` を使って `Navigator.push()` に渡す `MaterialPageRoute` を生成する static なメソッドを自動生成してみましょう。

`lib/playground/article_list_page.dart` を開き、`ArticleListPage` クラスを確認してください。

```dart
class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

`ArticleListPage` は「記事一覧画面」を想定した Widget クラスです。

このページに簡単に遷移できるよう、`MaterialPageRoute` を生成する static なメソッドを用意したいです。

```dart
MaterialPageRoute<void> route() {
  return MaterialPageRoute<void>(
    builder: (context) => const ArticleListPage(),
  );
}
```

ただし、これをいちいち書くのは面倒ですので、マクロで自動生成したいと思います。

`class ArticleListPage` の行の上に `@RouteMacro()` を追加してみてください。

```dart
@RouteMacro()
class ArticleListPage extends StatelessWidget {
  const ArticleListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

`@RouteMacro()` の下に `Go to Augmentation` の文字が出てきたでしょうか。そこをタップすると、以下のようなコードが生成されているのが確認できます。

```dart
part of 'package:macros_practice/playground/article_list_page.dart';

import 'package:macros_practice/playground/article_list_page.dart' as prefix0;

augment class ArticleListPage {
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (context) => const prefix0.ArticleListPage(),
    );
  }
}
```

これで、他の Widget から `ArticleListPage` に遷移する際は `ArticleListPage.route()` を呼び出すだけで良くなりました。

# サンプルのマクロたち

他にも `lib/macros` にはさまざまなサンプルのマクロが用意されています。作成途中のものもありますが、確認してみてください。大まかな使い方は以下の通りです。（ `main` ブランチの英語での説明を使い回しています）

## route_macro.dart

`@RouteMacro<T>` help us create `.route()` static method that returns `MaterialPageRoute<T>` for navigating to the page.

See [next_page.dart](lib/next_page.dart) for the usage of this macro.

## stateful_widget_macro.dart

With applying `@Stateful` to your class with `build()` method, you don't need to define `StatefulWidget` class and `State` class.

See [book_list_page.dart](lib/book_list_page.dart) for the usage of this macro.

## inherited_widget_macro.dart

`@InheritedWidgetMacro` would solve the boilerplate issue of `InheritedWidget` by defining `.of` method and `.maybeOf` method automatically. In addition, this macro tries to define `StatefulWidget` to maintain `InheritedWidget`'s state.

This macro is still in progress and no example usage is comitted.
