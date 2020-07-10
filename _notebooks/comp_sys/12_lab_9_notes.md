
## Lab 9 notes

- fork:
    - when forking, program does not start again since memory/register values are exactly the same
    - i.e. instruction pointer is at the same line too. So fork() wont execute again.
- exec: overlay another executable on top of current process
- pipe: interprocess communication

[StackOverflow: Globbing in exec()](https://stackoverflow.com/questions/53686987/how-to-pass-an-extra-option-in-ls-using-execv)

- to write to the pipe file descriptor while using exec, you can use `dup2` to set the pipe file descriptors to stdout/stdin for write/read respectively
- e.g. for `ls <args>`, you might use something like:

```c
dup2(pipe_fd[1], 1);  // set pipe "write" file descriptor to stdout
execvp("/usr/bin/ls", args_array);
```

- found [here](http://www.cs.uleth.ca/~holzmann/C/system/pipeforkexec.html)
