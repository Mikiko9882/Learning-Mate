module ApplicationHelper
  def page_title(page_title = '', teacher = false, admin = false)
    base_title = if teacher
                   'Learning Mate(先生画面)'
                 elsif admin
                   'Learning Mate(管理者画面)'
                 else
                   'Learning Mate'
                 end
  
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end
end
