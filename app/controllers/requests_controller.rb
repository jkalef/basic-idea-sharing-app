class RequestsController < ApplicationController

	#before action will utilize this method in the specified actions
	before_action :my_request, only: [:show, :edit, :destroy, :update, :update_status]

	#display the index page for this controller
	#show a list of all of the support requests, sorted by incomplete
	#first, with pagination
	def index	
		#----------FOR PAGINATION -----------------------------------
		#use this variable to calculate the total number of pages 
		#needed to display all of the posts
		@all = Request.all.count / 10

		#the will be passed into the pag method.  Need to convert the
		#value from params: to an interger.  Default should be zero.
		@page = params[:page].to_i || 0
		
		#pass the @page variable into pag method, and show the index
		#page again
		@requests = Request.status_sort.pag(@page, 5)
		render :index
		#-----------------------------------------------------------
	end

	#view to create a new request
	def new
		#instantiate a variable for the new request
		@request = Request.new
	end


	#action to add the new request to the database using post
	def create
		#create the new request
		@request = Request.new(request_params)

		#if the request saves, go to that request show page.  If not, return
		#to this create page displaying the error messages
		if @request.save 
			redirect_to request_path(@request), noticed: "support ticket created successfully"
		else
			render :new
		end
	end


	#action to show the specific request
	def show
		#before_action will grab the ticket by its id
	end

	#action to edit the ticket (just the view)
	def edit
		#before_Action will grab the ticket by its id
	end

	#action to update the ticket (patch)
	def update

		@complete = params[:status] == "complete"
		#before_action will grab the ticket by its id
		#need to add in the params to update the request using strong params
		#if it updates, go to the show page.  If not, stay on same page and
		#display error messages
		if @request.update(request_params)
			#show a message saying it's been updated
			redirect_to requests_path, notice: "record updated successfully"
		else
			render :edit
		end
	end

	#action to delete a support ticket (delete)
	def destroy
		#before_action will grab the ticket by its id
		@request.destroy
		#go back to the request listing page, and show a notice that it has
		#been successfully deleted
		redirect_to requests_path, notice: "Record Deleted Successfully"
	end


	#search action, as defined in the model
	#use pagination as well
	def search
		#use this variable to calculate the total number of pages 
		#needed to display all of the requests
		@all = Request.search_query(params[:input]).count / 10

		#the will be passed into the pag method.  Need to convert the
		#value from params: to an interger.  Default should be zero.
		@page = params[:page].to_i || 0

		#store the results in an array, results, and render the search
		#results on a new page, search.html.erb, adding the pagination method
		@result = Request.search_query(params[:input]).pag(@page, 5)
		render :search
	end


	#private methods only to be used for this class
	private

	#strong params
	def request_params
		request_params = params.require(:request).permit(:name, :email, :department, 
																	:message, :status)
	end


	#getting a request by its specific id
	def my_request
		@request = Request.find(params[:id])
	end



end
