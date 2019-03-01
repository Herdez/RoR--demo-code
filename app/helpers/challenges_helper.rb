module ChallengesHelper


   ...

	def answer_status(answer)
		if answer.correct
			"Correcto"
		elsif answer.correct.nil?
			"Pendiente"
		else
			"Incorrecto"
		end
	end

	def challenge_answered_lable(challenge)

		if challenge.gradable
			status = challenge.answered_correctly?(current_user.id)
			
			if status == true
				if challenge.any_commets_on_correct?(current_user.id)			  	
			  	"<span class='label label-success'>Correcto  <i class='fa fa-comment'></i></span>"
			  else
				  "<span class='label label-success'>Correcto</span>"
			  end
			elsif status == false
				"<span class='label label-danger'>Incorrecto</span>"
			elsif status == :empty
				""
			else
				"<span class='label label-info'>Pendiente</span>"
			end
		else
			challenge.user_answers(current_user.id).any? ? "<span class='label label-success'>Entregado</span>" : ""
		end
	end

	def answer_form_options(challenge)
		if challenge.gradable 
		  { :cols => 5, :rows => 15, placeholder: '# Escribe tu respuesta', id:"fase_0_input"  }
		else 
			{ :cols => 5, :rows => 1, placeholder: 'Escribe tu respuesta o Url de Github'  }
		end
	end

	#helper to decide if a user is online student or normal student
  def is_a_online_student?
    current_user.mode == "Online" ? true : false
  end

  def what_mode_is?
  	curre_user.mode
  end

  ...

end






