# commit2jira


commit2jira is a simple gem for parsing a commit message for JIRAs referenced
in the meta-data block of the commit body.

A commit that it will parse, for example:

    commit 54be152b445ecb4ac27ca7b2c06475d27236e2b2
    Author: R. Tyler Croy <rtyler.croy@mylookout.com>
    Date:   Fri Apr 6 16:07:23 2012 -0700

        This is a test commit, and it's awesome.

        Change-Id: I54be152b445ecb4ac27ca7b2c06475d27236e2b2
        JIRA: TEST-231


