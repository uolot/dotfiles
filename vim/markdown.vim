" generate table of contents in markdown files
" commands: :GenTocGFM / :UpdateToc / :RemoveToc
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
    let g:vmt_auto_update_on_save = 1
    let g:vmt_fence_text = 'TOC'
    let g:vmt_fence_closing_text = '/TOC'
    let g:vmt_fence_hidden_markdown_style = 'GFM'


