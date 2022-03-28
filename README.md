# Fluentd実践入門 サンプルコード

このリポジトリは技術評論社刊「Fluentd実践入門」のサンプルコード公開のためのものです。

## Links

TBD

## 内容

このリポジトリには書籍内で例示されていたFluentdプラグインコード、およびテストコードのファイルが収録されています。10章から13章までの、Rubyのソースコードファイル全体がファイル名つきで表示されているものが対象です。また、それらのファイルを実行するためのFluentd設定ファイルやライブラリファイル(のダミー)、プラグインファイルなども含まれています。

### 環境

以下のソフトウェアが必要です。macOSで動作確認をしていますが、LinuxおよびWindowsでも動作するはずです。

* Ruby2.7もしくはそれ以降のバージョン
* Fluentd
* rake

Rubyが動作する環境で以下のコマンドを実行して準備してください。

```
$ gem install fluentd
$ gem install rake
```

### 構成・実行方法

書籍の節番号ごとにリポジトリ内の各ディレクトリに配置されています。`X.y節`に記載されているソースコードは`chapterX-y`ディレクトリにあります。

#### 10章、11章、12章、14章

プラグインのソースコード、およびそのプラグインを動作させてみるための設定ファイルが置かれています。各ディレクトリに`cd`したのちに設定ファイルを指定して実行できます。

プラグインファイルが`in_my_good_service.rb`のとき、これを動作させる設定ファイルは`my_good_service.conf`という名前で保存されています。次のコマンドで実行します。

```
$ fluentd -p. -I. -c my_good_service.conf
```

実行時に`-p. -I.`とふたつのオプションでカレントディレクトリを指定するのを忘れないでください。

#### 13章

ディレクトリごとにテストコード、およびそのテストコードが対象とするプラグインが配置されています。また各ディレクトリにテスト実行用の`Rakefile`が置かれています。

各ディレクトリに`cd`したのち、次のコマンドでテストを走行します。

```
$ rake test
```

## 作者

* Satoshi Tagomori (@tagomoris)

## ライセンス

このリポジトリ内のコードは全てMITライセンスのもとで公開します。

