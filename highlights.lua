-- セッション動的ハイライト管理モジュール
-- ランタイムで文字列パターンとHEX色を追加/削除してハイライト

local wezterm = require("wezterm")
local module = {}

-- ペインごとのハイライトパターンを管理（pane_id -> patterns配列）
local pane_patterns = {}

-- 一時設定ファイルのパス
local temp_config_file = wezterm.home_dir .. "/.config/wezterm/highlight_temp.txt"

-- パターンファイルから読み込み
local function load_patterns_from_file()
  local patterns = {}
  local file = io.open(temp_config_file, "r")
  if file then
    for line in file:lines() do
      if not line:match("^%s*$") and not line:match("^%s*#") then
        local pattern, color = line:match("^(.-)%s+(.+)$")
        if pattern and color then
          table.insert(patterns, { pattern = pattern, color = color })
        else
          table.insert(patterns, { pattern = line, color = "#7aa2f7" })
        end
      end
    end
    file:close()
  end
  return patterns
end

-- パターンファイルに保存
local function save_patterns_to_file(patterns)
  local file = io.open(temp_config_file, "w")
  if file then
    file:write("# WezTerm 動的ハイライトパターン\n")
    file:write("# 書式: パターン HEX色\n")
    file:write("# 例: ERROR #ff0000\n\n")
    for _, entry in ipairs(patterns) do
      file:write(string.format("%s %s\n", entry.pattern, entry.color))
    end
    file:close()
  end
end

-- Neovimでパターンを編集
function module.edit_patterns()
  return wezterm.action_callback(function(window, pane)
    local pane_id = pane:pane_id()
    local patterns = pane_patterns[pane_id] or {}
    
    -- 現在のパターンを一時ファイルに保存
    save_patterns_to_file(patterns)
    
    -- Neovimで編集（分割して開く）
    pane:split({
      args = { "nvim", temp_config_file },
      direction = "Right",
      size = 0.4,
    })
  end)
end

-- パターンをリロード（ファイルから読み込んでペインに適用）
function module.reload_patterns()
  return wezterm.action_callback(function(window, pane)
    local pane_id = pane:pane_id()
    local patterns = load_patterns_from_file()
    pane_patterns[pane_id] = patterns
    
    -- Quick Selectパターンを更新
    local overrides = window:get_config_overrides() or {}
    local pattern_strings = {}
    for _, entry in ipairs(patterns) do
      table.insert(pattern_strings, entry.pattern)
    end
    overrides.quick_select_patterns = pattern_strings
    window:set_config_overrides(overrides)
    
    window:toast_notification("WezTerm", 
      string.format("%d個のハイライトパターンをロードしました", #patterns), 
      nil, 2000)
  end)
end

-- パターンをクリア
function module.clear_patterns()
  return wezterm.action_callback(function(window, pane)
    local pane_id = pane:pane_id()
    pane_patterns[pane_id] = {}
    
    local overrides = window:get_config_overrides() or {}
    overrides.quick_select_patterns = {}
    window:set_config_overrides(overrides)
    
    window:toast_notification("WezTerm", "ハイライトパターンをクリアしました", nil, 2000)
  end)
end

-- 対話的にパターンを追加（プロンプト経由）
function module.add_pattern_interactive()
  return wezterm.action.PromptInputLine({
    description = "ハイライトするパターン (正規表現):",
    action = wezterm.action_callback(function(window, pane, line)
      if not line or line == "" then
        return
      end
      
      -- 色の入力
      window:perform_action(
        wezterm.action.PromptInputLine({
          description = "HEX色コード (例: #ff0000) [Enter=デフォルト]:",
          action = wezterm.action_callback(function(inner_window, inner_pane, color_line)
            local color = (color_line and color_line ~= "") and color_line or "#7aa2f7"
            local pane_id = inner_pane:pane_id()
            
            -- パターンを追加
            pane_patterns[pane_id] = pane_patterns[pane_id] or {}
            table.insert(pane_patterns[pane_id], { pattern = line, color = color })
            
            -- ファイルに保存
            save_patterns_to_file(pane_patterns[pane_id])
            
            -- Quick Selectに適用
            local overrides = inner_window:get_config_overrides() or {}
            local pattern_strings = {}
            for _, entry in ipairs(pane_patterns[pane_id]) do
              table.insert(pattern_strings, entry.pattern)
            end
            overrides.quick_select_patterns = pattern_strings
            inner_window:set_config_overrides(overrides)
            
            inner_window:toast_notification("WezTerm", 
              string.format("パターン追加: %s (%s)", line, color), 
              nil, 2000)
          end),
        }),
        pane
      )
    end),
  })
end

return module
