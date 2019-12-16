local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local apps = require('apps')
local hotkeys_popup = require('awful.hotkeys_popup').widget


terminal = apps.terminal
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor



-- Theming Menu
beautiful.menu_font = "SF Display Regular 10"
beautiful.menu_submenu = '' -- ➤

-- icon theme is in `awesome/theme/default-theme.lua`
-- Search for `theme.icon_theme`

-- Check first if freedesktop module is installed
-- `awesome-freedesktop-git` is in AUR
-- https://github.com/lcpz/awesome-freedesktop
-- Check on your distro's repo

-- Checks if module exists, also checks syntax. Returns false if syntax error
local function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

-- Create a launcher widget and a main menu
myawesomemenu = {
  { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "Edit config", editor_cmd .. " " .. awesome.conffile },
  { "Restart", awesome.restart },
  { "Quit", function() awesome.quit() end },
}


-- Screenshot menu
local screenshot = {
  {"Full", apps.screenshot },
  {"Area", apps.screenshot }
}

-- Terminal menu
local terminal = {
  {"kitty", "kitty"},
  {"xterm", "xterm"},
}

-- Generate a list of app
if isModuleAvailable("freedesktop") == true then

  -- A menu generated by awesome-freedesktop
  -- https://github.com/lcpz/awesome-freedesktop

  local freedesktop = require("freedesktop")
  local menubar = require("menubar")

  mymainmenu = freedesktop.menu.build({
    icon_size = 16,
    before = {
      { "Terminal", terminal, menubar.utils.lookup_icon("utilities-terminal") },
      -- other triads can be put here
    },
    after = {
      {"Awesome", myawesomemenu--[[, "/usr/share/awesome/icons/awesome32.png"--]]},
      {"Take a Screenshot", screenshot},
      {"End Session", function() _G.exit_screen_show() end},
      -- other triads can be put here
    }
  })
  mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
  -- Menubar configuration


else

  -- A menu generated by xdg_menu

  -- Replace with the list generated by xdg_menu
  local a = {
  }
  local b = {
  }
  local c = {
  }
  local d = {
  }
  local e = {
  }
  local f = {
  }
  local g = {
    {"show_script", "notify-send 'Script:' 'xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu >~/.config/awesome/archmenu.lua'"}
  }


  mymainmenu = awful.menu({
    items = {
      {"Terminal", terminal},
      -- Replace the alphabets with the list generated by xdg_menu
      {"Replace", a},
      {"With", b},
      {"the", c},
      {"Apps", d},
      {"Generated", e},
      {"by", f},
      {"xdg_menu", g},
      {"Awesome", myawesomemenu},
      {"Take a Screenshot", screenshot},
      {"End Session", function() _G.exit_screen_show() end},
    }
  })

  mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

end