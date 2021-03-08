class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable,
	       :registerable,
	       :recoverable,
	       :rememberable,
	       :validatable,
	       authentication_keys: [:login]
	validates :username,
	          presence: true,
	          uniqueness: {
			case_sensitive: :false,
	          },
	          length: {
			minimum: 4,
			maximum: 20,
	          }
	validates :profile, length: { maximum: 200 }
	attr_accessor :login

	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			where(conditions)
				.where(
					[
						'username = :value OR lower(email) = lower(:value)',
						{ value: login },
					],
				)
				.first
		else
			where(conditions).first
		end
	end
end
