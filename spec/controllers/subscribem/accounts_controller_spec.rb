require 'rails_helper'

module Subscribem
  RSpec.describe AccountsController, type: :controller do

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

  end
end
