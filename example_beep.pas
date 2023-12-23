program bepp;

uses {$ifdef unix}cthreads, {$endif}SysUtils, crt, miniaudio;

{$H+}

const 
  DEVICE_CHANNELS = 2;
  DEVICE_SAMPLE_RATE = 48000;
  FREQ = 440;

  ATTACK = 37;
  DECAY = 12;
  SUSTAIN = 50;
  RELEASE = 37;
  AMPLITUDE = 0.5;
  NOTE_TIME = ATTACK + DECAY + SUSTAIN + RELEASE;


type
  ADSREnvelope = record
    cursor: single;
    time: single;
    framesInOsc: single;
    pUserData: pointer;
  end;
  PADSREnvelope = ^ADSREnvelope;

procedure dataCallback(pDevice: Pma_device;
  pOutput: pointer;
  pInput: pointer;
  frameCount: ma_uint32); cdecl;
var pEnvelope: PADSREnvelope;
  i, iChannel, idx, channelsCount: integer;
  value, volume, cursor, time: single;
  data: Psingle;
begin
  data := pOutput;
  pEnvelope := pDevice^.pUserData;
  channelsCount := DEVICE_CHANNELS;
  time := pEnvelope^.time;
  cursor := pEnvelope^.cursor;
  for i := 0 to frameCount - 1 do
  begin

    if time <= ATTACK then
    begin
      volume := (1/ATTACK) * time;
    end;

    if (time > ATTACK) and (time <= ATTACK + DECAY) then
    begin
      volume := (-0.5/DECAY) * time + 1 + (0.5/DECAY) * ATTACK;
    end;

    if (time > ATTACK + DECAY) and (time <= ATTACK + DECAY + SUSTAIN) then
    begin
      volume := 0.5;
    end;

    if (time >= ATTACK + DECAY + SUSTAIN) and (time <= ATTACK + DECAY + SUSTAIN + RELEASE) then
    begin
      volume := (-0.5/RELEASE) * time + 0.5 + (0.5 / RELEASE) * (ATTACK + DECAY + SUSTAIN);
    end;

    if time > ATTACK + DECAY + SUSTAIN + RELEASE then
    begin
      volume := 0;
    end;

    for iChannel := 0 to channelsCount - 1 do
    begin
      idx := i * channelsCount + iChannel;

      value := sin(2 * Pi * cursor) * AMPLITUDE;

      data[idx] := value * volume;
    end;

    cursor := cursor + pEnvelope^.framesInOsc;
    pEnvelope^.cursor := cursor;
    time := time + 1000 / DEVICE_SAMPLE_RATE;
    pEnvelope^.time := time;

  end;
end; 

function sleepAndStop(pDevice: pointer): ptrint;
begin
  sleep(NOTE_TIME + 10);
  ma_device_stop(pDevice);
end;

var deviceConfig: ma_device_config;
  device: ma_device;
  envelope: ADSREnvelope;
begin
  envelope.cursor := 0;
  envelope.framesInOsc := FREQ / DEVICE_SAMPLE_RATE;
  envelope.time := 0;

  deviceConfig := ma_device_config_init(ma_device_type_playback);
  deviceConfig.playback.format   := ma_format_f32;
  deviceConfig.playback.channels := DEVICE_CHANNELS;
  deviceConfig.sampleRate        := DEVICE_SAMPLE_RATE;
  deviceConfig.dataCallback      := @dataCallback;
  deviceConfig.pUserData         := @envelope;

  if ma_device_init(nil, @deviceConfig, @device) <> MA_SUCCESS then
  begin
    writeln('Failed to open playback device.');
    Exit;
  end;

  writeln('Device Name: ' + device.playback.name);

  if ma_device_start(@device) <> MA_SUCCESS then
  begin
    writeln('Failed to start playback device.');
    ma_device_uninit(@device);
    Exit;
  end;

  //BeginThread(@threadTimer, @device);
  sleepAndStop(@device);
    
  
  ma_device_uninit(@device);
end.
