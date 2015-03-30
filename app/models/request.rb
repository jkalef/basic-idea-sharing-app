class Request < ActiveRecord::Base

	#--VALIDATIONS-------------------------------------
	#validate for presence of name and email
	validates :name, :email, presence: true

	#--------------------------------------------------


	#--CALLBACKS---------------------------------------
	#on initialization, set the default status to be incomplete
	#see class method below
	after_initialize :set_defaults

	#--------------------------------------------------


	#--CLASS METHODS--------------------------------------
	#search method to search by email, name and message
	#this will find emails, names, or messages with a given string of characters
	def self.search_query(input)
		#create a query to search for a specific term, input by the user
		where("name LIKE ? OR email LIKE ? or message LIKE ?", "%#{input}%", "%#{input}%", "%#{input}%")
	end

	#this method will sort by incomplete tasks first
	def self.status_sort
		#show the incomplete tasks on top
		#should sort alphabetically for the status column, so incomplete
		#tasks show first
		order(status: :DESC)
	end

	#this will add pagination and show 5 results per page
	#used for both index page and search results page
	def self.pag(page, per_page = 5)
			offset(page * per_page).first(per_page)
	end


	#--PRIVATE CLASS METHODS ------------------------------------

	private

	#this method will set the default value of status to incomplete
	def set_defaults
		self.status ||= "incomplete"
	end

	#-----------------------------------------------------

end
