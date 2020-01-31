import ("stdfaust.lib");
//fcut = vslider("freq  CUt [style:knob][scale:exp]", 880, 20, 10000, 1);
//order = 32;
//f1 = no.noise : fi.highpass(order,fcut): fi.lowpass(order,fcut);
//f2 = no.noise : fi.highpass(order,fcut*2): fi.lowpass(order,fcut*2);
Ebassf1 = fi.highpass(order, fcut) : fi.lowpass(order, fcut) : *(gain) : meter 
  with{
    order = 128;
    fcut = 250;
    f1group(x) = hgroup("[01] f1", x);
    gain = f1group(vslider("[01] GAIN", -24.2, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f1group(attach(x, an.amp_follower(0.5, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf2 = fi.highpass(order, fcut): fi.lowpass(order, fcut) : *(gain) : meter 
  with{
    order = 96;
    fcut = 1750;
    f2group(x) = hgroup("[02] f2", x);
    gain = f2group(vslider("[01] GAIN", -5.9, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f2group(attach(x, an.amp_follower(0.5, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf3 = fi.highpass(order, fcut): fi.lowpass(order, fcut): *(gain) : meter 
  with{
    order = 86;
    fcut = 2600;
    f3group(x) = hgroup("[03] f3", x);
    gain = f3group(vslider("[01] GAIN", 7, -96, +12, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f3group(attach(x, an.amp_follower(0.150, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf4 = fi.highpass(order, fcut): fi.lowpass(order, fcut): *(gain) : meter 
  with{
    order = 64;
    fcut = 3050;
    f4group(x) = hgroup("[04] f4", x);
    gain = f4group(vslider("[01] GAIN", 1, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f4group(attach(x, an.amp_follower(0.150, x) :ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};
Ebassf5 = fi.highpass(order, fcut): fi.lowpass(order, fcut): *(gain) : meter 
  with{
    order = 64;
    fcut = 3340;
    f5group(x) = hgroup("[05] f5", x);
    gain = f5group(vslider("[01] GAIN", -7.2, -96, +6, 0.1)) : ba.db2linear : si.smoo;
    meter(x) = f5group(attach(x, an.amp_follower(0.150, x) : ba.linear2db : vbargraph("[02] METER [unit:dB]", -70, +5)));
};

outmeter(x) = attach(x, an.amp_follower(0.150, x) : ba.linear2db : hbargraph("[02] OUTMETER [unit:dB]", -70, +5));
process =  no.noise <: hgroup("I FORMANTICO", Ebassf1, Ebassf2, Ebassf3, Ebassf4, Ebassf5) :>outmeter ;

 // vocale I voce di basso
 // 250 1750 2600 3050 3340 (frequenza)
 // 60 90 100 120 120 (larghezza di banda)
 // 0 -30 -16 -22 -28 (decibel)
