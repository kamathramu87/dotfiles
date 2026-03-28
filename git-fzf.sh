#!/bin/zsh
# Git fuzzy search helpers using fzf

# Fuzzy checkout branch
gfco() {
    local branch
    branch=$(git branch -a | sed 's/remotes\/origin\///' | sort -u | fzf --prompt="Checkout branch > ")
    [ -n "$branch" ] && git checkout "$(echo "$branch" | tr -d '* ')"
}

# Fuzzy delete local branch
gfbd() {
    local branch
    branch=$(git branch | grep -v "^\*" | fzf --prompt="Delete branch > ")
    [ -n "$branch" ] && git branch -d "$(echo "$branch" | tr -d ' ')"
}

# Fuzzy add files
gfa() {
    local files
    files=$(git status -s | fzf -m --prompt="Stage files > " | awk '{print $2}')
    [ -n "$files" ] && echo "$files" | xargs git add && git status -s
}

# Fuzzy restore (unstage/discard)
gfr() {
    local files
    files=$(git status -s | fzf -m --prompt="Restore files > " | awk '{print $2}')
    [ -n "$files" ] && echo "$files" | xargs git restore
}

# Fuzzy show commit details
gfshow() {
    git log --oneline --graph --all | \
        fzf --prompt="Show commit > " \
            --preview 'git show --stat --color $(echo {} | grep -o "[a-f0-9]\{7\}" | head -1)' | \
        grep -o "[a-f0-9]\{7\}" | head -1 | xargs git show
}

# Fuzzy cherry-pick a commit
gfcp() {
    local commit
    commit=$(git log --oneline --all | fzf --prompt="Cherry-pick commit > " --preview 'git show --color $(echo {} | awk "{print \$1}")' | awk '{print $1}')
    [ -n "$commit" ] && git cherry-pick "$commit"
}

# Fuzzy stash apply
gfsta() {
    local stash
    stash=$(git stash list | fzf --prompt="Apply stash > " --preview 'git stash show -p $(echo {} | cut -d: -f1)' | cut -d: -f1)
    [ -n "$stash" ] && git stash apply "$stash"
}

# Fuzzy stash drop
gfstd() {
    local stash
    stash=$(git stash list | fzf --prompt="Drop stash > " | cut -d: -f1)
    [ -n "$stash" ] && git stash drop "$stash"
}

# Fuzzy search file in a commit (see what changed)
gflog() {
    local file
    file=$(git ls-files | fzf --prompt="File history > ")
    [ -n "$file" ] && git log --oneline --follow "$file"
}

# Show all git fzf functions
gfhelp() {
    echo "Git fzf helpers:"
    echo "  gfco   — fuzzy checkout branch"
    echo "  gfbd   — fuzzy delete branch"
    echo "  gfa    — fuzzy stage files"
    echo "  gfr    — fuzzy restore files"
    echo "  gfshow — fuzzy browse commits"
    echo "  gfcp   — fuzzy cherry-pick commit"
    echo "  gfsta  — fuzzy stash apply"
    echo "  gfstd  — fuzzy stash drop"
    echo "  gflog  — fuzzy file history"
}
