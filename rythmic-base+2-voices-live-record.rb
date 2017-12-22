# SciArt Lab - Sonic Pi Scripts
# Rythmic base + two voices live record:
# Useful to record a line of bass + guitar chords
# Note: It will start recording after listening a beep 8 times (8 beats at 120 bpm).
# A countdown will be printed in the console from 8 to 1, so be ready to play on time!

use_bpm 120

counter = 8
live_loop :beats do
  if counter > 0
    puts "Countdown..."
    8.times do
      puts counter
      counter = counter - 1
      use_synth :beep
      play 80
      sleep 1
    end
  else
    sleep 8
  end
end

in_thread sync: :beats do
  puts "Record voice 1"
  with_fx :record, buffer: buffer[:voice, 8] do
    live_audio :testing
  end
end

in_thread sync: :beats do
  sleep 8
  puts "Record voice 2"
  with_fx :record, buffer: buffer[:voice2, 8] do
    live_audio :testing
  end
end


live_loop :drums, sync: :beats do
  sample :drum_snare_hard, beat_stretch: 0.25
  sleep 0.25
  sample :drum_heavy_kick, beat_stretch: 0.5
  sleep 0.5
  sample :drum_cymbal_soft, beat_stretch: 0.5
  sleep 0.5
  sample :drum_splash_hard, beat_stretch: 0.75
  sample :drum_tom_mid_hard, beat_stretch: 0.75
  sleep 0.75
end

live_loop :replay, sync: :beats do
  sample buffer[:voice], amp: 1
  sleep 8
end


live_loop :replay2, sync: :beats do
  sample buffer[:voice2], amp: 1
  sleep 8
end
