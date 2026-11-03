# Git practice: one conflict (Windows)

Use **Git Bash** on Windows. Run one command at a time.
You need Git for Windows installed. This lesson takes about 10 minutes.

**Story:** Corner Cup wants longer Saturday pickup hours. At the same time, someone fixed the help email.
Your job is to keep **both** changes in `pickup.md`.

## 1. Get a fresh copy

Open Git Bash from the Start menu. Run:

```bash
git clone https://github.com/vijaysatwik/github-trail.git github-trail-lesson
```

Expected: `Cloning into 'github-trail-lesson'`.

```bash
cd github-trail-lesson
```

If that folder already exists, use a new folder name in both commands.

## 2. Create your branch

```bash
git switch -c practice/my-first-try lesson-start
```

Expected: `Switched to a new branch 'practice/my-first-try'`.
`lesson-start` is a fixed starting point with the new hours.

## 3. Rebase onto main

```bash
git rebase origin/main
```

Expected: `CONFLICT (content): Merge conflict in pickup.md`.
Git stopped because both versions changed the Saturday line. This is the exercise.

## 4. Resolve the conflict

```bash
notepad pickup.md
```

The lines with `<<<<<<<`, `=======`, and `>>>>>>>` show the two versions.
One has the new hours. The other has the new email.
Replace the whole file with these **two lines**, then save and close Notepad:

```text
# Corner Cup pickup
Saturday: 10:00-16:00 | Help: pickup@cornercup.example
```

## 5. Finish the rebase

```bash
git add pickup.md
```

```bash
GIT_EDITOR=true git rebase --continue
```

Expected: `Successfully rebased`.
`GIT_EDITOR=true` prevents an extra editor window.

## 6. Check your answer

```bash
bash check.sh
```

Success is **three PASS lines**:

```text
PASS branch: on practice/my-first-try
PASS rebase: one commit above origin/main
PASS conflict: Saturday hours and help email are both correct
```

Stop here. You do **not** need to push anything to GitHub.

## If you get stuck

- `FAIL conflict`: compare `pickup.md` with the two lines in step 4. The checker reads the saved Git commit.
- Changed the file after the rebase finished? Run `git add pickup.md`, then `git commit --amend --no-edit`, then check again.
- Rebase still in progress? Run `git status` to see what Git needs.
- Want to retry the conflict? Run `git rebase --abort`, then repeat step 3.
- Git asks for your name or email? Set them with `git config user.name "Your Name"` and `git config user.email "you@example.com"`, then repeat step 5's continue command.
