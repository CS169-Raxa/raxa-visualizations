paths = ['features/.*\.rb',
         'features/.*\.feature',
         'app/.*\.rb']
paths.each do |path|
  watch(path) { |md| system("bundle exec cucumber") }
end
