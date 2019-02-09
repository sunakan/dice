# dice

## Dockerfileの個人的ポイント

- build-essentialとlibpq-devはnokogiri等のため
  - nokogiriはrailsに必要

- ほんとに最初はdocker-container run app bashでコンテナ内で少しだけ作業
  - (bundle initや1番最初のbundle install, rails newの時にもするかも)

- dockerコンテナの中で1度bundle install --path=vendor/bundle
  - このディレクトリはdocker-compose.ymlにvolumeとして記述
    - キャッシュが効くようになる
  - コンテナ内でbundle installをした理由は、ホスト側にbundlerがない前提のため
    - 次からDockerfileに記述する(次からGemfile, Gemfile.lockもあるからOK)

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
