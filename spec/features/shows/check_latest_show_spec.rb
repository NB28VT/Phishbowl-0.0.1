require 'rails_helper'


feature "Check latest show, "%(

As a poor Phishhead who doesn't have any money to go on tour, I'd like to be
able to automatically have the app check my predictions based on the most
current show.
  Acceptance criteria:
   [ ] A User should be able to visit a dashboard page and see the latest setlist (as a partial)
   [ ] A User should be able to view a list of upcoming shows
   [ ] A User should be able to submit a prediciton for a show
   [ ] A user can edit predictions before 7 p.m. the day of show.
   [ ] A user can't edit predicitons after 7 p.m. the day of the show.
) do

  scenario "A user sees the setlist from the most recent show" do
    visit dashboard_index_path

    expect(page).to have_content("Latest Show")
  end
