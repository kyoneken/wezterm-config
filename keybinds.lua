-- キーバインド設定モジュール
local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

----------------------------------------------------
-- ステータスバーにKey Tableの状態を表示
----------------------------------------------------
wezterm.on("update-right-status", function(window, pane)
  local name = window:active_key_table()
  if name then
    name = "TABLE: " .. name
  else
    name = ""
  end
  window:set_right_status(name)
end)

----------------------------------------------------
-- 基本キーバインド
----------------------------------------------------
module.keys = {
  -- タブ操作
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "x", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },

  -- ペイン分割（シンプルなキーバインド）
  { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- ペイン移動
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

  -- ペインクローズ
  { key = "w", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

  -- ペインリサイズモード
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },

  -- コピーモード
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

  -- 設定リロード
  { key = "r", mods = "LEADER|SHIFT", action = act.ReloadConfiguration },

  -- タブ番号で直接移動（1-9）
  { key = "1", mods = "LEADER", action = act.ActivateTab(0) },
  { key = "2", mods = "LEADER", action = act.ActivateTab(1) },
  { key = "3", mods = "LEADER", action = act.ActivateTab(2) },
  { key = "4", mods = "LEADER", action = act.ActivateTab(3) },
  { key = "5", mods = "LEADER", action = act.ActivateTab(4) },
  { key = "6", mods = "LEADER", action = act.ActivateTab(5) },
  { key = "7", mods = "LEADER", action = act.ActivateTab(6) },
  { key = "8", mods = "LEADER", action = act.ActivateTab(7) },
  { key = "9", mods = "LEADER", action = act.ActivateTab(8) },

  -- 通常のコピー＆ペースト（macOS標準）
  { key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

  -- 検索
  { key = "f", mods = "CMD", action = act.Search("CurrentSelectionOrEmptyString") },
}

----------------------------------------------------
-- Key Tables（特殊モード）
----------------------------------------------------
module.key_tables = {
  -- リサイズモード
  resize_pane = {
    { key = "h", action = act.AdjustPaneSize({ "Left", 5 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 5 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },

    -- Escで終了
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter", action = "PopKeyTable" },
  },

  -- コピーモード
  copy_mode = {
    -- カーソル移動
    { key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },

    -- 選択
    { key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

    -- コピー
    { key = "y", mods = "NONE", action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }) },

    -- 検索
    { key = "/", mods = "NONE", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "n", mods = "NONE", action = act.CopyMode("NextMatch") },
    { key = "N", mods = "SHIFT", action = act.CopyMode("PriorMatch") },

    -- ページ移動
    { key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
    { key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
    { key = "u", mods = "CTRL", action = act.CopyMode("PageUp") },
    { key = "d", mods = "CTRL", action = act.CopyMode("PageDown") },

    -- 終了
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    { key = "q", mods = "NONE", action = act.CopyMode("Close") },
  },

  -- 検索モード
  search_mode = {
    { key = "Enter", mods = "NONE", action = act.ActivateCopyMode },
    { key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
    { key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
    { key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
    { key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
    { key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
  },
}

return module
