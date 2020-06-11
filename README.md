# README

# Quick Learning

## コンセプト
簡単に学習教材がつくれるアプリ

## 概要
オンライン学習サービスを、プログラミング知識のない人でもブログ感覚で作成することができます。

## サンプルの使い方

### 管理者(教師側)

#### 主な機能
- 学習カリキュラムの作成
- 生徒の質問への返答
- テストの運営（作成から採点まで＊なお、配点を加えた採点機能は現在実装されていません。）

#### 機能の詳細

##### 学習カリキュラムの作成
テーマごと項目を作成していきます
- カテゴリ：数学や英語などの教科に当たります
- テーマ：数学の場合は確率や関数、英語の場合は関係代名詞や仮定法といった章にあたります
- 項目：各テーマごとの最小単位で、生徒から見た場合の１ページに相当します。
生徒たちは項目を見ながら学習を進めていくことになります。
- プロジェクト：学年やクラスなどで分けたい場合に追加で作成していきます。新たに作成したプロジェクト内にはユーザーもカリキュラムも何も設定されていない状態で立ち上がります。

##### 生徒の質問への返答
生徒から質問があった場合、メールで通知が送られてきます。
質問一覧を表示することで質問への対応状況を確認することができます。
- 配色赤：対応した教師がいない状況
- 配色黄：確認はしているが返答していない状況

##### テストの運営
テーマごとにテストを作成＆実施することができます。

###### テストを作成
- タイトル：問題の大枠にあたります。
- 内容：問1、問2といった問題の細分化が必要な場合に設定します。
- 正解：正解を入力します。
- 解答欄のサイズ：生徒が入力する解答欄のサイズを選択します。

###### テストの実施
1- テスト一覧画面から実施したいテストを有効にし、配布ボタンを押すとプロジェクトに参加している生徒全員にメールが送信されます。
1- メールのURLにアクセスすることで、テスト画面に遷移することができます。
テスト中は画面遷移することができなくなり、決められた時間が経過すると自動で画面が遷移しテストは終了します。
1- 教師が採点し生徒に返却することで、テストのデータは生徒側で保管されるようになります。

### 生徒

#### 主な機能
- カリキュラムの閲覧
- わからないカリキュラムに対する質問
- テストの受講

## バージョン
Ruby 2.6.5
Rails 5.2.3

## カタログ設計
https://docs.google.com/spreadsheets/d/1_k-UFB-6Sb1FEchjiMbo6ZMwX-XbJV-OSMx5nkjBJ8g/edit?usp=sharing

## テーブル定義
https://docs.google.com/spreadsheets/d/1nwlEokdql6ozJdDMMHfTbcSMS6KVTLY0kKPvHV6kioY/edit?usp=sharing

## 画面遷移図
https://app.moqups.com/VKQTU6vcDo/view/page/aa9df7b72

## 画面ワイヤーフレーム
https://cacoo.com/diagrams/Y8E9yUbYhZFCDFXi/E710C

## ER図
https://cacoo.com/diagrams/kn8uD7ncqCcBKbtV/943B8

## 使用予定Gem
gem 'devise'
gem 'devise_invitable'
gem 'pry-byebug'
gem 'faker'
gem 'bootstrap', '~> 4.1.1'
gem 'jquery-rails'
gem 'enum_help'
gem 'rails-i18n', '~> 5.1'
gem 'ransack'
gem 'ranked-model'
gem 'jquery-ui-rails'
gem 'bullet'
gem 'capistrano', '3.6.0'
gem 'capistrano-bundler'
gem 'capistrano-rails'
gem 'capistrano-rbenv'
gem 'capistrano3-unicorn'
gem 'aws-ses'


# English Ver

# README

# Quick Leaning

## Overview
Erementary school boys & girls also be able to use this easy and this use programing only!You can write blog easy and quickly because this function is very few. Add to it, you can use code box with one click! So your job is very light.

## Concept
write blog very easy!

## Version
Ruby 2.6.5
Rails 5.2.3

## How to use



## Functions list
- [ ] Login function
- [ ] User registration function
  - [ ] Email address, name and password are required
- [ ] Password reset function
- [ ] Blog list display function
  - [ ] Show number of comments
  - [ ] Show number of favorites
- [ ] Blog post function
  - [ ] Title and article content is required
- [ ] Blog edit function
- [ ] Blog deletion function
  - [ ] Posters can only do blog edit and blog deletion
- [ ] Blog favorite function
  - [ ] You can favorite only once per one blog
  - [ ] You can't favorite your own blog
- [ ] Comment post function
- [ ] Comment deletion function
- [ ] Comment edit function
  - [ ] Only comment contributors can edit and delete comments
- [ ] The comment function and favorite function can be executed without page transition.

## Catalog design,Table_Definition,Screen transition diagram,,Wire frame
https://docs.google.com/spreadsheets/d/1_k-UFB-6Sb1FEchjiMbo6ZMwX-XbJV-OSMx5nkjBJ8g/edit?usp=sharing

## To be used Gem
* devise
* ransack
