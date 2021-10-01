RSpec.describe User, type: :model do
  before(:all) do
    @password = 'testpass'
    @user = User.create(username: 'someuser', password: @password)
  end

  it 'creates corresponding password hash for password' do
    decrypted_password = BCrypt::Password.new(@user.password_hash)

    expect(decrypted_password).to eq @password
  end
end
