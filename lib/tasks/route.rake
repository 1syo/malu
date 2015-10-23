namespace :route do
  task :environment do
    @key = ENV['KEY']
    @val = ENV['VAL']
    @store = Store.new
  end

  desc 'Show all routes'
  task list: :environment do
    @store.all.each do |key, val|
      puts "#{key} #=> [ #{val.join(",\s")} ]"
    end
  end

  desc 'Add new route'
  task add: :environment do
    @store.add(@key, @val)
  end

  desc 'Delete route'
  task del: :environment do
    @store.del(@key)
  end

  task delete_all: :environment do
    @store.delete_all
  end
end
