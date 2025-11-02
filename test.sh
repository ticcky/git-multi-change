#!/bin/bash
set -ex

PATH="$(pwd):$PATH"

# Clean-up past test runs.
rm -rf /tmp/gg-test-repo-upstream /tmp/gg-test-repo
mkdir -p /tmp/gg-test-repo-upstream /tmp/gg-test-repo

cd /tmp/gg-test-repo-upstream
git init -b main
echo hello > hello.txt
mkdir -p a/b/c/
echo hi > a/b/c/hi.txt
mkdir -p some/never/touched/
echo never > some/never/touched/file.txt
git add .
git commit -m "initial commit"

cd /tmp/gg-test-repo
    git clone /tmp/gg-test-repo-upstream .
    git mpull
    echo -e "hello\nmy change" > hello.txt

cd /tmp/gg-test-repo-upstream
    echo -e "hello\nupstream change" > hello.txt
    git commit -am "The change."

cd /tmp/gg-test-repo
    git mpull

    echo "# some_branch" >> .branches.txt
    echo "hello.txt" >> .branches.txt
    echo "" >> .branches.txt
    echo "# another_branch" >> .branches.txt
    echo "a/b/c/hi.txt" >> .branches.txt
    echo "a/b/c/hi2.txt" >> .branches.txt
    echo "" >> .branches.txt

    echo hi2 > a/b/c/hi2.txt

    git mpush some_branch

    echo -e "something new" >> hello.txt
    echo -e "something new2" > hello2.txt

    echo "# some_branch" >> .branches.txt
    echo "hello2.txt" >> .branches.txt

    git mpush some_branch
    git mpush another_branch

    echo "xxx" >> hello2.txt
    git mpush some_branch

# Merge all into main.
cd /tmp/gg-test-repo-upstream
    git merge some_branch -m "Merge PR some_branch"
    git merge another_branch -m "Merge PR another_branch"

cd /tmp/gg-test-repo
    git mpull

# Test that files get deleted correctly when they are deleted from upstream.
cd /tmp/gg-test-repo-upstream
    rm some/never/touched/file.txt
    rm hello.txt
    git commit -am "Remove file."

cd /tmp/gg-test-repo
    git mpull
    [ ! -e some/never/touched/file.txt ] || exit 1
    [ ! -e hello.txt ] || exit 1

# Test that a file that has local modifications won't get deleted
# even when upstream deletes it.
cd /tmp/gg-test-repo-upstream
    rm hello2.txt
    git commit -am "Remove file 2."

cd /tmp/gg-test-repo
    echo "This should not get deleted" > hello2.txt

    git mpull

    [ -e hello2.txt ] || exit 1
