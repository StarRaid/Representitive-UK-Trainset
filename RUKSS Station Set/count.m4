// Automatically generated by GRFCODEC. Do not modify!
// (Info version 7)
// Format: spritenum pcxfile xpos ypos compression ysize xsize xrel yrel
divert(-1)
changequote({,})
changecom({//})
define({_N_count},1) dnl test sprite number counter
define(_N_COUNT,{define({_N_count},incr(_N_count))})
define(__NUMBER,{_N_count{}_N_COUNT})
define(__dword,{substr(eval($1,16,8),6,2) substr(eval($1,16,8),4,2) substr(eval($1,16,8),2,2) substr(eval($1,16,8),0,2)})
define(filesize,{{divert(1){}0 * 4 __dword(_N_count-1)}})
m4wrap(filesize)
divert
divert(2)
