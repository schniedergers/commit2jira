Given /^the commit:$/ do |commit|
  @commit = commit
end

When /^I pipe the commit into `([^`]*)`$/ do |command|
  step %{I run `#{command}` interactively}
  type(@commit)
  processes.each do |command, process|
    process.stdin.close
  end
end

