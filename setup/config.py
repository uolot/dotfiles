from pathlib import Path

HOME_DIR = Path().home()
DOTFILES_DIR = Path(__file__).absolute().parent.parent
SETUP_DIR = DOTFILES_DIR / "setup"
ARCH_DIR = SETUP_DIR / "arch"
