local http = require('http')

vim.keymap.set("n", "<leader>hr", function()
	local response = http.fetch_json("localhost:8080/api/v1/categories/", {
		method = "POST",
		headers = {
			"Content-Type: application/json",
		},
		body = {
			name = "Sushi",
		},
	})

	vim.print(response)
end, { desc = "[H]ttp [R]equest" })
