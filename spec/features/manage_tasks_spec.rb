require 'rails_helper'

feature 'Manage Tasks', js: true do
  before(:each) do
    visit todos_path
    sleep(1)
  end

  after(:each) do
    sleep(1)
  end

  scenario 'add a new task' do
    fill_and_submit
    expect(page).to have_content("lalala")
  end

  scenario 'counter changes' do
    fill_and_submit
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end

  scenario 'complete a task' do
    fill_and_submit
    check_todo('1')
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
  end

  scenario 'adding and completing multiple tasks' do
    fill_3_check_2

    expect(page.find(:css, 'span#todo-count').text).to eq '1'
    expect(page.find(:css, 'span#completed-count').text).to eq '2'
    expect(page.find(:css, 'span#total-count').text).to eq '3'
  end

  scenario 'clean up marked todos' do
    fill_3_check_2
    sleep(3)
    click_link("clean-up")

    expect(page.find(:css, 'span#total-count').text).to eq '1'
  end
end


def fill_and_submit
  fill_in('todo_title', with: 'lalala')
  page.execute_script("$('form#new_todo').submit()")
end

def check_todo(todo)
  check("todo-#{todo}")
end

def fill_3_check_2
  visit todos_path

  fill_and_submit
  fill_and_submit
  fill_and_submit

  check_todo("1")
  check_todo("2")
end
