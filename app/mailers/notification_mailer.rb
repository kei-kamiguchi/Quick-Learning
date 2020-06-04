class NotificationMailer < ApplicationMailer

  def comment_to_user_mail(comment)
    @comment = comment

    mail to: "kei.kamiguchi517@gmail.com", subject: "#{@comment.admin.name}から質問への返事が届いています！"
  end

  def comment_to_admin_mail(comment)
    @comment = comment
    @admins = Project.find_by(id: comment.question.part.subject.project_id).admin_participation_admins
    mail to: @admins.map(&:email).join(","), subject: "#{@comment.user.name}から質問または返事が届いています！"
  end

  def question_to_admin_mail(question)
    @question = question
    @admins = Project.find_by(id: question.part.subject.project_id).admin_participation_admins
    mail to: @admins.map(&:email).join(","), subject: "#{@question.user.name}から質問または返事が届いています！"
  end

  def test_entry_mail(admin_project)
    @project = admin_project
    @users = @project.user_participation_users
    @tests = @project.tests.where(active: 1)
    mail to: @users.map(&:email).join(","), subject: "テストのURLが配布されました！"
  end
end
