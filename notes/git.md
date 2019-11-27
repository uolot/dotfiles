# Reset file permissions

```sh
git config core.filemode false
```

or

```sh
git diff -p -R --no-color \
    | grep -E "^(diff|(old|new) mode)" --color=never  \
    | git apply
```

[source](http://stackoverflow.com/questions/2517339/how-to-recover-the-file-permissions-to-what-git-thinks-the-file-should-be)


# Find Branches that have given commit

```sh
git branch --contains <commit>
```


# Refresh local list of remote branches

```sh
git remote update origin --prune
```


# Pull from remote overwriting local changes

```sh
git fetch --all
git reset --hard origin/branch
```


# Track remote branch

When starting to work on existing remote branch

```sh
git checkout --track origin/dev
```

When publishing local branch

```sh
git push -u origin dev
```

At any point

```sh
git branch -u origin/dev
```

[source](https://www.git-tower.com/learn/git/faq/track-remote-upstream-branch)
