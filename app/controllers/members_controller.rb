class MembersController < ApplicationController

    def join
        mem = Member.new(member_params)
        mem.save
        number = Group.find(params[:group_id]).members
        Group.find(params[:group_id]).update(members:number + 1)
        redirect_to :back
    end

    private

      def member_params
          params.require(:mem).permit(:user_id, :group_id)
      end
end
