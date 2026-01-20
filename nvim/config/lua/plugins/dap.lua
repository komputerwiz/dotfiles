return {
	{
		'mfussenegger/nvim-dap',
		config = function()
			local dap = require('dap')

			vim.keymap.set('n', '<F4>', dap.toggle_breakpoint, { desc = 'DAP: Toggle breakpoint'})
			vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: Continue'})
			vim.keymap.set('n', '<F6>', dap.step_into, { desc = 'DAP: Step into'})
			vim.keymap.set('n', '<F7>', dap.step_over, { desc = 'DAP: Step over'})
			vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'DAP: Step out'})
			vim.keymap.set('n', '<F9>', dap.restart_frame, { desc = 'DAP: Restart frame'})
			vim.keymap.set('n', '<F10>', dap.terminate, { desc = 'DAP: Terminate'})
			vim.keymap.set('n', '<F11>', dap.run_to_cursor, { desc = 'DAP: Run to cursor'})

			require('dap.ext.vscode').type_to_filetypes = {
				lldb = { 'c', 'cpp', 'rust' },
			}

			vim.fn.sign_define('DapBreakpoint', { text = '', texthl='', linehl='', numhl='' })
			vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl='', linehl='', numhl='' })
			vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl='', linehl='', numhl='' })
			vim.fn.sign_define('DapLogPoint', { text = '', texthl='', linehl='', numhl='' })
		end,
	},
	{
		'rcarriga/nvim-dap-ui',
		dependencies = {
			'mfussenegger/nvim-dap',
			'nvim-neotest/nvim-nio',
		},
		config = function()
			local dap = require('dap')
			local dap_ui = require('dapui')

			vim.keymap.set('n', '<F12>', dap_ui.toggle, { desc = 'Toggle debug interface'})

			dap_ui.setup()

			dap.listeners.after.event_initialized['dapui_config'] = function()
				dap_ui.open()
			end

			dap.listeners.after.event_terminated['dapui_config'] = function()
				dap_ui.close()
			end

			dap.listeners.after.event_exited['dapui_config'] = function()
				dap_ui.close()
			end
		end,
	},
}
