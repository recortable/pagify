
namespace :pagify do
  desc "Sync extra files from pagify plugin engine."
  task :sync do
    system "rsync -ruv vendor/plugins/pagify/db/migrate db"
    system "rsync -ruv vendor/plugins/pagify/config/initializers config"
    system "rsync -ruv vendor/plugins/pagify/public ."
  end
end
