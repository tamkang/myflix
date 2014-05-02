class RelationshipsController < ApplicationController
  before_filter :require_user
  def index
 	@relationships = current_user.following_relationships
  end

  def create
  	leader = User.find(params[:leader_id])
	relationship = Relationship.create(leader_id: params[:leader_id], follower_id: current_user.id) unless current_user.follows?(leader) || current_user.id == leader.id
  	redirect_to people_path
  end

  def destroy
  	relationship = Relationship.find(params[:id])
  	relationship.destroy if relationship.follower == current_user
    redirect_to people_path
  end
end