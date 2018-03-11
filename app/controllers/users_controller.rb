class UsersController < ApplicationController
  before_action :find_user, only: %i[show update destroy]
  
  def create
    address_params = address_service.full_address
    @user = User.create!(name: user_params[:name], email: user_params[:email])
    @user.create_address!(address_params)
    json_response({ user: @user, address: @user.address }, :created)
  end
    
  def show
    json_response({ user: @user, address: @user.address })
  end
    
  def update
    address_params = address_service.full_address
    @user.update!(name: user_params[:name], email: user_params[:email])
    @user.address.update!(address_params)
    json_response({ user: @user, address: @user.address })
  end
    
  def destroy
    @user.destroy
    json_response({ user: 'deleted' })
  end
    
  private
    
  def user_params
    params.permit(:name, :email, :cep, :number, :complement) 
  end
  
  def address_service
    AddressService.new(cep: user_params[:cep],
                       number: user_params[:number],
                       complement: user_params[:complement])
  end
  
  def find_user
    @user = User.find(params[:id])
  end
end
