class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,  type: String
  field :email, type: String
  field :password, type: String

  validates :email, presence:   { message: "Eメールアドレスを入力してください" }
  validates :email, uniqueness: { message: "このEメールアドレスは既に使われています" }
end
