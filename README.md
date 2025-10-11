`git-multi-change` is a set of tools that allow to work on multiple PRs with as
little friction as possible. Especially **NO branch-switching**, and **NO `git worktree`** whatsoever.

It's simple:

1. Work on multiple features at once, and edit files. E.g. `file1.txt` and
   `file2.txt`.
2. Create `.branches.txt` that assigns these files to branches (assuming the
   branch == Github PR). E.g.:

    ```
    # my_branch_1
    file1.txt

    # my_branch_2
    file2.txt
    ```

3. Push the branches to Github with `git mpush my_branch_1` and `git mpush my_branch_2`.
4. Work on the features some more, and continue pushing to Github using `git
   mpush <branch>`. This will keep updating your PRs.

