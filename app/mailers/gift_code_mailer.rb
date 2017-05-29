class GiftCodeMailer < ApplicationMailer
  default from: 'kanji.yy@gmail.com'

  def send_gift_email(customer, gift_code)
    @customer = customer
    @user = @customer.user
    @code = gift_code.code
    mail(to: @customer.email,
         subject: @user.site_name + '：ギフトコード送付のお知らせ。')
  end
end
