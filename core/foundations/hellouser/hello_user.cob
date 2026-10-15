identification division.
program-id. hello-user.

environment division.
input-output section.

data division.
working-storage section.
01 user-name pic x(100).

procedure division.
    display "Enter your name: ".
    accept user-name.
    display "Hello, " user-name "!".
    stop run.
