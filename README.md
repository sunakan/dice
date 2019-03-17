# Dice

[![CircleCI](https://circleci.com/gh/sunakan/dice.svg?style=svg)](https://circleci.com/gh/sunakan/dice)
[![Maintainability](https://api.codeclimate.com/v1/badges/9459ae16e000e5444cfb/maintainability)](https://codeclimate.com/github/sunakan/dice/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9459ae16e000e5444cfb/test_coverage)](https://codeclimate.com/github/sunakan/dice/test_coverage)

## 実行

```
# アプリ実行
$ sudo docker-compose up app
# Jenkins
$ sudo docker-compose up jenkins
# DBセットアップ
$ sh setup_db.sh
```
## ブランチ管理のワークフロー

- github flow

## 学習項目

- github flow
- Docker
- Heroku(Rails)
- CircleCIによる自動テストと自動デプロイ
- CodeClimateを利用したコード品質とカバレッジの可視化
- RailsとMongoDB
- Railsで複数DB
  - 勉強するときに重宝
- Ridgepoleを使ったスキーマファイルの管理(複数DB)
  - Not マイグレーションファイル
- Paizaの公開されている練習問題(途中)
- TechProjinが公開しているSQL練習問題(途中、終わりはある)
  - ActiveRecordと生SQL両方
- Jenkinsによるローカルでの自動テスト
  - Dockerで毎回立て直す(あくまでローカル用、pushしたらCircleCIがしてくれる)
  - 自動テストだけで、レポート類は一旦諦めてる
- 書籍: テスト駆動開発(lib/tdd以下)
- RailsとPlantUMLとUML
- 書籍: 達人に学ぶSQL徹底指南書(旧版)

## ER図

- worldcup2014
- [PlantUML](http://www.plantuml.com/plantuml/uml/NP1DRiGW38Ntd88Bv0uZTT5jRu2On4ci11CvHXKQvkwre2bAD_3U4tp-UPpYMLBOpOeJM0Y7P1iWF85F0oIezYCc4ixsPQp5IG_o0VHYJnlIechXc0vNu_Vrwslt6RX_6Xl5LPC8vyZ1KGhgZdYYOAIE7lVqr6i5N5PHyTr4XtjaBTtf6uvRdETPPSZkLWi8Rb6dV4Q_TyJHcAwPsdtJYpvpWdKuSotZFGob_0xvFsmWSpLPoZ2yQZ7JtbjRub_q09fq_py0)

![worldcup2014_erd](http://www.plantuml.com/plantuml/svg/NP1DRiGW38Ntd88Bv0uZTT5jRu2On4ci11CvHXKQvkwre2bAD_3U4tp-UPpYMLBOpOeJM0Y7P1iWF85F0oIezYCc4ixsPQp5IG_o0VHYJnlIechXc0vNu_Vrwslt6RX_6Xl5LPC8vyZ1KGhgZdYYOAIE7lVqr6i5N5PHyTr4XtjaBTtf6uvRdETPPSZkLWi8Rb6dV4Q_TyJHcAwPsdtJYpvpWdKuSotZFGob_0xvFsmWSpLPoZ2yQZ7JtbjRub_q09fq_py0)

## 複数DB

- 設定ファイル
  - main
    - config/database.yml
    - config/mongoid.yml
  - sub
    - config/ext\_datases/\*\_database.yml
- Model(ActiveRecord限定)
  - main
    - app/models/直下
  - sub(hogeDBを追加したい時)
    - app/models/hoge.rbの大まかな中身
      - Hoge::DATABASE_YAML = hoge\_database.ymlへのパス
      - Hoge::AppRecordがサブDBへのconnectionを貼る
      - Hoge::AppRecordはabstract class
    - app/models/hoge/\*.rb
      - Hoge::User << Hoge::AppRecord

## Dockerfileの個人的ポイント

- build-essentialとlibpq-devはnokogiri等のため
  - nokogiriはrailsに必要

- ほんとに最初はdocker-container run app bashでコンテナ内で少しだけ作業
  - (bundle initや1番最初のbundle install, rails newの時にもするかも)

- ~~dockerコンテナの中で1度bundle install --path=vendor/bundle~~
  - ~~このディレクトリはdocker-compose.ymlにvolumeとして記述~~
    - ~~キャッシュが効くようになる~~
  - ~~コンテナ内でbundle installをした理由は、ホスト側にbundlerがない前提のため~~
    - ~~次からDockerfileに記述する(次からGemfile, Gemfile.lockもあるからOK)~~

- Dockerfileにproductionモードでのprecompile処理を書いとく
  - docker-compose時はdevelopmentを指定で開発、テスト
  - herokuで使う && deployしたあと、手元でheroku run XXXXとするのが面倒

- Dockerfile.dev的なものが必要かもしれない...
  - docker-composeのdockerfileはDockerfile.devを指定とか
  - 問題点: Dockerfileの2重管理が発生する
    - 解決: マルチビルドステージとdocker-compose(3.4以上)によるビルドステージの指定
    - docker-composeは開発用と割り切る(buildオプションでビルドステージを指定)

## heroku

### bundler 2.0

```
$ heroku buildpacks:set https://github.com/bundler/heroku-buildpack-bundler2
```

### ~~herokuでpumaを起動させるにはProcfileが必要~~(情報が古い。。。今はheroku.yml)

- 中身(1行のみ)

```
web: bundle exec puma -C config/puma.rb
```

### herokuへpush,build

- masterをpush
  - `git push heroku master`
- hogeブランチをpush,それをbuild
  - `git push heroku hoge:master`

### herokuへpush,buildできてもブラウザでアプリを開くとエラー

- precompile
  - precompile時、yarnで怒られるならファイルはあってもだめ
    - yarnを入れればよい
- db:create, db:migrate系

### herokuへpush,buildに関して、いろいろ情報が出てきて方法ありすぎぃ

- 結局
  - git heroku push master
    - heroku.ymlが必須(Procfileの代わり&addonとかもこれにまとめられる)
    - Procfileいらない(pumaでは必要とか載ってる情報は少し古いため気をつける)
- 昔
  - image buildしてpushしてreleaseとか古い

### CircleCIのconfigファイルのvalidationチェックはlocalで

- https://circleci.com/docs/2.0/local-cli/#validate-a-circleci-config

```
$ circleci config validate
```

### Ridgepole

~~~
$ sudo docker-compose exec app bundle exec rake db:create
$ sudo docker-compose exec app bundle exec ridgepole -c config/database.yml -E development --apply -f db/Schemafile
$ sudo docker-compose exec app bundle exec ridgepole -c config/database.yml -E test --apply -f db/everyday_rails_rspec/Schemafile
~~~

### active\_recordを使ってmodel生成

~~~
$ sudo docker-compose exec app bundle exec rails g active_record:model member --skip-migration
~~~

### FactoryBot

~~~
$ sudo docker-compose exec app bundle exec rails g factory_bot:model user
~~~

### Jenkins: インストール済みのプラグイン一覧をplugins.txtに出力

~~~
$ curl -X GET -u $USER_NAME:$API_TOKEN -sSL "$JENKINS_URL:$JENKINS_PORT/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'|sed 's/ /:/'
~~~

- APIの取得
  1. 右上のユーザー名をクリック語、メニューから設定（Configure）をクリック
  1. プロフィール画面から、「APIトークンの表示」をクリック
