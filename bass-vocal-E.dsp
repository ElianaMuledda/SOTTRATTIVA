import ("stdfaust.lib");
fcut = vslider("freq  CUt [style:knob][scale:exp]", 880, 20, 10000, 1);
order = 32;
f1 = no.noise : fi.highpass(order,fcut): fi.lowpass(order,fcut);
f2 = no.noise : fi.highpass(order,fcut*2): fi.lowpass(order,fcut*2);
Ebassf1 = no.noise : fi.highpass(128,600) : fi.lowpass(128,600) : *(gain) : meter 
  with{
    f1group(x) = hgroup("[01] f1", x);
    gain = f1group(vslider("[01] GAIN", -15, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f1group(attach(x, an.amp_follower(0.5, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf2 = no.noise : fi.highpass(128,1040): fi.lowpass(128,1040): *(gain) : meter 
  with{
    f2group(x) = hgroup("[02] f2", x);
    gain = f2group(vslider("[01] GAIN", -22, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f2group(attach(x, an.amp_follower(0.5, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf3 = no.noise : fi.highpass(128,2250): fi.lowpass(128,2250): *(gain) : meter 
  with{
    f3group(x) = hgroup("[03] f3", x);
    gain = f3group(vslider("[01] GAIN", -28.4, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f3group(attach(x, an.amp_follower(0.150, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf4 = no.noise : fi.highpass(128,2450): fi.lowpass(128,2450): *(gain) : meter 
  with{
    f4group(x) = hgroup("[04] f4", x);
    gain = f4group(vslider("[01] GAIN", -28.4, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f4group(attach(x, an.amp_follower(0.150, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf5 = no.noise : fi.highpass(128,2750): fi.lowpass(128,2750): *(gain) : meter 
  with{
    f5group(x) = hgroup("[05] f5", x);
    gain = f5group(vslider("[01] GAIN", -49.8, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f5group(attach(x, an.amp_follower(0.150, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};

process =  hgroup("E FORMANTICO", Ebassf1, Ebassf2, Ebassf3, Ebassf4, Ebassf5 :>_);
 
 // vocale E voce di basso
 // f1 f2 f3 f4 f5 
 // 600 1040 2250 2450 2750 (frequenze)
 // 60 70 110 120 130 (larghezza di banda Hz)
 // 0 -7 -9 -9 -20 (decibel)
 // a casa: far suonare la vocale E con questi parametri
