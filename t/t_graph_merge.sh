#!/usr/bin/env sh

set -e

TEST_DIR=$(realpath -- "$(dirname -- "$0")")

. "$TEST_DIR/lib_dir.sh"
. "$TEST_DIR/lib_diff.sh"
. "$TEST_DIR/lib_git.sh"
. "$TEST_DIR/lib_vim.sh"

TMP=$(create_tmp_dir graph_merge)

WORKTREE=$(git_init graph_merge)
cd "$WORKTREE"

git_commit_tag a b c

git_checkout b
git_commit_tag side-a side-b

git_checkout c
git_merge -m d side-b
git_commit -m e

VIM_OUT=$(get_relative_dir "$TMP")/out
run_vim_command "exec 'Flog -format=%s' | silent w $VIM_OUT"

diff_data "$TMP/out" "graph_merge_out"
