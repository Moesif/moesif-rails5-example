module Api
    class CompaniesController < Api::BaseController
        protect_from_forgery

        def initialize
        @api_client = MoesifApi::MoesifAPIClient.new(Blog::Application::moesif_options['application_id']).api
        end

        def new
            @companies = Companies.new
        end

        def create
            metadata = {
                :org_name => 'Acme, Inc',
                :plan_name => 'Free',
                :deal_stage => 'Lead',
                :mrr => 24000,
                :demographics => {
                    :alexa_ranking => 500000,
                    :employee_count => 47
                }
            }
            
            # Campaign object is optional, but useful if you want to track ROI of acquisition channels
            # See https://www.moesif.com/docs/api#update-a-company for campaign schema
            campaign = MoesifApi::CampaignModel.new()
            campaign.utm_source = "google"
            campaign.utm_medium = "cpc"
            campaign.utm_campaign = "adwords"
            campaign.utm_term = "api+tooling"
            campaign.utm_content = "landing"
            
            # Only company_id is required.
            # metadata can be any custom object
            company = MoesifApi::CompanyModel.new()
            company.company_id = params[:id]
            company.company_domain = "acmeinc.com" # If domain is set, Moesif will enrich your profiles with publicly available info 
            company.campaign = campaign
            company.metadata = metadata
            
            update_company = @api_client.update_company(company)
        
            render :json => "", status: :created
        end

        def show
        end
    
        def index
        end 
    
        private
    
        def companies_params
          params.require(:id)
        end

    end
end