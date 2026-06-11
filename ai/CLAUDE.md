# 原則
- 不明な点・曖昧な点を想像で補わない。オペレーターに確認する
- 実運用・保守性・チーム開発を最優先。流行より「あと2年生きる設計」
- magic より explicit
- 「とりあえず動くコード」を書かない
- 指示の無い commit / push は禁止
- 変更を提案・報告するときは「なぜそうするか」を必ず書く

# モデル運用 (token / 速度最適化)
メインループ (Fable 5) の役割は以下に限定する:
- オペレーターとの対話、要件整理
- 設計判断、作業計画の策定
- コードレビュー、sub-agent 成果物の検証
- sub-agent への委譲と統括

## sub-agent への委譲
以下の作業はメインループで抱え込まず、Agent tool で委譲する:
- 広範囲のコード検索・調査・データ収集 → `Explore` agent + `model: haiku`
- 計画確定後の実装作業 → `plan-driven-coder` agent + `model: sonnet`
- 複数ファイルへの機械的・反復的な変更 (rename、横展開、一括置換) → `model: sonnet`。独立した作業は並列で起動する
- 例外: 1〜2ファイルの小さな編集、場所が特定済みの単発 lookup は委譲しない (往復のオーバーヘッドの方が高い)

## 委譲時のルール
- sub-agent は会話履歴を参照できない。仕様・制約・参照ファイルパスをプロンプトに明示して渡す
- 判断・設計・レビューの結論を sub-agent に任せない。成果物は必ずメインループでレビューする
- 互いに独立した委譲は1メッセージで同時に起動する

# 作業時のルール
- 作業開始時に必ず `docs/DESIGN.md` を読む。存在する場合は最優先のルールとして扱う
- worktree のパス: `projectRoot/worktree/<working branch>`
- document のパス: `projectRoot/docs/`
- 作業計画のパス: `projectRoot/docs/plans/<working branch>`
- 作業時は `projectRoot/docs/` を引き継いで worktree ディレクトリで作業する
- worktree で作業する場合、作業計画を参照する。無い場合は作る。情報が足りない場合はオペレーターから収集する

# branch 戦略
- base branch への merge は `--no-ff`
- base を feature に取り込むときは rebase。conflict を解消できないときは `--no-ff` merge でも可
- history は「綺麗さ」よりも「正確さ」優先

# コーディングスタイル
- coding-conventions 準拠
- 完全修飾は基本的に使用しない。import 推奨
- 実装後にコードフォーマットを行う
- Kotlin Coroutines / Flow 前提。Lifecycle を跨ぐ収集は `repeatOnLifecycle` を使う
- Hilt / DI の component scope、Fragment / ViewModel のライフサイクル差を考慮する
- `context!!` / `lateinit` を乱用しない

## naming
- List・配列型: 複数形の naming 禁止。`valueList` のように `値 + List` で命名する
- Map: 複数形の naming 禁止。`keyToValue` のように `キー名 + To + 値` で命名する
- メンバプロパティに tmp, data, v など何も説明していない命名を使わない

## コメント
- インラインコメントは最小限。書く場合は why を書く。what / how はコードから読み取れる
- コードに関係のないコメントをしない。例: issue 番号、テスト項目番号
- 公開 API の what (契約・引数・戻り値) は KDoc に記載する
- how は原則コードで表現し、非自明な場合のみインラインで補足する

# Commit Message
- Format: `<type>: #<issue number> <summary>`
- type: feat | fix | refactor | chore | docs | test
- summary: 変更内容のサマリを日本語で記載
- 曖昧な表現禁止 (例: "update", "modify")
- `Made-with: Cursor` など無関係なトレーラー不要
