module ApplicationHelper

	def fulltitle(opt_title='')
		basetitle = "Connect"
		if opt_title.empty?
			basetitle
		else
			opt_title + ' | ' + basetitle
		end	
	end
end
