module ModelIntegrityCheck
  class ModelCheck
    def compute_values!
      return if @computed
      
      @klass.find_each do |instance|
        @total_count += 1
        next if instance.valid?
        
        @errors_count += 1
        instance.errors.full_messages.each do |message|
          @errors_hash[message] ||= 0
          @errors_hash[message] += 1
        end
      end
      
      @computed = true
    end
    
    def errors_to_s
      @errors_hash.sort_by { |name, count| count }.map { |pair| "#{ pair[1] } => #{ pair[0] }"}.join("\n    ")
    end
    
    def initialize(klass)
      @klass = klass
      @errors_hash = {}
      @errors_count = 0
      @total_count = 0
      @computed = false
    end
    
    def to_s
      self.compute_values!
      
      """#{ @klass.name }
    Total: #{ @total_count }
    Invalid: #{ @errors_count }
    Invalid Reasons:
    #{ @errors_count > 0 ? self.errors_to_s : 'None' }
"""
    end
    
    def self.model_names
      Dir["#{Rails.root}/app/models/**/*.rb"].map do |full_path|
        full_path.gsub('.rb', '').gsub(/.*\/app\/models\//, '').camelize
      end
    end

    def self.models
      ModelCheck.model_names.map { |name| Object.const_get(name) }
    end

    def self.active_record_models
      ModelCheck.models.select { |model| model < ActiveRecord::Base }
    end
    
    def self.model_checks(only_these = [])
      these_models = ModelCheck.active_record_models
      if only_these.length > 0
        these_models.select! { |model| only_these.include?(model.name.downcase) }
      end
      
      these_models.map { |model| ModelCheck.new(model) }
    end
  end
end
