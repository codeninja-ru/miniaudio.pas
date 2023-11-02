# Notes

```sed
s/^MA_API/extern/
s/MA_ATOMIC(\([^,]*\),\s*\([^)]*\))/\/*_Alignas(\1)*\/ \2/
s/^static/\/\/static/
s/volatile/\/*volatile*\//
%s/MA_ATOMIC_SAFE_TYPE_DECL([^,]*,\s*\([^,]*\),\s*\([^)]*\))/typedef struct { _Alignas(\1) ma_\2 value; } ma_atomic_\2;/
s/MA_ATOMIC_SAFE_TYPE_DECL([^,]*,\s*\([^,]*\),\s*\([^)]*\))/typedef struct { \/*_Alignas(\1)*\/ ma_\2 value; } ma_atomic_\2;/
```

sed -i -e 's/||/OR/g' miniaudio.pp
sed -i -e 's/&&/AND/g' miniaudio.pp
sed -f replace_not.sed miniaudio.pp > miniaudio.pp

1.
add use CTypes; // for size_t
type 

  size_t = csize_t;
  psize_t = ^size_t;

2. ~ 3886 add define(cpu64)
3. fix types ~3886
remove the section
```
{$if defined(MA_USE_STDINT)}
```

insert types

4. put the first type section with P* types to the end
