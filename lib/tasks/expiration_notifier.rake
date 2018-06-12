namespace :expiration_notifier do
  desc 'Notify user about loan expiration'
  task notify: :environment do
    ExpirationNotificationService.new.call
  end
end
