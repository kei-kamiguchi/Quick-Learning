1.times do |n|
  name = Faker::Name.name
  email = "admin#{n}@example.com"
  password = "password"
  Admin.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: 1
               )
end
1.times do |n|
  name = Faker::Name.name
  email = "user#{n}@example.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               invited_by_id: 1,
               )
end
Admin.all.each do |admin|
  admin.projects.create!(
    title: 'Ruby on Rails',
    admin_id: admin.id,
  )
end
AdminParticipation.create!(admin_id: 1, project_id: 1)
UserParticipation.create!(user_id: 1, project_id: 1)
1.times do |n|
  title = "未分類"
  Category.create!(title: title, project_id: 1)
end
subjects = ["1RailsのためのRuby入門","2Railsアプリケーションをのぞいてみよう","3タスク管理アプリケーションを作ろう","4現実の複雑さに対応する","5テストをはじめよう","6Railsの全体像を理解する","7機能を追加してみよう","8RailsとJavaScript","9複数人でRailsアプリケーションを開発する","10Railsアプリケーションと長く付き合うために"]
subject_num = subjects.size
subject_num.times do |n|
  title = subjects[n]
  Project.all.each do |project|
    project.subjects.create!(
      title: title,
      project_id: project.id,
      category_id: 1
    )
  end
end
parts_1 = ["1-1 オブジェクトを理解しよう","1-2 自分でクラスを作ってみよう","1-3 Rubyプログラムの基礎知識","1-4 少し高度なテクニック","1-5 似たところのあるクラスを作りたいとき","1-6 プログラムの異常を検知しよう"]
part_num = parts_1.size
part_num.times do |n|
  title = parts_1[n]
  content = "サンプルなし"
  Subject.find(1).parts.create!(
      title: title,
      content: content,
      subject_id: 1
  )
end
parts_2 = ["2-1 コマンド実行環境を準備しよう","2-2 rbenvをインストールしよう","2-3 Rubyのインストール","2-4 Railsのインストール","2-5 データベースのインストールとセットアップ","2-6 Railsに触れてみよう"]
part_num = parts_2.size
part_num.times do |n|
  title = parts_2[n]
  content = "サンプルなし"
  Subject.find(2).parts.create!(
      title: title,
      content: content,
      subject_id: 2
  )
end
titles = ["オブジェクトの考え方について","クラスについて","RESTについて"]
contents = ["オブジェクトのイメージが掴めないのですが、どうすればいいですか？","クラスのinitializeの意味がわかりません！","RESTfulな設計とはどういう意味ですか？"]
3.times do |n|
  title = titles[n]
  content = contents[n]
  Question.create!(title: title, content: content, user_id: 1, part_id: 1)
end
1.times do |n|
  title = "サンプルテスト"
  Test.create!(title: title, subject_id: 1, project_id: 1)
end
titles = ["オブジェクトについての説明で正しいものを選択せよ","クラスについての説明で正しいものを選択せよ","RESTについて"]
contents = ["1.ruby特有の考え方\n2.人間界のあらゆるものを抽象化した表現\n3.文字列と数値は含まれない","1.クラスはオブジェクトである\n2.クラスはプロジェクト内で1つしか作成できない","RESTfulについて簡単に説明せよ"]
correct_answers = [2,1,"HTTPプロトコル経由で自由にCURD（作成/読み出し/更新/削除）できる（分類された）データ群"]
3.times do |n|
  title = titles[n]
  content = contents[n]
  correct_answer = correct_answers[n]
  TestQuestion.create!(title: title, content: content, correct_answer: correct_answer, test_id: 1)
end
