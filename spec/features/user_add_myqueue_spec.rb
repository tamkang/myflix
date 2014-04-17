require 'spec_helper'

feature 'User adds video to myqueue' do 
  scenario 'with authenticated user' do
  	category = Fabricate(:category)
  	video1 = Fabricate(:video, title: "video1", category: category)
  	video2 = Fabricate(:video, title: "video2", category: category)
  	video3 = Fabricate(:video, title: "video3", category: category)

  	wk = Fabricate(:user)
  	sign_in(wk)
  	find("a[href='/videos/#{video1.id}']").click
  	expect(page).to have_content video1.title

    click_link "+ My Queue"
    expect(page).to have_content video1.title
  end	
end
