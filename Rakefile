desc 'Generates API documentation.'
task :rdoc do
  sh 'rm -rf doc && rdoc lib'
end

desc 'Runs behaviour tests.'
task :tests do
	sh './test/body_builder5_test.rb'
	sh './test/heman5_test.rb'
	sh './test/skeletor5_test.rb'
end
