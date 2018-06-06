module ApplicationHelper

	def fulltitle(opt_title='')
		basetitle = "ROR"
		if opt_title.empty?
			basetitle
		else
			opt_title + ' | ' + basetitle
		end	
	end
end
