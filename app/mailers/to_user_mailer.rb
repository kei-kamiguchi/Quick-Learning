class ToUserMailer < ApplicationMailer
  def comment_mail(comment)
    @comment = comment

    mail to: "kei.kamiguchi517@mail.com", subject: "お問い合わせの確認メール"
  end
end
