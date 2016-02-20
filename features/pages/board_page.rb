class BoardPage < BladesDBPage
    PAGE_TITLE = BladesDBPage::PAGE_TITLE

    def check_for_message(from: nil, containing_text: nil, containing_link: nil, relating_to_game: nil)
        message_div = page.find("div.message")
        if from
            message_div.find("p.attrib").find("a").has_content?(from.name)
        end
        if containing_text
            message_div.find("div.messagebody").has_content?(containing_text)
        end
        if containing_link
            message_div.find("div.messagebody").has_link?(relating_to_game.title, :href => containing_link)
        end
    end
end
