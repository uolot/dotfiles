local function get_current_string()
	local current_node = vim.treesitter.get_node()
	if not current_node then
		return
	end

	local node = current_node

	while node do
		if node:type() == "string_content" then
			return (vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf()))
			-- break
		end
		node = node:parent()
	end

	return nil
end

local function get_url()
	local repo = get_current_string()

	-- print("repo:")
	-- print(repo)

	if repo then
		return "https://github.com/" .. repo
	end

	return ""
end

return {
	config = function()
		function get_repo_edit_cmd()
			return "RepoEdit " .. get_url()
		end

		vim.cmd("command! RepoEditGithub lua vim.cmd(get_repo_edit_cmd())")
	end,
}
