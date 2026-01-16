# WezTerm Configuration

個人用のWezTermターミナルエミュレータ設定プロジェクトです。Tokyo Nightテーマをベースに、Vim風のキーバインドと快適な操作性を実現しています。

![WezTerm Version](https://img.shields.io/badge/WezTerm-latest-blue)
![Platform](https://img.shields.io/badge/platform-macOS-lightgrey)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ 特徴

### 🎨 ビジュアル
- **Tokyo Nightテーマ**: 目に優しいダークカラースキーム
- **カスタムタブバー**: NerdFontsアイコンでモダンなデザイン
- **背景透過**: 10%透過 + macOSぼかし効果
- **動的透明度調整**: キーボードショートカットで即座に変更可能

### ⌨️ キーバインド
- **Leaderキー**: `Ctrl+q` (tmuxスタイル)
- **Vim風操作**: h/j/k/l、w/b/e、0/^/$ など
- **コピーモード**: 検索、選択、コピーの完全サポート
- **Quick Select**: 文字列パターンをハイライトして即座に選択
- **モジュール化**: 別ファイルで管理して保守性向上

### 🖱️ マウス操作
- **直感的な操作**: 左クリックで選択、右クリックでコピー/ペースト
- **ハイパーリンク**: Cmd+クリックでURL・ファイルパスを開く
- **柔軟なスクロール**: 通常/ページ単位のスクロール対応
- **クロスプラットフォーム**: Linux/macOS/Windowsで一貫した操作感

### ⚡ パフォーマンス
- **スクロールバック**: 10,000行
- **60 FPS**: 滑らかな動作
- **WebGpu**: 最新のGPUアクセラレーション

## 📦 インストール

### 1. WezTermのインストール

**macOS (Homebrew):**
```bash
brew install --cask wezterm
```

**または公式サイトからダウンロード:**
https://wezfurlong.org/wezterm/installation.html

### 2. 設定ファイルのセットアップ

```bash
# リポジトリをクローン
git clone https://github.com/kyoneken/wezterm-config.git
cd wezterm-config

# シンボリックリンクを作成
mkdir -p ~/.config/wezterm
ln -sf $(pwd)/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -sf $(pwd)/keybinds.lua ~/.config/wezterm/keybinds.lua
ln -sf $(pwd)/highlights.lua ~/.config/wezterm/highlights.lua
```

### 3. フォントのインストール（推奨）

**日本語プログラミングフォント（推奨）:**

```bash
brew tap homebrew/cask-fonts

# HackGen Console（推奨：Hack + 源ノ角ゴシック）
brew install --cask font-hackgen

# Noto Sans Mono CJK JP（Google製、完全日本語対応）
brew install --cask font-noto-sans-mono-cjk-jp

# または PlemolJP Console（IBM Plex Mono + IBM Plex Sans JP）
brew install --cask font-plemoljp

# または UDEV Gothic（BIZ UDゴシック + JetBrains Mono）
brew install --cask font-udev-gothic
```

**英語フォント（フォールバック用）:**

```bash
# JetBrains Monoフォント
brew install --cask font-jetbrains-mono

# Nerd Fonts（タブアイコン用）
brew install --cask font-jetbrains-mono-nerd-font
```

### 4. 動作確認

```bash
# 設定の構文チェック
/Applications/WezTerm.app/Contents/MacOS/wezterm ls-fonts | head -5

# WezTermを起動
open -a WezTerm
```

## 🚀 使い方

### 基本操作

#### タブ操作
- `Ctrl+q` → `c` : 新規タブ作成
- `Ctrl+q` → `n` : 次のタブへ
- `Ctrl+q` → `p` : 前のタブへ
- `Ctrl+q` → `1-9` : タブ番号で直接移動
- `Ctrl+q` → `x` : タブを閉じる

#### ペイン操作
- `Ctrl+q` → `Shift+¥` : 水平分割
- `Ctrl+q` → `-` : 垂直分割
- `Ctrl+q` → `h/j/k/l` : ペイン移動（Vim風）
- `Ctrl+q` → `w` : ペインを閉じる
- `Ctrl+q` → `r` : リサイズモード

#### リサイズモード
- `h/j/k/l` : ペインサイズ調整
- `Esc` または `Enter` : リサイズモード終了

### コピーモード

#### 基本操作
- `Ctrl+q` → `[` : コピーモード開始
- `h/j/k/l` : カーソル移動
- `w/b/e` : 単語移動
- `0/^/$` : 行内移動
- `g/G` : 先頭/末尾へ移動
- `Ctrl+u/d` : ページ移動

#### 検索
- `/` : 検索開始
- `Enter` : 検索実行してノーマルモードに戻る
- `n/N` : 次/前の検索結果へ
- `Ctrl+w` : 検索語句をクリア

#### 選択とコピー
- `v` : 文字選択開始
- `V` : 行選択
- `Ctrl+v` : 矩形選択
- `y` : コピーしてモード終了
- `Esc` または `q` : コピーモード終了

### 透明度・フォントサイズ調整

#### 透明度
- `Cmd+Ctrl + -` : 透明度を下げる（透ける）
- `Cmd+Ctrl + Shift + +` : 透明度を上げる（不透明に）
- `Cmd+Ctrl + 0` : デフォルト（0.90）にリセット

#### フォントサイズ
- `Ctrl + -` : フォントサイズを小さく
- `Ctrl + Shift + +` : フォントサイズを大きく
- `Ctrl + 0` : フォントサイズをリセット

### マウス操作

#### テキスト選択とコピー
- **左クリック＋ドラッグ** : テキスト選択
- **ダブルクリック** : 単語選択
- **トリプルクリック** : 行選択
- **右クリック** : 選択範囲がある場合はコピー、ない場合はペースト

#### ハイパーリンク
- **Cmd + クリック** : URLやファイルパスを開く
  - HTTP/HTTPS URL対応
  - GitHub リポジトリ（user/repo形式）
  - ファイルパス（絶対パス）
  - ローカルポート（localhost:3000など）

#### スクロール
- **マウスホイール** : 通常スクロール
- **Shift + ホイール** : ページ単位でスクロール
- **ミドルクリック** : 選択範囲をペースト（Linuxスタイル）

### その他
- `Cmd + c/v` : コピー＆ペースト（macOS標準）
- `Cmd + f` : 検索
- `Ctrl+q` → `Space` : Quick Select（文字列ハイライト選択）
- `Ctrl+q` → `Shift+r` : 設定リロード

### Quick Select機能（動的ハイライト）

**セッション内で動的にパターンを追加・管理**

- `Ctrl+q` → `Shift+h` : パターンを対話的に追加（パターン→HEX色を入力）
- `Ctrl+q` → `Ctrl+Shift+H` : Neovimで一括編集
- `Ctrl+q` → `Ctrl+h` : パターンをリロード（編集後）
- `Ctrl+q` → `Alt+h` : パターンをクリア
- `Ctrl+q` → `Space` : Quick Selectモード起動（登録パターンをハイライト）

**使い方の例：**
1. ログでERRORを赤くハイライトしたい
   - `Ctrl+q` → `Shift+h`
   - パターン入力: `ERROR`
   - HEX色入力: `#ff0000`
   - `Ctrl+q` → `Space` でハイライト表示

2. IPアドレスを緑でハイライト
   - `Ctrl+q` → `Shift+h`
   - パターン入力: `\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b`
   - HEX色入力: `#00ff00`

3. 複数パターンを一括編集（Neovim）
   - `Ctrl+q` → `Ctrl+Shift+H`
   - Neovimで編集（書式: `パターン HEX色`）
   - 保存して終了
   - `Ctrl+q` → `Ctrl+h` でリロード

**特徴：**
- ペインごとに独立したパターン管理
- セッション終了でクリア（一時的な用途向け）
- 正規表現対応
- Neovimの設定が反映される

## 🛠️ 開発環境

### 構成ファイル

```
wezterm-config/
├── wezterm.lua              # メイン設定ファイル
├── keybinds.lua            # キーバインド設定（モジュール）
├── highlights.lua          # 動的ハイライト管理（モジュール）
├── .github/
│   └── copilot-instructions.md  # 開発ガイドライン
└── README.md               # このファイル
```

### 技術スタック

- **設定言語**: Lua
- **ターミナル**: WezTerm (Rust製)
- **フォント**: HackGen Console 16pt (日本語対応、フォールバック: Noto Sans Mono CJK JP, JetBrains Mono)
- **テーマ**: Tokyo Night
- **バージョン管理**: Git + GitHub
- **プロジェクト管理**: GitHub Issues + Jira (SCRUM)

### 設定のカスタマイズ

#### 基本設定の変更
`wezterm.lua` を編集：

```lua
-- フォントサイズ変更
config.font_size = 18.0

-- フォント変更例1: Noto Sans Mono CJK JPメイン（Google風、丸み）
config.font = wezterm.font_with_fallback({
  { family = "Noto Sans Mono CJK JP", weight = "Regular" },
  { family = "HackGen Console", weight = "Regular" },
  { family = "JetBrains Mono", weight = "Medium" },
})

-- フォント変更例2: PlemolJP Console（IBM風）
-- config.font = wezterm.font_with_fallback({
--   { family = "PlemolJP Console", weight = "Regular" },
--   { family = "JetBrains Mono", weight = "Medium" },
-- })

-- 透明度変更
config.window_background_opacity = 0.85

-- ウィンドウサイズ変更
config.initial_cols = 160
config.initial_rows = 50
```

#### キーバインドの追加
`keybinds.lua` の `module.keys` に追加：

```lua
-- カスタムキーバインド例
{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
```

#### 設定の反映
- 変更後: `Ctrl+q` → `Shift+r` で即座に反映
- または: `Cmd+R`

### 開発ワークフロー

1. **ブランチ作成**
   ```bash
   git checkout -b feature/new-feature
   ```

2. **設定変更と動作確認**
   - 設定ファイルを編集
   - WezTermで `Ctrl+q` → `Shift+r` でリロード
   - 動作を確認

3. **コミット**
   ```bash
   git add .
   git commit -m "feat: 新機能の説明"
   git push -u origin feature/new-feature
   ```

4. **Pull Request作成**
   ```bash
   gh pr create --title "feat: 新機能" --body "説明" --base main
   ```

5. **GitHub Issue + Jira連携**
   ```bash
   # GitHub Issue作成
   gh issue create --title "機能名" --body "説明" --label "enhancement"
   
   # Jiraストーリー作成
   acli jira workitem create \
     --project "SCRUM" \
     --type "ストーリー" \
     --summary "機能名" \
     --description "説明\n\nGitHub Issue: URL"
   ```

## 📋 今後の予定

以下の機能追加を予定しています（詳細は[Issues](https://github.com/kyoneken/wezterm-config/issues)参照）：

- [ ] ステータスバーの強化（ディレクトリ、Git情報）
- [x] マウス操作の改善 ← **完了！**
- [x] Quick Select機能（文字列ハイライト） ← **完了！**
- [ ] 起動時のデフォルト設定
- [ ] 背景カスタマイズ
- [ ] 通知・ベル設定

## 🤝 コントリビューション

個人プロジェクトですが、提案やフィードバックは歓迎します！

1. Fork this repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📚 参考資料

- [WezTerm公式ドキュメント](https://wezfurlong.org/wezterm/)
- [Tokyo Nightテーマ](https://github.com/folke/tokyonight.nvim)
- [日本語プログラミングフォント一覧](https://github.com/yuru7/programming-fonts-jp)
- [HackGen](https://github.com/yuru7/HackGen)
- [Noto Sans Mono CJK JP](https://github.com/notofonts/noto-cjk)
- [PlemolJP](https://github.com/yuru7/PlemolJP)
- [UDEV Gothic](https://github.com/yuru7/udev-gothic)
- [JetBrains Monoフォント](https://www.jetbrains.com/lp/mono/)
- [Nerd Fonts](https://www.nerdfonts.com/)

## 📝 ライセンス

MIT License - 自由に使用、改変、配布できます。

## 👤 作者

**kyoneken**
- GitHub: [@kyoneken](https://github.com/kyoneken)

---

⭐ このプロジェクトが役に立ったら、スターをつけていただけると嬉しいです！
