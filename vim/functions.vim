" reverse lines order
command -range Reverse <line1>,<line2>!tac

" open the scratchpad
command Scratchpad e ~/scratchpad

" GoToGit - open current line in Github

function! GoToGit()
python3 << EOF
import re
import subprocess


def get_repo_url():
    remotes = get_remotes()
    remote = get_pref_remote(remotes)
    return remotes[remote]


def get_remotes():
    git_remote_output = subprocess.check_output(['git', 'remote', '-v']).decode()
    lines = [line for line in git_remote_output.split('\n') if line]
    remotes = {}
    for l in lines:
        name, rest = l.split('\t')
        url, info = rest.split(' ')
        if info == '(fetch)':
            remotes[name] = repourl(url)
    return remotes


def repourl(url):
    url = re.sub(r'^git@', 'https://', url)
    url = re.sub(r':([a-z]+)/', r'/\1/', url)
    url = re.sub(r'\.git$', '', url)
    return url


def get_pref_remote(remotes):
    for remote in ['upstream', 'origin']:
        if remote in remotes:
            return remote
    return list(remotes.keys())[0]


def file_path_git(path):
    output = subprocess.check_output(['git', 'ls-files', '--full-name', path])
    return output.decode().strip()


def fileurl(repo, path, line=0):
    if not path.startswith('/'):
        path = f'/{path}'
    line = f'#L{line+1}' if line else ''
    return f'{repo}/blob/master{path}{line}'


def get_gh_url():
    repo_url = get_repo_url()
    path = file_path_git(vim.eval('@%'))
    line = vim.current.range.start
    return fileurl(repo_url, path, line)


url = get_gh_url()
#vim.command(f'echo "{url}"')
vim.command(f'call system("xdg-open {url}")')
EOF
endfunction

command GoToGit call GoToGit()


" GoToPR - open PR under cursor in Github

function! GoToPR()
python3 << EOF

import re
# aaa#123 -> (None, None, 'aaa', '123')
# xxx/aaa#123 -> ('xxx/', 'xxx', 'aaa', '123')
pattern = r"(([a-zA-Z0-9-_]+)/)?([a-zA-Z0-9-_]+)#(\d+)"
word = vim.eval('expand("<cWORD>")')
m = re.search(pattern, word)
user, proj, prid = m[2], m[3], m[4]
user = user or "lyst"
prurl = f"https://git.lystit.com/{user}/{proj}/pull/{prid}"
vim.command(f'call system("xdg-open {prurl}")')

EOF
endfunction

command GoToPR call GoToPR()


" GoToRepo - open project name under cursor in Github

function! GoToRepo()
python3 << EOF
import re

word = vim.eval('expand("<cWORD>")')
m = re.search(r"[a-zA-Z0-9-_]+/[a-zA-Z0-9-_]+", word)
repo = m[0]
repourl = f"https://github.com/{repo}"
vim.command(f'call system("xdg-open {repourl}")')
EOF
endfunction

command GoToRepo call GoToRepo()


" GoToJira - open ticket under cursor in JIRA

function! GoToJira()
python3 << EOF
import re

word = vim.eval('expand("<cWORD>")')
m = re.search(r"[a-zA-Z]+-?[0-9]+", word)
ticket_id = m[0]
ticket_url = f"https://jira.lystit.com/browse/{ticket_id}"
vim.command(f'call system("xdg-open {ticket_url}")')
EOF
endfunction

command GoToJira call GoToJira()
