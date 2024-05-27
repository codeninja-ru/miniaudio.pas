program engine_hello_world;

uses crt, miniaudio;

{$H+}

var engine: ma_engine;
    filename: string;

begin
  if paramCount() = 0 then
  begin
    writeln('No input file.');
    Exit;
  end;

  if ma_engine_init(nil, @engine) <> MA_SUCCESS then
  begin
    writeln('Failed to initialize audio engine.');
    Exit;
  end;

  filename := paramStr(1);
  ma_engine_play_sound(@engine, PChar(filename), nil);

  writeln('Press Enter to quit...');
  ReadKey;

  ma_engine_uninit(@engine);
end.
