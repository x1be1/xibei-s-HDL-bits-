module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);

	assign ringer=ring & ~vibrate_mode;
	

	assign motor=ring & vibrate_mode;

endmodule
//ringer=(vibrate_mode)?1'b0:ring;
//motor=(vibrate_mode)?ring:1'b0;