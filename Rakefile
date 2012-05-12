desc 'Generates API documentation.'
task :rdoc do
  sh 'rm -rf doc && rdoc lib'
end

desc 'Runs behaviour tests.'
task :tests do
	sh './tests/body_builder5_test.rb'
	sh './tests/heman5_test.rb'
	sh './tests/skeletor5_test.rb'
end
