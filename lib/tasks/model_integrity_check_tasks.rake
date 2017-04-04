desc "Explaining what the task does"
task :mic_check => :environment do
  models_to_check = ARGV[1, ARGV.length - 1]
  puts ModelIntegrityCheck::ModelCheck.model_checks(models_to_check)
end
