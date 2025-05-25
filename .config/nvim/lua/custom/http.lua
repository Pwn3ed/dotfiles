local http = require('http')

vim.keymap.set("n", "<leader>hrs", function()
	local response = http.fetch_json("localhost:8080/signup", {
		method = "POST",
		headers = {
			"Content-Type: application/json",
		},
		body = {
			name = "Jose",
			password = "88888888",
			cpf = "11144477735",
			email = "bbbb@bbbb.com",
			role = "ADMIN",
		},
	})

	vim.print(response)
end, { desc = "[H]ttp [R]equest [S]ignup" })

vim.keymap.set("n", "<leader>hrl", function()
	local response = http.fetch_json("localhost:8080/login", {
		method = "POST",
		headers = {
			"Content-Type: application/json",
		},
		body = {
			email = "bbbb@bbbb.com",
			password = "88888888",
		},
	})

	vim.print(response)
end, { desc = "[H]ttp [R]equest [L]ogin" })

--- expires time: 1 hour
local token = ""

vim.keymap.set("n", "<leader>hrc", function()
	local response = http.fetch_json("localhost:8080/customer", {
		method = "GET",
		headers = {
			string.format("Authorization: Bearer %s", token)
		},
	})

	vim.print(response)
end, { desc = "[H]ttp [R]equest [C]ustomer" })
