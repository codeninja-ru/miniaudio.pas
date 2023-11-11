program simple_playback;

uses crt, miniaudio;

{$H+}

procedure dataCallback(pDevice: Pma_device;
  pOutput: pointer;
  pInput: pointer;
  frameCount: ma_uint32); cdecl;
var pDecoder: Pma_decoder;
begin
  pDecoder := pDevice^.pUserData;
  if pDecoder = nil then Exit;

  ma_decoder_read_pcm_frames(pDecoder, pOutput, frameCount, nil);
end;

var result: ma_result;
  decoder: ma_decoder;
  deviceConfig: ma_device_config;
  device: ma_device;
  filename: string;

begin
  if paramCount() = 0 then
  begin
    writeln('No input file');
    Exit;
  end;

  filename := paramStr(1);
  result := ma_decoder_init_file(PChar(filename), nil, @decoder);
  if result <> MA_SUCCESS then
  begin
    writeln('Cound not load file: ' + filename);
    Exit;
  end;

  deviceConfig := ma_device_config_init(ma_device_type_playback);
  deviceConfig.playback.format := decoder.outputFormat;
  deviceConfig.playback.channels := decoder.outputChannels;
  deviceConfig.sampleRate := decoder.outputSampleRate;
  deviceConfig.dataCallback := @dataCallback;
  deviceConfig.pUserData := @decoder;

  if ma_device_init(nil, @deviceConfig, @device) <> MA_SUCCESS then
  begin
    writeln('Failed to start playback device');
    ma_decoder_uninit(@decoder);
    Exit;
  end;

  if ma_device_start(@device) <> MA_SUCCESS then
  begin
    writeln('Failed to start playback device');
    ma_device_uninit(@device);
    ma_decoder_uninit(@decoder);
    Exit;
  end;

  writeln('Press Enter to quit...');
  ReadKey;

  ma_device_uninit(@device);
  ma_decoder_uninit(@decoder);

end.
