# Notes

some commands I used to fix miniaudio.h for h2pas.

```sed
s/^MA_API/extern/
s/MA_ATOMIC(\([^,]*\),\s*\([^)]*\))/\/*_Alignas(\1)*\/ \2/
s/^static/\/\/static/
s/volatile/\/*volatile*\//
s/MA_ATOMIC_SAFE_TYPE_DECL([^,]*,\s*\([^,]*\),\s*\([^)]*\))/typedef struct { _Alignas(\1) ma_\2 value; } ma_atomic_\2;/
s/MA_ATOMIC_SAFE_TYPE_DECL([^,]*,\s*\([^,]*\),\s*\([^)]*\))/typedef struct { \/*_Alignas(\1)*\/ ma_\2 value; } ma_atomic_\2;/
```

The anonymous unions were named.
The implementation section was removed.
Some macros were removed and fixed manually. You can run `diff miniaudio.h miniaudio_for_h2pas.h` to see all the changes.


Some fixes that were made in the translated with h2pas file.

```
sed -i -e 's/||/OR/g' miniaudio.pp
sed -i -e 's/&&/AND/g' miniaudio.pp
sed -f replace_not.sed miniaudio.pp
```


The import was added.
`uses Ctypes{$ifndef WIN32},unix{$endif};`

For `ma_context` and `ma_device` types the macros were added and `case`-s were removed;

All the functions and procedures were moved to the end of the file. The consts were moved to the beginning of the file. In short, all separate type declarations were merged into one.

Some platform specific macros were fixed. For example `${ifdef __WIN32__}` was replaced by `${ifdef WIN32}`. See https://wiki.freepascal.org/Platform_defines
