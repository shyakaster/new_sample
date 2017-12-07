require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example user", email:"example@email.com",
    password: "foobar", password_confirmation: "foobar")
  end
  test 'user should be valid' do
    assert @user.valid?
  end
  test 'user should be present' do
    @user.name = ' '   
    assert_not @user.valid?
  end
    test 'email should be present' do
    @user.email = ' '   
    assert_not @user.valid?
  end
  test 'name should be not more than 50 characters' do
    @user.name = 'a'* 51

    assert_not @user.valid?
  end
  test 'email should be not more than 255 characters' do
    @user.email = 'a'* 256 + '@example.com'

    assert_not @user.valid?
  end

  test 'email validation should accept valid email addresses' do
    valid_emailaddresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

    valid_emailaddresses.each do |valid_emailaddress|
      @user.email = valid_emailaddress
      assert @user.valid?, "#{valid_emailaddress.inspect} is a valid email address"
    end
  end

  test 'email validation should not accept invalid email addresses' do
    invalid_emailaddresses =  %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_emailaddresses.each do |invalid_address|
    @user.email = invalid_address
    assert_not @user.valid?, "#{ invalid_address} is an invalid email address"
    end
  end
  test 'email address should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?

  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
  test "authenticated? should return false for a user with nil digest" do
  assert_not @user.authenticated?('')
end
 
end
