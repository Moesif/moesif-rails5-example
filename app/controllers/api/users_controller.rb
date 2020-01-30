module Api
  class UsersController < ApplicationController
    protect_from_forgery

    def initialize
      @api_client = MoesifApi::MoesifAPIClient.new(Blog::Application::moesif_options['application_id']).api
    end

    def new
      @users = Users.new
    end

    def create
      metadata = {
        :email => 'john@acmeinc.com',
        :first_name => 'John',
        :last_name => 'Doe',
        :title => 'Software Engineer',
        :salesInfo => {
            :stage => 'Customer',
            :lifetime_value => 24000,
            :accountOwner => 'mary@contoso.com',
        }
      }
      
      # Campaign object is optional, but useful if you want to track ROI of acquisition channels
      # See https://www.moesif.com/docs/api#users for campaign schema
      campaign = MoesifApi::CampaignModel.new()
      campaign.utm_source = "google"
      campaign.utm_medium = "cpc"
      campaign.utm_campaign = "adwords"
      campaign.utm_term = "api+tooling"
      campaign.utm_content = "landing"
      
      # Only user_id is required.
      # metadata can be any custom object
      user = MoesifApi::UserModel.new()
      user.user_id = params[:id]
      user.company_id = "67890" # If set, associate user with a company object
      user.campaign = campaign
      user.metadata = metadata
      
      update_user = @api_client.update_user(user)

      render :json => "", status: :created
    end

    def show
    end

    def index
    end 

    private

    def users_params
      params.require(:id)
    end
  end
end
  