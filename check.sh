#!/usr/bin/env bash
set -u

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf 'Run this inside github-trail-lesson.\n'
  exit 1
fi

failed=0
branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null || true)
if [[ "$branch" == practice/* && "$branch" != practice/ ]]; then
  printf 'PASS branch: on %s\n' "$branch"
else
  printf 'FAIL branch: create a practice/ branch from lesson-start\n'
  failed=1
fi

if git show-ref --verify --quiet refs/remotes/origin/main &&
   git merge-base --is-ancestor origin/main HEAD &&
   [[ $(git rev-list --count origin/main..HEAD) == 1 ]] &&
   [[ -z $(git rev-list --merges origin/main..HEAD) ]]; then
  printf 'PASS rebase: one commit above origin/main\n'
else
  printf 'FAIL rebase: expected one commit above origin/main\n'
  failed=1
fi

actual=$(git show HEAD:pickup.md 2>/dev/null | tr -d '\r')
expected=$'# Corner Cup pickup\nSaturday: 10:00-16:00 | Help: pickup@cornercup.example'
if [[ "$actual" == "$expected" ]]; then
  printf 'PASS conflict: Saturday hours and help email are both correct\n'
else
  printf 'FAIL conflict: committed pickup.md must contain both changes from step 4\n'
  failed=1
fi

exit "$failed"
