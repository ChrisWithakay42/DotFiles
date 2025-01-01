local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
  }
}

M.dap_ui = {
  plugin = true

}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint<CR>",
      "Add breakpoint at line"
    },
    ["<F5>"] = {
      function ()
        require("dap").continue()
      end,
      "Continue debugging"
    },
    ["<F10>"] = {
      function ()
        require("dap").step_over()
      end,
      "Step over in debugging"
    },
    ["<F11>"] = {
      function ()
        require("dap").step_into()
      end,
      "Step in to in debugging"
    },
    ["<F12>"] = {
      function ()
        require("dap").step_out()
      end,
      "Step out in debugging"
    },
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Run Go test"
    },
    ["<leader>dgl"] = {
        function()
          require("dap-go").debug_last()
        end,
      "Run last Go test"
      }
    }
  }

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json<CR>",
      "Add json struct tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml<CR>",
      "Add yaml struct tags"
    },
    ["<leader>gie"] = {
      "<cmd> GoIfErr<CR>",
      "Automaticall generate if err blocks"
    }
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpt"] = {
      function()
        require("dap-python").test_method()
      end,
      "Python run debug"
    }
  }
}

-- M.gotop = {
--   plugin = true,
--   n = {
--     ["<leader>gpd"] = {
--       function ()
--         require('goto-preview').goto_preview_definition()
--       end,
--       "Toggle window at definition"
--     },
--     ["<leader>gpi"] = {
--       function ()
--         require('goto-preview').goto_preview_implementation()
--       end,
--       "Toggle window at implementation"
--     },
--     ["<leader>gP"] = {
--       function ()
--         require('goto-preview').close_all_win()
--       end,
--       "Close all preview windows"
--     },
--     ["<leader>gpr"] = {
--       function ()
--         require('goto-preview').goto_preview_references()
--       end,
--       "Toggle window at references"
--     }
--   }
-- }
vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
vim.cmd("nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
vim.cmd("nnoremap gpD <cmd>lua require('goto-preview').goto_preview_declaration()<CR>")
vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
vim.cmd("nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>")

M.vim_test = {
  plugin = true,
  n = {
    ["<leader>tn"] = {
      "<cmd> :TestNearest<CR>",
      "Run test nearest to the cursor"
    }
  }
}

-- M.trouble = {
--   plugin = true,
--   n = {
--     ["<leader>tt"] = {
--       function ()
--         require("trouble").toggel()
--       end,
-- 	    "Toggle Trouble window"
--     },
--     ["<leader>tw"] = {
--       function ()
--         require("trouble").toggel("workspace_diagnostics")
--       end,
--       "Toggle Workspace Diagnostics"
--     },
--     ["<leader>td"] = {
--       function ()
--         require("trouble").toggle("document_diagnostics")
--       end,
--       "Toggle Document Diagnostics"
--     },
--     ["<leader>tq"] = {
--       function ()
--         require("trouble").toggle("quickfix")
--       end,
--       "Toggle Quickfix"
--     },
--     ["<leader>tl"] = {
--       function ()
--         require("trouble").toggle("loclist")
--       end,
--       "Toggle loclist"
--     },
--     ["<leader>gR"] = {
--       function ()
--         require("trouble").toggle("lsp_reference")
--       end,
--       "Toggle LSP reference"
--     }
--   }
-- }
-- Lua
vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>tw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>td", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

M.todo = {
  plugin = true,
  n = {
    ["<leader>]t"] = {
      function ()
        require("todo-comments").jump_next()
      end
    }
  }
}

-- M.scratch = {
--   plugin = true,
--   n = {
--     ["<leader>SN"] = {
--       "<cmd> Scratch<CR>"
--     },
--     ["<leader> SWN"] = {
--       "<cmd> ScratchWithName<CR>"
--     },
--     ["<leader> SO"] = {
--       "<cmd> ScratchOpen<CR>"
--     },
--     ["<leader> SF"] = {
--       "<cmd> ScratchOpenFzf<CR>"
--     },
--     ["<leader> SP"] = {
--       "<cmd> ScratchPad<CR>"
--     }
--   }
-- }
vim.keymap.set("n", "<leader>SN", "<cmd>Scratch<cr>")
vim.keymap.set("n", "<leader>SO", "<cmd>ScratchOpen<cr>")
vim.keymap.set("n", "<leader>SP", "<cmd>ScratchPad<cr>")

return M

