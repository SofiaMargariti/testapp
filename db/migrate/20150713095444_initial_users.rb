class InitialUsers < ActiveRecord::Migration
  def change
    User.create  name:  'Sofia',
                 email: 'sofia@example.com',
                 password: 'lalala',
                 admin: false

    User.create  name:  'Admin',
                 email: 'admin@example.com',
                 password: 'lalala',
                 admin: true
  end
end
