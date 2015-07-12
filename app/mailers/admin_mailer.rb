class AdminMailer < ApplicationMailer
  def notify_vessel_created(ip, vessel)
    @ip = ip
    @vessel = vessel
    mail(from: 'admin@example.com', to: 'testappadm@mailinator.com', subject: 'New vessel created')
  end

  def notify_vessel_updated(ip, vessel, vessel_params)
    @ip = ip
    @vessel = vessel
    @params = vessel_params
    mail(from: 'admin@example.com', to: 'testappadm@mailinator.com', subject: 'A vessel was updated')
  end
end
