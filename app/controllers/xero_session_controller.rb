class XeroSessionController < ApplicationController

    before_filter :get_xero_client

    public

        def new
            puts '##############################################In new ##########################'
            request_token = @xero_client.request_token(:oauth_callback => 'http://localhost:3000/xero_session/create')
            session[:request_token] = request_token.token
            session[:request_secret] = request_token.secret
            redirect_to request_token.authorize_url 
            puts '##############################################request token assigned ##########################'
            puts request_token.authorize_url 

        end

        def create
            puts '##############################################In create ##########################'
            @xero_client.authorize_from_request(
                    session[:request_token], 
                    session[:request_secret], 
                    :oauth_verifier => params[:oauth_verifier] )

           contacts = @xero_client.Contact.all
            flash[:notice] = "all xero clients"

            logger.debug(contacts)
             contacts = @xero_client.Contact.all
             redirect_to "users/index"
            flash[:notice] = "all xero clients"
            
        end

        def destroy
            session.data.delete(:xero_auth)
        end

        def sample
            # @xero_client = Xeroizer::PublicApplication.new('RHEAGGF6GJJA2VOKZLTY6HNZ5NZY1F', 'PSGGP2D7VGOY1ROFDC7HVQRLFSYOCH')

            # request_token = @xero_client.request_token(:oauth_callback => 'http://localhost:3000/users')
            # puts request_token.token
            # puts request_token.secret
            # redirect_to request_token.authorize_url
            # session[:request_token] = request_token.token
            # session[:request_secret] = request_token.secret
            #  @xero_client.authorize_from_request(request_token.token, request_token.secret, :oauth_verifier => params[:oauth_verifier])
            #  session[:xero_auth] = {
            #         :access_token => @xero_client.access_token.token,
            #         :access_key => @xero_client.access_token.key }
            # contacts = @xero_client.Contact.all
            # client = Xeroizer::PublicApplication.new('RHEAGGF6GJJA2VOKZLTY6HNZ5NZY1F', 'PSGGP2D7VGOY1ROFDC7HVQRLFSYOCH')
            # if session[:xero_auth]
            #     client.authorize_from_access(
            #         session[:xero_auth][:access_token], 
            #         session[:xero_auth][:access_key] )
            # end
            #  client.authorize_from_request(
            #         session[:request_token], 
            #         session[:request_secret], 
            #         :oauth_verifier => params[:oauth_verifier] )

            # session[:xero_auth] = {
            #         :access_token => client.access_token.token,
            #         :access_key => client.access_token.key }
            # # Retrieve list of contacts (note: all communication must be made through the client).
            puts '##############################################In sample controller ##########################'
            @xero_client.authorize_from_request(request_token.token, request_token.secret, :oauth_verifier => params[:oauth_verifier])
            contacts = @xero_client.Contact.all(:order => 'Name')
            puts contacts
            flash[:notice] = "all xero clients"
        end

    private

        def get_xero_client
            @xero_client = Xeroizer::PublicApplication.new('RHEAGGF6GJJA2VOKZLTY6HNZ5NZY1F', 'PSGGP2D7VGOY1ROFDC7HVQRLFSYOCH')
            # Add AccessToken if authorised previously.
            if session[:xero_auth]
                @xero_client.authorize_from_access(
                    session[:xero_auth][:access_token], 
                    session[:xero_auth][:access_key] )
            end
        end
end