#!/bin/env python3

import os
from collections import OrderedDict

KEYS = [
    # PATH
    "PATH",
    "CS154_ADMIN",
    "BREW_PREFIX",
    "CONDA_PYTHON_EXE",
    "SPACESHIP_ROOT",
    "COLORFGBG",
    "XPC_SERVICE_NAME",
    "_CE_M",
    "XPC_FLAGS",
    "LANG",
    # terminal
    "VISUAL",
    "LESS",
    "LOGNAME",
    "COLORTERM",
    "HISTFILE",
    "LC_TERMINAL",
    "LC_TERMINAL_VERSION",
    "ITERM_SESSION_ID",
    "ITERM_PROFILE",
    "TERM_SESSION_ID",
    "TERM_PROGRAM",
    "STARSHIP_SESSION_KEY",
    "STARSHIP_CONFIG",
    "VI_MODE_SET_CURSOR",
    "_",
    "LSCOLORS",
    "ZSH",
    "EDITOR",
    # XDG
    "XDG_DATA_HOME",
    "XDG_STATE_HOME",
    "XDG_CACHE_HOME",
    "XDG_CONFIG_HOME",
]


def main():
    env = os.environ.copy()
    env = OrderedDict(sorted(env.items()))
    home_directory = os.path.expanduser("~")
    dst_file = "{}/.config/nvim/lua/rayandrew/env.lua".format(home_directory)
    with open(dst_file, "w") as f:
        for key, value in env.items():
            if key in KEYS:
                if key == "PATH":
                    f.write('vim.env.PATH = vim.env.PATH .. "{}"\n'.format(value))
                    continue
                f.write('vim.fn.setenv("{}", "{}")\n'.format(key, value))
        f.close()


if __name__ == "__main__":
    main()
