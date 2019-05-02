class EnrollmentSerializer < ActiveModel::Serializer
  attributes :updated_at, :created_at, :id, :target_api, :linked_franceconnect_enrollment_id,
             :cgu_approved, :scopes, :contacts, :siret, :status, :linked_token_manager_id, :additional_content,
             :intitule, :description, :fondement_juridique_title, :fondement_juridique_url, :data_recipients,
             :data_retention_period, :data_retention_comment


  belongs_to :user

  has_many :documents
  has_many :events

  attribute :acl do
    Hash[
      EnrollmentPolicy.acl_methods.map do |method|
        [method.to_s.delete('?'), EnrollmentPolicy.new(current_user, object).send(method)]
      end
    ]
  end
end
