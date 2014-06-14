Given(/^a restricted page$/) do
  @page = Page.create(title: "Restricted Page", content: "Hello World!", show_to_non_users: false)
end

Given(/^I am on the home page$/) do
  visit root_path
end

Given(/^I go to my profile page$/) do
  visit user_profile_path
end

Given(/^I go to their profile page$/) do
  visit user_path(@other_user)
end

When(/^I go to the registration page$/) do
  visit new_user_registration_path
end

Then(/^I go to the Change Password page$/) do
  visit edit_user_registration_path
end

When(/^I go to the page$/) do
  visit page_path(@page)
end

Then(/^the home page is displayed$/) do
  current_path.should == root_path
end

Then(/^the login page is displayed$/) do
  current_path.should == new_user_session_path
end

Then(/^I am on the "(.*?)" profile page for "(.*?)"$/) do |actor, name|
  if actor == "User"
    page.find("h1").should have_content("Profile")
  elsif actor == "Character"
    page.find("h1").should have_content("Character Sheet")
  else
    # Do nothing - this is for games. 
  end
  page.find("li#name").find("div.fieldcontents").should have_content(name)
end
