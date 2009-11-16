module Auto
  module Question
    
    def after_question(key=nil, value=nil, &block)
      Questions.after_question(key, value, &block)
    end
    
    def before_question(key=nil, value=nil, &block)
      Questions.before_question(key, value, &block)
    end
    
    def questions(hash={}, &block)
      q = Questions
      hash.each do |key, value|
        q[key] = value
        if before_question(key, value)
          yield if block_given?
          after_question(key, value)
        end
      end
      q.questions
    end
    alias :question :questions
    alias :q :questions
    
    class Questions
      
      cattr_accessor :questions
      @@questions = {}
      
      class <<self
      
        def []=(key, value)
          @@questions[key] = value
        end
    
        def [](key)
          @@questions[key]
        end
      
        def after_question(key, value, &block)
          @@after_question ||= []
          if block
            @@after_question << block
          end
          if key && !value.nil?
            @@after_question.each do |callback|
              callback.call(key, value)
            end
          end
        end
      
        def before_question(key, value, &block)
          @@before_question ||= []
          if block
            @@before_question << block
          end
          if key && !value.nil?
            result = true
            @@before_question.each do |callback|
              result = callback.call(key, value)
              break unless result
            end
            return result
          end
        end
      end
    end
  end
end