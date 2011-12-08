
require File.dirname(__FILE__) + '/../lib/commit2jira.rb'

describe Commit2Jira do

  describe "#from_message" do
    it "should not call the block if there are no JIRAs" do
      message = "Foo"

      Commit2Jira.from_message(message) do |project, number|
        true.should == false
      end

    end

    it "should call the block for one JIRA with the right project" do
      expected_project = 'SVR'
      expected_number = 4779
      message =<<END
This is a simple commit message

JIRA: #{expected_project}-#{expected_number}
END
      found_project = nil
      found_number = nil
      called = false
      Commit2Jira.from_message(message) do |project, number|
        found_project = project
        found_number = number
        called = true
      end

      called.should == true

      expected_project.should == found_project
      expected_number.should == found_number
    end
  end

end
