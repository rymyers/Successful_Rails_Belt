class GroupsController < ApplicationController
    def new
        group = Group.new(group_params)
        if group.save
            num = group.id
            Member.create(user_id:session[:user_id],group_id:num)
            redirect_to :back
        else
            flash[:errors] = group.errors.full_messages
            redirect_to :back
        end
    end

    private

    def group_params
        params.require(:group).permit(:name, :members, :info, :owner)
    end
end
