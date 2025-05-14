# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103
# pylint settings included to disable linting errors

# Load autoconfig first
config.load_autoconfig()

# Import modules
import sys
import os

# Add config folder to path
config_dir = os.path.expanduser("~/.config/qutebrowser/config")
sys.path.append(config_dir)

# Import modular config pieces
import appearance
import keymaps
import privacy
import search
import downloads

appearance.setup(c)
keymaps.setup(config)
privacy.setup(c)
search.setup(c)
downloads.setup(c)
