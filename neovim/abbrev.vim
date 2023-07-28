iabbrev <expr> YMD strftime("%Y-%m-%d")

" TODO: move to vsnip config
autocmd FileType python iabbrev ifmain if __name__ == "__main__"
autocmd FileType python iabbrev adef async def
autocmd FileType python iabbrev awith async with
autocmd FileType python iabbrev bp breakpoint()
autocmd FileType python iabbrev ffia from __future__ import annotations
" Poor man's snippets
" autocmd FileType python nnoremap <Leader><Space>nq A  # noqa<Esc>
" autocmd FileType python nnoremap <Leader><Space>ns A  # nosec<Esc>
" autocmd FileType python nnoremap <Leader><Space>pd A  # pylint: disable=
" autocmd FileType python nnoremap <Leader><Space>ti A  # type: ignore<Esc>
