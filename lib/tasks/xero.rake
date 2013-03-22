require 'rubygems'
require 'xeroizer'

# Create client (used to communicate with the API).
# client = Xeroizer::PublicApplication.new(YOUR_OAUTH_CONSUMER_KEY, YOUR_OAUTH_CONSUMER_SECRET)

# Retrieve list of contacts (note: all communication must be made through the client).
# contacts = client.Contact.all(:order => 'Name')

namespace :xero do
  desc "Test Xero sync"
  task :test => :environment do
		puts 'Syncing'
		client = Xeroizer::PublicApplication.new('FVWZC6GMMXJX3LCSWU92EFCSKEBEP6', 'KCZ3HRPOMPKXTNDLRETLK39QVGCG0O')
		puts '#########################client initialized############################'
		request_token = client.request_token(:oauth_callback => 'localhost')
		puts '#########################request token############################'

		# 2. Redirect the user to the URL specified by the RequestToken.
		#    
		#    Note: example uses redirect_to method defined in Rails controllers.
		# stop redirection
		# request_token = @xero_client.request_token(:oauth_callback => 'http://10.2.10.111:3000/xero_session/create')
		# puts '#########################request token############################'
		request_token.authorize_url

		# 3. Exchange RequestToken for AccessToken.
		#    This access token will be used for all subsequent requests but it is stored within the client
		#    application so you don't have to record it. 
		#
		#    Note: This example assumes the callback URL is a Rails action.
		# client.authorize_from_request(request_token.token, request_token.secret, :oauth_verifier => params[:oauth_verifier])
		contacts = client.Contact.all
		puts contacts
  end

  # desc 'Test Xero calls'
  # task :calls => :environment do
  #   puts 'Test calls'
  #   client = Xero::Client.new(User::Member.first)
  #   client.date = Date.today.months_ago(1)
  #   puts Date.today.months_ago(1).strftime('%d-%m-%Y')
  #   puts 'issues_invoices: ' + client.issues_invoices.to_s
  #   puts 'breakeven_inventory_purchases: '+client.breakeven_inventory_purchases.to_s
  #   puts 'income_account: '+client.income_on_account.to_s
  #   puts 'cost_of_sales_subcontractors: '+client.cost_of_sales_subcontractors.to_s
  #   puts 'cost_of_sales_materials: '+client.cost_of_sales_materials.to_s
  # end
end