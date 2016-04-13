module UserTestHelper
  module_function # Ensure that all subsequent methods are available as Module Functions
  
  DEFAULT_PASSWORD = "Passw0rd"

  def create_or_find_user(name: "Norman Normal", email: "norman@mail.com", username: "normaluser")
    user = User.create_with(name: name, email: email, password: DEFAULT_PASSWORD).find_or_create_by(username: username)
  end
  
  def create_or_find_another_user(name: "Ann Other", email: "another@mail.com", username: "anotheruser")
    user = User.create_with(name: name, email: email, password: DEFAULT_PASSWORD).find_or_create_by(username: username)
  end

  def make_admin(user)
    user.roles << Role.find_by(rolename: 'administrator')
    user.save
  end

  def confirm(user)
    user.confirmed_at = Time.now
    user.activate
    user.save
  end

  def approve(user)
    user.approve
    user.save
  end

  def suspend(user)
    user.suspend
    user.save
  end  
  
  def delete(user)
    user.delete
    user.save
  end  
  
  def grant_role(user, role)
    Permission.find_or_create_by(user: user, role: role)
  end
  
  def fill_in_all_details(user)
    updating_user = User.find_by(name: user.name)
    updating_user.update(mobile_number: "07777 888777", contact_name: "Bob Bobson", contact_number: "07888 777888", medical_notes: "Allergic to bees.", food_notes: "Intolerant to lactose.", notes: "Some notes.")
  end
end

