local M = {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
	cmd = "MCP",
	config = function()
		local mcp = require("mcphub")
		mcp.setup({})
		-- mcp.on({ "servers_updated", "tool_list_changed", "resource_list_changed" }, register_copilotChat)
	end,
}
-- function register_copilotChat()
-- 	local mcp = require("mcphub")
-- 	local chatConfig = require("CopilotChat.config")
--
-- 	local hub = mcp.get_hub_instance()
-- 	if not hub then
-- 		return
-- 	end
--
-- 	local async = require("plenary.async")
-- 	local call_tool = async.wrap(function(server, tool, input, callback)
-- 		hub:call_tool(server, tool, input, {
-- 			callback = function(res, err)
-- 				callback(res, err)
-- 			end,
-- 		})
-- 	end, 4)
--
-- 	local access_resource = async.wrap(function(server, uri, callback)
-- 		hub:access_resource(server, uri, {
-- 			callback = function(res, err)
-- 				callback(res, err)
-- 			end,
-- 		})
-- 	end, 3)
-- 	local resources = hub:get_resources()
-- 	for _, resource in ipairs(resources) do
-- 		local name = resource.name:lower():gsub(" ", "_"):gsub(":", "")
-- 		chatConfig.functions[name] = {
-- 			uri = resource.uri,
-- 			description = type(resource.description) == "string" and resource.description or "",
-- 			resolve = function()
-- 				local res, err = access_resource(resource.server_name, resource.uri)
-- 				if err then
-- 					error(err)
-- 				end
--
-- 				res = res or {}
-- 				local result = res.result or {}
-- 				local content = result.contents or {}
-- 				local out = {}
--
-- 				for _, message in ipairs(content) do
-- 					if message.text then
-- 						table.insert(out, {
-- 							uri = message.uri,
-- 							data = message.text,
-- 							mimetype = message.mimeType,
-- 						})
-- 					end
-- 				end
--
-- 				return out
-- 			end,
-- 		}
-- 	end
--
-- 	local tools = hub:get_tools()
-- 	for _, tool in ipairs(tools) do
-- 		chatConfig.functions[tool.name] = {
-- 			group = tool.server_name,
-- 			description = tool.description,
-- 			schema = tool.inputSchema,
-- 			resolve = function(input)
-- 				local res, err = call_tool(tool.server_name, tool.name, input)
-- 				if err then
-- 					error(err)
-- 				end
--
-- 				res = res or {}
-- 				local result = res.result or {}
-- 				local content = result.content or {}
-- 				local out = {}
--
-- 				for _, message in ipairs(content) do
-- 					if message.type == "text" then
-- 						table.insert(out, {
-- 							data = message.text,
-- 						})
-- 					elseif message.type == "resource" and message.resource and message.resource.text then
-- 						table.insert(out, {
-- 							uri = message.resource.uri,
-- 							data = message.resource.text,
-- 							mimetype = message.resource.mimeType,
-- 						})
-- 					end
-- 				end
--
-- 				return out
-- 			end,
-- 		}
-- 	end
-- end

return M
