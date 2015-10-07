require 'spec_helper'

describe "Editing todo lists" do
    let!(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list.")}
    
    def update_todo_list(options={})
        options[:title] ||= "New title"
        options[:description] ||= "New description"
        todo_list = options[:todo_list]
        visit "/todo_lists"
        within "#todo_list_#{todo_list.id}" do
            click_link "Edit"
        end
        fill_in "Title", with: options[:title]
        fill_in "Description", with: options[:description]
        click_button "Update Todo list"
        todo_list.reload
    end
    
    it "updates a todo list successfully with correct information" do
        update_todo_list     todo_list: todo_list
        expect(page).to have_content("Todo list was successfully updated")
        expect(todo_list.title).to eq("New title")
        expect(todo_list.description).to eq("New description")
    end
    
    it "displays an error with no title" do
        update_todo_list    todo_list: todo_list,
                            title: ""
        expect(page).to have_content("error")
    end
    
    it "displays an error with a title shorter than 3 characters" do
        update_todo_list    todo_list: todo_list,
                            title: "Hi"
        expect(page).to have_content("error")
    end
    
    it "displays an error with no description" do
        update_todo_list    todo_list: todo_list,
                            description: ""
        expect(page).to have_content("error")
    end
    
    it "displays an error with a description shorter than 5 characters" do
        update_todo_list    todo_list: todo_list,
                            description: "1234"
        expect(page).to have_content("error")
    end
end