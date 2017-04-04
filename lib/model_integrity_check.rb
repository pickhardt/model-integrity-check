spec = Gem::Specification.find_by_name("model_integrity_check")
if defined?(Rake)
  Dir["#{ spec.gem_dir }/lib/tasks/*.rake"].each { |rake_task| load rake_task }
end

Dir["#{ spec.gem_dir }/lib/model_integrity_check/*.rb"].each do |file|
  require file
end

module ModelIntegrityCheck
end
