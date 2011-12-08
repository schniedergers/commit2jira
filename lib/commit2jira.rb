
require 'rubygems'

module Commit2Jira
  PROJECT_REGEX = /\b(CR|SVR|OPS|AN|IP|SI|SEC|LAB|DATA)-(\d+)\b/i

  def from_message(message, &block)
    if message.nil? or message.empty?
      return
    end

    message.scan(PROJECT_REGEX) do |match|
      project = match[0].upcase
      number = match[1].to_i

      yield project, number
    end

  end
  module_function :from_message
end
