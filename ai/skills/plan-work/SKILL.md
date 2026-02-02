---
name: plan-work
description: 作業計画を立てる。issueを読み込み、作業計画を docs/plans/ に出力する。「作業計画を立てて」「計画して」「plan」と言われたら使用する。
---

# 作業計画を立てる

## 前提条件

オペレーターから以下の情報を取得すること。不明な場合は作業を中断し質問する：

- `<working issue>`: 対象のissue番号またはURL
- `<base branch>`: ベースブランチ

## 手順

### 1. issueを読み込む

`gh issue view <issue番号>` でissueの内容を確認する。

### 2. base branchを最新化する

```bash
git checkout <base branch>
git pull origin <base branch>
```

### 3. working branchを決定する

1. issue番号を使って同名のbranchが無いか検索する
   ```bash
   git branch -a | grep <issue番号>
   ```
2. すでに同名issue番号のbranchがある場合、この手順はskipする
3. issue内容を読み込み、working branchを提示する
   - **命名規則**: `<type>/<issue-number>-<short-description>`
   - **type**: `feat` | `fix` | `refactor`
4. **次のStepに進むにはオペレーターの許可を待つこと**

### 4. 作業計画ファイルを作成する

- **出力先**: `docs/plans/<working branch>.md`
- **注意**: このファイルはcommitしない

### 5. 計画ファイルに以下を記載する

- `<working issue>`, `<base branch>`, `<working branch>` の情報
- 作業手順

## 計画の立て方

### bug対処の場合

- issue内容を読み、課題ごとに順番に計画する

例:
```
issue:
  - A画面のbボタンの色が仕様と違う
  - A画面のbボタンを押した時crashする

作業計画:
  1. A画面のbボタンの色を仕様通りにする
  2. 1.の作業計画を前提に、A画面のbボタンを押した時crashしないようにする
```

### featureの場合

- figmaなど画面設計がある場合、その内容を読み込む
- 変更が2画面以上になる場合、最低でも1画面につき1issueになるようサブタスクを発行する
- 作業計画は段階を踏んで計画する

例:
```
issue: A画面を作る

作業計画:
  1. APIを実装する
  2. Stateを設計する
  3. VMを実装する
  4. Fragmentの大枠を実装する
  5. A画面に必要な機能を順次実装する
```
