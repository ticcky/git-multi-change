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

echo "# some_branch
hello.txt

# another_branch
a/b/c/hi.txt
a/b/c/hi2.txt
" > .branches.txt
echo hi2 > a/b/c/hi2.txt

git mpush some_branch

echo -e "something new" >> hello.txt
echo -e "something new2" > hello2.txt

echo "# some_branch
hello2.txt" >> .branches.txt

git mpush some_branch
git mpush another_branch

echo "xxx" >> hello2.txt
git mpush some_branch
