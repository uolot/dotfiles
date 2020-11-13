import os
import getpass
from lib import ask


GROUPS = [
    "docker",  # docker
    "input",
    "lp",  # bluetooth
    "video",  # brightness
    "dialout",  # MCUs
    "uucp",  # MCUs
    "lock",  # MCUs
    "plugdev",
]
USERNAME = getpass.getuser()


def add_user_to_groups():
    if not ask("Add user to groups?"):
        return

    for group in GROUPS:
        os.system(f"sudo gpasswd -a {USERNAME} {group}")


if __name__ == "__main__":
    add_user_to_groups()
