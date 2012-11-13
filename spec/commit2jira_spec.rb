
require File.dirname(__FILE__) + '/../lib/commit2jira.rb'

describe Commit2Jira do
  describe "#from_message" do
    it "should not call the block if there are no JIRAs" do
      Commit2Jira.from_message(['FOO'], 'Foo') do |project, number|
        true.should == false
      end

    end

    it "should call the block for one JIRA with the right project" do
      expected_project = 'FOO'
      expected_number = 4779
      message =<<END
This is a simple commit message

JIRA: #{expected_project}-#{expected_number}
END
      found_project = nil
      found_number = nil
      called = false
      Commit2Jira.from_message(['foo'], message) do |project, number|
        found_project = project
        found_number = number
        called = true
      end

      called.should == true

      expected_project.should == found_project
      expected_number.should == found_number
    end

    it "should call the block for two JIRAs with the right projects" do
      expected_projects = ['FOO', 'BAR']
      expected_numbers = [4779, 5013]
      message =<<END
This is a simple commit message referencing #{expected_projects[0]}-#{expected_numbers[0]}

JIRA: #{expected_projects[1]}-#{expected_numbers[1]}
END
      Commit2Jira.from_message(['foo', 'bar'], message) do |project, number|
        expected_projects.shift if project == expected_projects[0]
        expected_numbers.shift if number == expected_numbers[0]
      end

      expected_projects.should be_empty
      expected_numbers.should be_empty
    end

    it "should call the block for only the JIRAs explicitly mentioned when specified" do
      expected_projects = ['BAR', 'BAZ']
      expected_numbers = [5013, 8724]
      message =<<END
This is a simple commit message referencing FOO-4779

JIRA: #{expected_projects[0]}-#{expected_numbers[0]}, #{expected_projects[1]}-#{expected_numbers[1]}
END

      Commit2Jira.from_message(['foo', 'bar', 'baz'], message, true) do |project, number|
        expected_projects.shift if project == expected_projects[0]
        expected_numbers.shift if number == expected_numbers[0]
      end

      expected_projects.should be_empty
      expected_numbers.should be_empty
    end
  end
end
