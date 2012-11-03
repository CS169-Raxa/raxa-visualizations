paths = ['spec/.*\.rb',
         'app/.*\.rb']
paths.each do |path|
  watch(path) { |md| system("bundle exec rspec spec") }
end
