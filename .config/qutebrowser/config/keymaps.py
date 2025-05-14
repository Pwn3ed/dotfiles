def setup(config):
    config.bind('<Ctrl-j>', 'tab-next')
    config.bind('<Ctrl-k>', 'tab-prev')
    config.bind('xx', 'config-cycle statusbar.show always never ;; config-cycle tabs.show multiple never')
