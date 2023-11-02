program simple_playback_sine;

uses crt, miniaudio;

{$H+}

const 
DEVICE_CHANNELS = 2;
DEVICE_SAMPLE_RATE = 48000;

procedure dataCallback(pDevice: Pma_device;
  pOutput: pointer;
  pInput: pointer;
  frameCount: ma_uint32); cdecl;
var pSineWave: pma_waveform;
begin

  pSineWave := pDevice^.pUserData;
  ma_waveform_read_pcm_frames(pSineWave, pOutput, frameCount, nil);
end;

var sineWave: ma_waveform;
  deviceConfig: ma_device_config;
  device: ma_device;
  sineWaveConfig: ma_waveform_config;
begin

  deviceConfig := ma_device_config_init(ma_device_type_playback);
  deviceConfig.playback.format   := ma_format_f32;
  deviceConfig.playback.channels := DEVICE_CHANNELS;
  deviceConfig.sampleRate        := DEVICE_SAMPLE_RATE;
  deviceConfig.dataCallback      := @dataCallback;
  deviceConfig.pUserData         := @sineWave;

  if ma_device_init(nil, @deviceConfig, @device) <> MA_SUCCESS then
  begin
    writeln('Failed to open playback device.');
    Exit;
  end;

  writeln('Device Name: ' + device.playback.name);

  sineWaveConfig := ma_waveform_config_init(device.playback.format, device.playback.channels, device.sampleRate, ma_waveform_type_sine, 0.2, 220);
  ma_waveform_init(@sineWaveConfig, @sineWave);

  if ma_device_start(@device) <> MA_SUCCESS then
  begin
    writeln('Failed to start playback device.');
    ma_device_uninit(@device);
    Exit;
  end;
    
  writeln('Press Enter to quit...');
  ReadKey;
  
  ma_device_uninit(@device);
end.
