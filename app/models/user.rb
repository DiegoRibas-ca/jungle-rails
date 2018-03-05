class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, 
          # you only need presence on create
          :presence => { :on => :create },
          # allow_nil for length (presence will handle it on create)
          :length   => { :minimum => 6, :allow_nil => true },
          # and use confirmation to ensure they always match
          :confirmation => true
  validates :email,
          :presence => true,
          :format => { :with => email_regex },
          :uniqueness => { :case_sensitive => false }

  def authenticate_with_credentials(email, password) 
    @user = User.find_by_email(email.strip.downcase)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
