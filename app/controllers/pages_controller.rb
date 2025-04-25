class PagesController < ApplicationController
  def about
    @page = StaticPage.find_by(title: 'About')
  end
  
  def contact
    @page = StaticPage.find_by(title: 'Contact')
  end
  
end
