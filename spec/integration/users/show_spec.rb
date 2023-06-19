require 'rails_helper'

RSpec.feature 'User show page' do
  scenario 'displays user profile picture, name, number of posts, bio, and first 3 posts' do
    user = FactoryBot.create(:user)
    posts = FactoryBot.create_list(:post, 5, author: user)

    visit user_path(user)

    expect(page).to have_selector("img[src='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.posts.count}")
    expect(page).to have_content(user.bio)

    expect(page).to have_content(posts[0].title)
    expect(page).to have_content(posts[1].title)
    expect(page).to have_content(posts[2].title)
    expect(page).not_to have_content(posts[3].title)
    expect(page).not_to have_content(posts[4].title)

    expect(page).to have_link('See all posts', href: user_posts_path(user))
  end

  scenario 'clicking on a post redirects to that post\'s show page' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, author: user)

    visit user_path(user)
    click_link post.title

    expect(current_path).to eq(user_post_path(user, post))
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.text)
  end

  scenario 'clicking on "See all posts" redirects to the user\'s posts index page' do
    user = FactoryBot.create(:user)

    visit user_path(user)
    click_link 'See all posts'

    expect(current_path).to eq(user_posts_path(user))
    expect(page).to have_content("#{user.name}'s posts")
  end
end
