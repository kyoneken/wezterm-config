-- WezTerm設定ファイル
-- Phase 1: 基本設定（フォント、カラー、ウィンドウ）
-- Phase 2: タブバーのカスタマイズ
-- Phase 3: キーバインド設定
-- Phase 4-1: スクロールバック＆カーソル設定
-- Phase 4-3: マウス操作の改善

local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------
-- フォント設定
----------------------------------------------------
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 16.0

----------------------------------------------------
-- カラースキーム
----------------------------------------------------
config.color_scheme = "Tokyo Night Storm"

----------------------------------------------------
-- ウィンドウ設定
----------------------------------------------------
-- 初期ウィンドウサイズ
config.initial_cols = 140
config.initial_rows = 40

-- ウィンドウの背景透過
config.window_background_opacity = 0.90
config.macos_window_background_blur = 20

-- ウィンドウの装飾
config.window_decorations = "TITLE | RESIZE"

-- ウィンドウのパディング
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

----------------------------------------------------
-- カーソル設定
----------------------------------------------------
-- カーソルの形状（Block, Underline, Bar）
config.default_cursor_style = "BlinkingBlock"

-- カーソルの点滅速度（ミリ秒）
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- カーソルの色（デフォルトはテーマに従う）
-- config.colors.cursor_bg = "#7aa2f7"
-- config.colors.cursor_fg = "#1a1b26"

----------------------------------------------------
-- パフォーマンス設定
----------------------------------------------------
-- フレームレート
config.max_fps = 60

-- アニメーション
config.animation_fps = 60

-- GPUアクセラレーション（デフォルトで有効）
config.front_end = "WebGpu"

----------------------------------------------------
-- タブバー設定
----------------------------------------------------
-- タブバーを有効化
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

-- タブの最大幅
config.tab_max_width = 32

-- タブバーの背景色
config.colors = {
  tab_bar = {
    background = "#1a1b26",
  },
  -- コピーモードの選択範囲
  copy_mode_active_highlight_bg = { Color = "#7aa2f7" },
  copy_mode_active_highlight_fg = { Color = "#1a1b26" },
  copy_mode_inactive_highlight_bg = { Color = "#3b4261" },
  copy_mode_inactive_highlight_fg = { Color = "#c0caf5" },
  
  -- 通常の選択範囲の色
  selection_bg = "#3b4261",
  selection_fg = "#c0caf5",
}

-- タブの追加ボタンを非表示
config.show_new_tab_button_in_tab_bar = false

-- タブバーのスタイル
config.window_frame = {
  font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
  font_size = 12.0,
}

----------------------------------------------------
-- カスタムタブの見た目
----------------------------------------------------
-- NerdFontsのアイコン
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = "#3b4261"
  local foreground = "#c0caf5"

  if tab.is_active then
    background = "#7aa2f7"
    foreground = "#1a1b26"
  elseif hover then
    background = "#545c7e"
    foreground = "#c0caf5"
  end

  local edge_background = "#1a1b26"
  local edge_foreground = background

  local title = tab.active_pane.title
  -- タイトルが長すぎる場合は短縮
  if #title > max_width - 6 then
    title = wezterm.truncate_right(title, max_width - 6) .. "…"
  end

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. title .. " " },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },
  }
end)

----------------------------------------------------
-- マウス設定
----------------------------------------------------
-- マウスバインディング
config.mouse_bindings = {
  -- 右クリックでコンテキストメニュー
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        -- 選択範囲がある場合はコピー
        window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
      else
        -- 選択範囲がない場合はペースト
        window:perform_action(wezterm.action.PasteFrom("Clipboard"), pane)
      end
    end),
  },

  -- Cmd+クリックでハイパーリンクを開く
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = wezterm.action.OpenLinkAtMouseCursor,
  },

  -- ミドルクリックでペースト
  {
    event = { Down = { streak = 1, button = "Middle" } },
    mods = "NONE",
    action = wezterm.action.PasteFrom("PrimarySelection"),
  },

  -- Shift+スクロールでページ移動
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = "SHIFT",
    action = wezterm.action.ScrollByPage(-0.5),
  },
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = "SHIFT",
    action = wezterm.action.ScrollByPage(0.5),
  },
}

-- ハイパーリンク検出ルール
config.hyperlink_rules = {
  -- HTTP/HTTPS URL
  {
    regex = "\\b\\w+://[\\w\\.\\-]+\\.[a-z]{2,15}\\S*\\b",
    format = "$0",
  },
  
  -- 暗黙的なHTTPS（www.example.com）
  {
    regex = [[\bwww\.[a-z0-9\-]+\.[a-z]{2,15}\S*\b]],
    format = "https://$0",
  },

  -- GitHub リポジトリ（user/repo形式）
  -- スペース区切りまたは行頭/行末で囲まれたuser/repo形式
  {
    regex = [[\b[a-z0-9][a-z0-9\-]{1,38}/[a-z0-9._\-]{2,100}\b]],
    format = "https://github.com/$0",
  },

  -- ファイルパス（絶対パス）
  -- /で始まり、有効なファイル名文字が続くパス
  {
    regex = [[\b/[\w\-\./]+\b]],
    format = "file://$0",
  },

  -- ローカルポート（localhost:3000など）
  {
    regex = [[\blocalhost:\d{1,5}\b]],
    format = "http://$0",
  },
  {
    regex = [[\b127\.0\.0\.1:\d{1,5}\b]],
    format = "http://$0",
  },
}

-- スクロール設定
config.scrollback_lines = 10000
config.enable_scroll_bar = false

-- マウスでのテキスト選択を有効化（デフォルトで有効だが明示的に設定）
config.selection_word_boundary = " \t\n{}[]()\"'`"

----------------------------------------------------
-- キーバインド設定
----------------------------------------------------
-- デフォルトのキーバインドを無効化
config.disable_default_key_bindings = true

-- Leaderキー: Ctrl+q（2秒タイムアウト）
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

-- 外部モジュールからキーバインドを読み込み
local keybinds = require("keybinds")
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

return config
