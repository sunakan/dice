# dice

## Dockerfileの個人的ポイント

- build-essentialとlibpq-devはnokogiri等のため
  - nokogiriはrailsに必要

- dockerコンテナの中で1度bundle install --path=vendor/bundle
  - このディレクトリはdocker-compose.ymlにvolumeとして記述
    - キャッシュが効くようになる
  - コンテナ内でbundle installをした理由は、ホスト側にbundlerがない前提のため
    - 次からDockerfileに記述する(次からGemfile, Gemfile.lockもあるからOK)
