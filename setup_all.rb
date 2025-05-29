# setup_all.rb
# frozen_string_literal: true

Dir.glob('alloverit-*').each do |dir|
  setup = File.join(dir, 'bin', 'setup')
  if File.exist?(setup)
    puts "\n==> Running #{setup}"
    system("cd #{dir} && sh ./bin/setup") or abort("Setup failed in #{dir}")
  end
end

puts "\nAll project setups complete!"