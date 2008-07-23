class Survey < ActiveRecord::Base
  has_many :answers 
  has_and_belongs_to_many :questions
  
  def question_answered?(question_id)
    ans = answers.find_by_question_id(question_id) 
    return false if( (ans.text.nil? or ans.text =="") and ans.options.empty? )
    return true
  end
  
  def answer_attributes=(answer_attributes)  
    answer_attributes.each_pair do |answer_id, params_hash|
      answers.find(answer_id.to_i).update_attributes(params_hash)
    end   
  end
end