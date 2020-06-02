class ToUserFromAdminMailer < ApplicationMailer
  def contact_mail(comment)
    @comment = comment

    mail to: "kei.kamiguchi517@gmail.com", subject: "お問い合わせの確認メール"
  end
end
