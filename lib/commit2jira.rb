
require 'rubygems'

module Commit2Jira
  def from_message(projects, message, precise_match=false, &block)
    if message.nil? or message.empty?
      return
    end
    if precise_match
      message = message.split("\n").select {|line| line =~ /\Ajira:/i }.join("\n")
    end

    regex = /\b(#{projects.join('|')})-(\d+)\b/i

    message.scan(regex) do |match|
      project = match[0].upcase
      number = match[1].to_i

      yield project, number
    end

  end
  module_function :from_message
end
