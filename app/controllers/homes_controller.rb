class HomesController < ApplicationController
  def top
  end

  def about
  end

  def guest_sign_in
    user = User.find_or_create_by!(
      name: 'ゲスト',
      email: 'guest@example.com',
      introduction: 'ゲストの髪質'
    ) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
    sign_in user
    #byebug
    redirect_to user_path(user), notice: 'ゲストユーザーとしてログインしました。'
  end

end
