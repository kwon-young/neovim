function! s:load_factor() abort
  let timeout = 200
  let times = []

  for _ in range(5)
    let g:val = 0
    call timer_start(timeout, {-> nvim_set_var('val', 1)})
    let start = reltime()
    while 1
      sleep 10m
      if g:val == 1
        let g:waited_in_ms = float2nr(reltimefloat(reltime(start)) * 1000)
        break
      endif
    endwhile
    call insert(times, g:waited_in_ms, 0)
  endfor

  let longest = max(times)
  let factor = (longest + 50.0) / timeout

  return factor
endfunction

" Compute load factor only once.
let s:load_factor = s:load_factor()

function! LoadAdjust(num) abort
  return float2nr(ceil(a:num * s:load_factor))
endfunction
