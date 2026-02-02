---
name: finish-work
description: 作業を終了する。ブランチ削除、worktree削除、作業計画ファイル削除を行う。「作業を終了して」「finish」「cleanup」と言われたら使用する。
---

# 作業を終了する

## 前提条件

- **remoteブランチが削除済みであること**を確認する
- remoteブランチが存在する場合、このタスクは絶対に実行しない

## 確認コマンド

```bash
git ls-remote --heads origin <working branch>
```

出力が空であればremoteブランチは削除済み。

## 手順

### 1. worktreeを削除する

```bash
git worktree remove worktree/<working branch>
```

### 2. ローカルブランチを削除する

```bash
git branch -D <working branch>
```

### 3. 作業計画ファイルを削除する

```bash
rm docs/plans/<working branch>.md
```

## 注意事項

- remoteブランチが残っている場合は、オペレーターに確認すること
- 削除前に作業内容が全てマージされていることを確認すること
