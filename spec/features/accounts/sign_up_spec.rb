require 'rails_helper'
feature 'Accounts' do
  scenario 'creating an account' do
    do_register_movements('Test', 'test', 'test@test.com')
    success_message = 'Your account has been successfully created.'

    expect(page).to have_content(success_message)
    expect(page).to have_content("Signed in as test@test.com")
    expect(page.current_url).to eq('http://test.example.com/')
  end

  scenario 'ensure subdomain uniqueness' do
    Subscribem::Account.create!(subdomain: 'test', name: 'Test')
    do_register_movements('Test', 'test', 'test@test.com')

    expect(page.current_url).to eq('http://www.example.com/accounts')
    expect(page).to have_content('Sorry, your account could not be created.')
    expect(page).to have_content('Subdomain has already been taken')
  end

  scenario 'subdomain with restricted name' do
    do_register_movements('Test', 'admin', 'test@test.com')

    expect(page.current_url).to eq('http://www.example.com/accounts')
    expect(page).to have_content('Sorry, your account could not be created.')
    expect(page).to have_content('Subdomain is not allowed. Please choose another subdomain.')
  end

  scenario 'subdomain with restricted name' do
    do_register_movements('Test', '<admin>', 'test@test.com')

    expect(page.current_url).to eq('http://www.example.com/accounts')
    expect(page).to have_content('Sorry, your account could not be created.')
    expect(page).to have_content('Subdomain is not allowed. Please choose another subdomain.')
  end

  def do_register_movements(name, subdomain, email)
    visit subscribem.root_path
    click_link 'Account Sign Up'
    fill_in 'Name', with: name
    fill_in 'Subdomain', with: subdomain
    fill_in 'Email', with: email
    fill_in 'Password', with: '00000000'
    fill_in 'Password confirmation', with: '00000000'
    click_button 'Create Account'
  end
end
