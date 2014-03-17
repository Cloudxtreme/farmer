class SearchController < ApplicationController

  def index

    @q = params[:q]
    @results  = [ ]

    unless @q.nil? or @q.size.zero?
      @results += Location.where( 'search_index like ?', "%#{@q}%" )
      @results += RackMount.where( 'search_index like ?', "%#{@q}%" )
      @results += Server.where( 'search_index like ?', "%#{@q}%" )
      @results += Vm.where( 'search_index like ?', "%#{@q}%" )

      p @results.inspect
      
      unless @results.size.zero?
        @results.sort! { |a,b| a.search_index.index( @q ) <=> b.search_index.index( @q ) }
      end
    else
    end
  end

end
