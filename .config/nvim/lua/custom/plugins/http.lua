return {
  {
    'leonardo-luz/http.nvim',
    opts = {
      print_response = false,
    },
    config = function()
      require 'custom.http'
    end
  },
}
