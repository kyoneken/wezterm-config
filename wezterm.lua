-- WezTerm設定ファイル
-- Phase 1: 基本設定（フォント、カラー、ウィンドウ）

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

return config
