module ApplicationHelper

  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "BarShare"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def comment_height(cnt)
    cnt == 0 ? 100 : 300
  end
end