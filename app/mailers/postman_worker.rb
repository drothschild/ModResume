class PostmanWorker
  include Sidekiq::Worker

  def perform(h, count)
    h = JSON.load(h)
    VisitorMailer.contact_email(h['name'],h['email']).deliver_now
  end
end
