require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content:'Lorem Ipsum')
  end

  test'Micropost should be valid' do
    assert @micropost.valid?
  end
  test 'user id should be present' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  test 'content should be valid' do
    @micropost.content = " "
    assert_not @micropost.valid?
  end
  test 'content should be maximum 140 characters' do
    @micropost.content = 'a' * 141
    assert_not @micropost.valid?
  end
  test 'order should be most recent first' do
    assert_equal Micropost.first, microposts(:most_recent)
  end
  
end
