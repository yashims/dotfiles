---
name: start-work
description: 作業を開始する。ブランチ作成、worktree作成、作業ディレクトリへの移動を行う。「作業を開始して」「start」と言われたら使用する。
---

# 作業を開始する

## 前提条件

オペレーターから以下の情報を取得すること。不明な場合は作業を中断し質問する：

- `<base branch>`: ベースブランチ
- `<working branch>`: 作業ブランチ名

## 手順

### 1. base branchを最新化する

```bash
git checkout <base branch>
git pull origin <base branch>
```

### 2. 作業ブランチを作成する

```bash
git checkout -b <working branch>
```

### 3. remoteブランチを設定する

```bash
git branch --set-upstream-to=origin/<working branch>
```

### 4. worktreeを作成する

```bash
git worktree add worktree/<working branch> <working branch>
```

### 5. 作業ディレクトリに移動する

作成したworktreeディレクトリで作業を行う。

## 注意事項

- commit, pushはオペレーターの許可なく行わないこと
