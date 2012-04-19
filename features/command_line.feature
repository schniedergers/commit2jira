Feature: Allow piping commit messages into a command line tool
  In order to list the JIRAs for a specific commit
  As a command line user
  I should be able to parse out JIRAs from any bit of text


  Scenario: Without any options
    When I run `commit2jira`
    Then the exit status should be 1
    And the output should contain:
      """
      Usage: commit2jira
      """

  Scenario: With a single project
    Given the commit:
      """
      commit 49060a4b0d7c6e9ddfc20a42eae8dbd93d03b458
      Author: R. Tyler Croy <rtyler.croy@mylookout.com>
      Date:   Fri Apr 6 17:29:07 2012 -0700

          Add the MIT license

          JIRA: DEMO-1
      """
    When I pipe the commit into `commit2jira -p demo`
    Then the exit status should be 0
    And the output should contain exactly:
      """
      DEMO-1

      """

  Scenario: A single project with multiple JIRAs
    Given the commit:
      """
      commit 49060a4b0d7c6e9ddfc20a42eae8dbd93d03b458
      Author: R. Tyler Croy <rtyler.croy@mylookout.com>
      Date:   Fri Apr 6 17:29:07 2012 -0700

          Add the MIT license

          JIRA: DEMO-1, DEMO-2
      """
    When I pipe the commit into `commit2jira -p demo`
    Then the exit status should be 0
    And the output should contain exactly:
      """
      DEMO-1
      DEMO-2

      """

  Scenario: Multiple projects
    Given the commit:
      """
      commit 49060a4b0d7c6e9ddfc20a42eae8dbd93d03b458
      Author: R. Tyler Croy <rtyler.croy@mylookout.com>
      Date:   Fri Apr 6 17:29:07 2012 -0700

          Add the MIT license

          JIRA: DEMO-1, LAB-2
      """
    When I pipe the commit into `commit2jira -p demo,lab`
    Then the exit status should be 0
    And the output should contain exactly:
      """
      DEMO-1
      LAB-2

      """

  Scenario: No referenced JIRAs
    Given the commit:
      """
      commit 49060a4b0d7c6e9ddfc20a42eae8dbd93d03b458
      Author: R. Tyler Croy <rtyler.croy@mylookout.com>
      Date:   Fri Apr 6 17:29:07 2012 -0700

          Add the MIT license
      """
    When I pipe the commit into `commit2jira -p demo`
    Then the exit status should be 1
    And the output should contain:
      """
      No JIRAs found!
      """
