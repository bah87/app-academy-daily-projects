require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit(new_user_url)
    expect(page).to have_content('Sign Up!')
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
    expect(page).to have_button('Sign Up')
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      signup_user
      expect(page).to have_content('hellouser')
    end

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    User.create(username: 'hellouser', password: 'password')
    login_user
    expect(page).to have_content('hellouser')
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit(users_url)
    expect(page).to have_content('Log In')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    User.create(username: 'hellouser', password: 'password')
    login_user
    click_button('Logout')
    expect(page).to have_content('Log In')
    expect(page).not_to have_content('hellouser')
  end

end