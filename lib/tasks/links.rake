# frozen_string_literal: true

namespace :links do
  desc 'Search active users with active links and add it to job queue'
  task analyze: :environment do
    active_users_query = TelegramUser.active
    puts "Analyzing #{active_users_query.count} users"

    active_users_query.includes(:active_links).find_in_batches do |users|
      users.each do |user|
        user.active_links.find_each do |link|
          ParseLinkJob.perform_later(link)
        end
      end

      print '.'
    end

    print "\n"
  end

  desc 'Generates path for links which does not have it'
  task generate_paths: :environment do
    link_query = Link.where(path: nil)
    puts "Found #{link_query.count} links"

    link_query.find_each do |link|
      uri = URI.parse(link.link)
      link.update!(path: uri.path)
    end
  end
end
