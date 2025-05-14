def setup(c):
    c.downloads.location.directory = '~/downloads'
    c.downloads.remove_finished = 5000
    c.editor.command = ['alacritty', '-e', 'nvim', '{file}']
