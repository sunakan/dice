class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,  type: String
  field :email, type: String
  field :password, type: String

  validates_presence_of :email, message: "Eメールアドレスを入力してください"
  validates_uniqueness_of :email, message: "このEメールアドレスは既に使われています"
end
