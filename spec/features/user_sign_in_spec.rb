require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
  	wk = Fabricate(:user)
  	sign_in(wk)
  	expect(page).to have_content wk.fullname
  end	
end