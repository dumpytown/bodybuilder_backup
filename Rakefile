desc 'Generates API documentation.'
task :doc do
  sh 'rm -rf doc && rdoc lib'
end

desc 'Runs behaviour tests.'
task :test do
	sh './tests/bodybuilder5_test.rb'
	sh './tests/heman5_test.rb'
	sh './tests/skeletor5_test.rb'
end

desc 'Build all task'
task :all do
	[:doc, :test].each do |task_sym|
		Rake::Task[task_sym.to_s].reenable
		Rake::Task[task_sym.to_s].invoke
	end
end
