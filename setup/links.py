from config import DOTFILES_DIR, HOME_DIR
from lib import ask

LINKS = {
    "alacritty/alacritty.yml": ".config/alacritty/alacritty.yml",
    "bin": "Bin",
    "bash/bashrc": ".bashrc",
    "bash/bash_profile": ".bash_profile",
    "bash/inputrc": ".inputrc",
    "ctags/config.ctags": ".ctags.d/config.ctags",
    "fusuma/config.yml": ".config/fusuma/config.yml",
    "git/config": ".gitconfig",
    "git/ignore": ".gitignore",
    "ipython/ipython_config.py": ".ipython/profile_default/ipython_config.py",
    "ipython/startup/vim.py": ".ipython/profile_default/startup/vim.py",
    "pam/pam_environment": ".pam_environment",
    "sway/flashfocus.yml": ".config/flashfocus/flashfocus.yml",
    "sway/i3status": ".config/i3status/config",
    "sway/i3status-rust.toml": ".config/i3status-rust/config.toml",
    "sway/config": ".config/sway/config",
    "sway/swayr-config.toml": ".config/swayr/config.toml",
    "TabNine.toml": ".config/TabNine/TabNine.yml",
    "tmux/tmux.conf": ".tmux.conf",
    "vim/ftplugin": ".vim/ftplugin",
    "vim/vimrc": ".vimrc",
    "wofi/style.css": ".config/wofi/style.css",
}


def create_links():
    if not ask("Create symlinks?"):
        return

    print("Creating symlinks")
    print("Dotfiles path:", DOTFILES_DIR)

    for src, dest in LINKS.items():
        src_path = DOTFILES_DIR / src
        dest_path = HOME_DIR / dest

        dest_dir = dest_path.parent
        if not dest_dir.exists():
            print(f"Creating {dest_dir}")
            dest_dir.mkdir(parents=True)

        print(f"Linking {dest_path} -> {src_path}")
        if dest_path.is_symlink():
            dest_links_to = dest_path.resolve()
            if dest_links_to != src_path and ask(
                f"\t{dest_path} is a symlink to {dest_links_to}, overwrite?"
            ):
                link(src_path, dest_path, unlink=True)
        elif dest_path.is_file():
            if ask(f"\t{dest_path} is a regular file, overwrite?"):
                link(src_path, dest_path, unlink=True)
        else:
            link(src_path, dest_path)


def link(src_path, dest_path, *, unlink=False):
    try:
        if unlink:
            print(f"\tremoving {dest_path}")
            dest_path.unlink()
        print(f"\tlinking {dest_path} -> {src_path}")
        dest_path.symlink_to(src_path)
    except Exception as e:
        print("\t", e)


if __name__ == "__main__":
    create_links()
    print("Add contents of ~/.pam_environment to /etc/environment")
    with open("~/.pam_environment") as f:
        print(f.read())
