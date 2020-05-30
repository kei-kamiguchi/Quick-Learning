# README

# Quick Learning

## コンセプト
簡単に学習教材がつくれるアプリ

## 概要
オンライン学習サービスを、プログラミング知識のないクライアントでも簡単に作成することができるアプリ。

## サンプルの使い方
「admin(管理者)の使用の流れ」
1.「admin/sign in」から、ゲストログインでログインします。
2.デモデータとしてあらかじめ作成されているカリキュラムがprojectとして登録されています。

「機能の大枠」
・教材の作成
・テストの作成＆確認＆返却
・質問のやりとり
・管理者＆生徒をメールで招待
・プロジェクトを追加することで学年orクラスなど細分化が可能
・カテゴリを追加することで教科ごとにカリキュラムの作成が可能

「user(生徒)の使用の流れ」
1.「user/sign in」から、ゲストログインでログインします。
2.左上のハンバーガーメニューから招待したadminユーザーのプロジェクトのカリキュラムを閲覧することができます。
3.各partごとに設置されたタイトル横の「質問する」からテキストに対して質問をすることができます。
4.質問への回答があった場合、アラートで知らせます。
5.返却されたテストデータもユーザー側で管理でき、メモなども追加できます。

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
gem 'ransack'
gem 'ranked-model'
gem 'jquery-ui-rails'
gem 'bullet'

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
