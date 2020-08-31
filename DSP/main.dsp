import("stdfaust.lib");
gate = button("gate") : si.smoo;
process = os.sawtooth(440) * gate <: _,_;
