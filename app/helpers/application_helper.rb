# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # TODO: refactor the _answer partial
  # def display_answer_field(answer, answer_form)
  #   if answer.question.qtype == "text_field" or answer.question.qtype == "text_area"
  #     answer_form.send("#{answer.question.qtype}", :text, :rows => 3)
  #   elsif answer.question.qtype == "list" 
  #     for option in answer.question.options
  #       check_box_tag "#{option.text}", option.id,  answer.options.include?(option)
  #     end
  #   end
  # end

  def image_label(label_name)
    image_tag("/images/labels/#{label_name}.png")
  end

  def title(page_title)
    content_for(:title) { h(page_title) }  
  end
  
  def show_avatar
    if @current_survey.avatar
      return @current_survey.avatar.public_filename(:thumb)
    else
      return 'no_avatar.jpg'
    end
  end
end
