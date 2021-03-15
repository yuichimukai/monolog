class UsersController < ApplicationController
	# before_action :set_user, only: %i[show edit update]
	# def edit
	# 	redirect_to user_path(@user) unless @user == current_user
	# end
	# def update
	# 	if current_user.update(user_params)
	# 		redirect_to user_path(current_user)
	# 	else
	# 		redirect_to edit_user_path
	# 	end
	# end
	# def user_params
	# 	params.fetch(:user, {}).permit(:username)
	# end
end
