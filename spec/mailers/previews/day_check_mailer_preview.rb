# Preview all emails at http://localhost:3000/rails/mailers/day_check_mailer
class DayCheckMailerPreview < ActionMailer::Preview
  def day_check_email
    DayCheckMailer.with(day_habit: Day.last).day_check_email
  end
end
