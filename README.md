# Dice

[![CircleCI](https://circleci.com/gh/sunakan/dice.svg?style=svg)](https://circleci.com/gh/sunakan/dice)
[![Maintainability](https://api.codeclimate.com/v1/badges/9459ae16e000e5444cfb/maintainability)](https://codeclimate.com/github/sunakan/dice/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/9459ae16e000e5444cfb/test_coverage)](https://codeclimate.com/github/sunakan/dice/test_coverage)

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

## rails new のオプション

```
$ rails new . -B -G -O -T -M -C --skip-coffee --skip-turbolinks
```

- -B
  - --skip-bundle
- -G
  - --skip-git
- -O
  - --skip-active-recode
- -T
  - --skip-test-unit
- -M
  - --skip-action-mailer
- -C
  - --skip-action-cable

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
~~~

### active\_recordを使ってmodel生成

~~~
$ sudo docker-compose exec app bundle exec rails g active_record:model member --skip-migration
~~~

### FactoryBot

~~~
$ sudo docker-compose exec app bundle exec rails g factory_bot:model user
~~~
