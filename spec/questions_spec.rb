require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

module Auto
  describe Auto::Question do
    
    def run
      @r.run do
        q :q1 => "q1", :q2 => "q2"
      end
    end
    
    before(:each) do
      @r = Runner.new
    end
    
    it 'should store questions' do
      run
      @r.run do
        q.should == {
          :q1 => "q1" ,
          :q2 => "q2"
        }
      end
    end
    
    it 'should trigger a "before question" callback' do
      questions = {}
      @r.before_question do |key, value|
        questions[key] = value
      end
      run
      questions.should == { :q1 => "q1", :q2 => "q2" }
    end
    
    it 'should trigger an "after question" callback' do
      questions = {}
      @r.after_question do |key, value|
        questions[key] = value
      end
      run
      questions.should == { :q1 => "q1", :q2 => "q2" }
    end
    
    it 'should not trigger "after question" if a "before question" callback returns false' do
      @r.before_question { |key, value| false }
      @r.after_question do |key, value|
        true.should == false # fail test
      end
      run
    end
    
    it 'should yield to a block if specified' do
      @r.run do
        q :q1 => "q1", :q2 => "q2" do
          q[:q1].should == "q1"
          q[:q2].should == "q2"
        end
      end
    end
  end
end