-- WezTerm設定ファイル
-- Phase 1: 基本設定（フォント、カラー、ウィンドウ）
-- Phase 2: タブバーのカスタマイズ
-- Phase 3: キーバインド設定

local wezterm = require("wezterm")
local config = wezterm.config_builder()

----------------------------------------------------
-- フォント設定
----------------------------------------------------
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 14.0

----------------------------------------------------
-- カラースキーム
----------------------------------------------------
config.color_scheme = "Tokyo Night"

----------------------------------------------------
-- ウィンドウ設定
----------------------------------------------------
-- ウィンドウの背景透過
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- ウィンドウの装飾
config.window_decorations = "RESIZE"

-- ウィンドウのパディング
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

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
