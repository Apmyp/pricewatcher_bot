namespace :links do
  desc "Search active users with active links and add it to job queue"
  task analyze: :environment do
    active_users_query = TelegramUser.active
    puts "Analyzing #{active_users_query.count} users"

    active_users_query.includes(:active_links).find_in_batches do |users|
      users.each do |user|
        user.active_links.find_each do |link|
          ParseLinkJob.perform_later(link)
        end
      end

      print "."
    end

    print "\n"
  end

end
