class CorporationInviteMailer < ApplicationMailer
	default from: "guilotmsc@gmail.com"

	def corporation_invite_email
    	@corporation = params[:corporation]
	    @url  = 'http://localhost:3000'
	    @user_from = User.current
	    @resource = params[:email]

	    mail(to: params[:email], subject: 'Effectime - Novo convite')
	end
end
