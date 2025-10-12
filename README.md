`git-multi-change` is a set of tools that allow to work on multiple PRs with as
little friction as possible. Especially **NO branch-switching**, and **NO `git
worktree`** whatsoever.

In addition to this, `git msnap` (used under the hood to keep a running sequence
of snapshots) offers an infinite edit history.

It's very simple:

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

   When you need to fetch changes from upstream, run `git mpull`. This fetches
   the remote main, and merges it into your work-tree, including conflict
   markers.
   
   NOTE: As opposed to the standard git workflow, where you make commits often
   and your work-tree is mostly clean, with `git-multi-change`, your work-tree
   stays dirty all the time. This is so that there's minimal friction, and also
   this is good, because VSCode will show nice diffs wrt to latest upstream
   revision (i.e. corresponding to the last time you ran `git mpull`).

Other features:

- `git mmap` looks at all dirty but unassigned files in the repo and adds them in `# UNTRACKED` section of `.branches.txt`
- `git mmap <branch>` lists all files that changed wrt to current HEAD in the given `<branch>`
- `git msnap <optional log msg>` takes a snapshot of the full working tree to
  `snapshots` branch; this allows you to cheaply record state of the repo as you
  go -- the other scripts use that too to record state for commit and before
  pull is executed

Installation:

1. `git clone https://github.com/ticcky/git-multi-change ~/git-multi-change`
2. `echo "PATH=\"$(realpath ~/git-multi-change):\$PATH\"" >> ~/.bashrc"
