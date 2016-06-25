class UserMailer < ApplicationMailer
  default from: "sabrown84@gmail.com"

  def new_comment(user, wiki)
    headers["Message-ID"] = "<wikis/#{wiki.id}@blocipedia.example>"

    @user = user
    @wiki = wiki

    mail(to: user.email, subject: "New comment on #{wiki.title}")
  end
end
