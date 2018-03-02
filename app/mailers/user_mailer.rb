class UserMailer < ApplicationMailer

  default from: 'no-reply@jungle.com'
 
  def order_email(user, order)
    @order = order
    mail(to: user.email, subject: "Thank you for your order n. #{order.id}")
  end    
end
