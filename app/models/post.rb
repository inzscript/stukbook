class Post < ActiveRecord::Base
    
    include PublicActivity::Model
    include AutoHtmlFor
    
    belongs_to :user
    validates_presence_of :user_id
    validates_presence_of :content
    
    #config auto generate html gem
    auto_html_for :content do
        html_escape
        image
        youtube(width: "100%", height: 250, autoplay: false)
        link target: "_blank", rel: "nofollow"
        simple_format
    end
end
