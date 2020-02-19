def get_vim():
    try:
        import neovim
    except ImportError:
        raise Exception(
            "Couldn't import 'neovim' module. Install with 'pip install pynvim'"
        )

    print("Execute:")
    print("echo neovim_rpc#serveraddr()")
    path = input("Result: ")
    if not path:
        raise Exception("Unknown path: 'path'")

    vim = neovim.attach("socket", path=path)
    vim.line = lambda: vim.eval('line(".")') - 1
    return vim
