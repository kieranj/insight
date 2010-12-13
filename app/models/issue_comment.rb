class IssueComment < ActiveRecord::Base
  
  belongs_to :issue
  belongs_to :commenter, :polymorphic => true
  
  # def to_xml(options = {})
  #   {
  #     :title      => title,
  #     :comment    => comment,
  #     :created_at => created_at,
  #     :updated_at => updated_at,
  #     :issue      => {
  #       :id       => issue.id,
  #       :slug     => issue.slug
  #     },
  #     :commenter  => {
  #       :email    => commenter.email,
  #       :username => commenter.username
  #     }
  #   }.to_xml
  # end
  
end