require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
  	wk = Fabricate(:user)
  	visit login_path
  	fill_in "Email", with: wk.email
  	fill_in "Password", with: wk.password
  	click_button "Submit"
  	expect(page).to have_content wk.fullname
  end	
end