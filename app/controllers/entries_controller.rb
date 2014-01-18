class EntriesController < ApplicationController
  before_filter :authenticate_user!

	def create
		@entry = Entry.new(entry_params.merge(user_id: current_user.id, date: Date.today))
    @entry.save
    respond_with @entry
	end
  
	def update
		@entry = current_user.entries.find(params[:id]).first
    if @entry.update_attributes(entry_params)
      render json: {id: @entry.id}, status: 200
    else
      respond_with @entry
    end
	end

	def show
    if params[:by_date]
      @entry = Entry.by_date(key: Date.parse(params[:id])).first
      render(json: {id: @entry.try(:id)})
    else
      @entry = Entry.find(params[:id])
      @entry ? respond_with(@entry) : four_oh_four
    end    
	end
  
  private
  def entry_params    
    params.require(:entry).permit(
      catalogs: [],
      responses: [:id, :value],
      treatments: [:name]
    )
  end
end
