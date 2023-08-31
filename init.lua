local q = xplr.util.shell_quote

local function setup()
  local xplr = xplr

  xplr.fn.custom.edit_with = {}
  xplr.fn.custom.edit_with.lnav = function(app)
    local cmd = "lnav " .. q(app.focused_node.absolute_path)
    return redir_execute(cmd)
  end

  xplr.config.modes.custom.edit_with = {
    name = "edit focused file with nvim/emacs/vscode editor",
    key_bindings = {
      on_key = {
        ["c"]= {
          help = "edit with vscode",
          messages = {
            "PopMode",
            {
              BashExecSilently0 = [===[
                code "${XPLR_FOCUS_PATH:?}"
                ]===]
            }
          },
        },

        ["b"]= {
          help = "view with bat",
          messages = {
            "PopMode",
            {
              BashExec0 = [===[
                bat --pager='less --RAW-CONTROL-CHARS --no-init -R' "${XPLR_FOCUS_PATH:?}"
                ]===]
            }
          },
        },

        ["d"]= {
          help = "view with visidata (vd)",
          messages = {
            "PopMode",
            {
              BashExec0 = [===[
                vd "${XPLR_FOCUS_PATH:?}"
                ]===]
            }
          },
        },

        ["e"]= {
          help = "edit with emacs",
          messages = {
            "PopMode",
            {
              BashExecSilently0 = [===[
                open -a Emacs
                emacsclient -n "${XPLR_FOCUS_PATH:?}"
                ]===]
            }
          },
        },

        ["l"]= {
          help = "view with lnav",
          messages = {
            "PopMode",
            {
              CallLua = "custom.edit_with.lnav"
            }
          },
        },

        ["v"]= {
          help = "edit with nvim",
          messages = {
            "PopMode",
            {
              BashExec0 = [===[
                nvim "${XPLR_FOCUS_PATH:?}"
                ]===]
            }
          },
        },
      }
    }
  }

  xplr.config.modes.builtin.default.key_bindings.on_key["e"] = {
    help = "",
    messages = {
      { SwitchModeCustom = "edit_with" },
    },
  }
end

return { setup = setup }
