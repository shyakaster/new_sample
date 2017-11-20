module ApplicationHelper
    # Returns the base title if the page_title is empty for all the pages

    def full_title(page_title = '')
        base_title = "Ruby on Rails Tutorial"
        if page_title.empty?
            base_title
        else
            page_title + " | " + base_title
        end
    end
end
