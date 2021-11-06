module speed_convertor(clk, rst, speed_value, SW3_half_step, key1_quarterTurn, SW2_AUTO, out_flag);

	input wire clk, rst, SW3_half_step, key1_quarterTurn, SW2_AUTO;
	input wire [3:0] speed_value;
	
	
	output wire out_flag;
	
	wire countMaxOut;
	wire quarterTrunOut;
	
	wire [23:0]max_count;

	MaxCount maxCount(.clk(clk), .rst(rst), .speed_value(speed_value), .SW3_half_step(SW3_half_step), .max_count(max_count));
	
	CountToMax CountToMax(.clk(clk), .rst(rst), .max_count(max_count), .flag(countMaxOut));
	
	
	
	quarterTurn quarterTurn(.clk(clk), .rst(rst), .enable((~key1_quarterTurn) & (~SW2_AUTO)), .in(countMaxOut), .SW3_half_step(SW3_half_step), .out_flag(quarterTrunOut));
	

	assign out_flag = (~SW2_AUTO)? quarterTrunOut: countMaxOut; 

endmodule
