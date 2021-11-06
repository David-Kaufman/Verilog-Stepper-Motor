module MaxCount(clk, rst, speedValue, stepSizeKey, maxCountOut);

	// input declarations
	input wire 	clk,
				rst, 
				stepSizeKey; 	// ON(1) = full step ; OFF(0) = half step
				
	input wire [3:0] speedValue;
	
	//output declarations
	output reg [23:0] maxCountOut;
	
	//speed values
	parameter   speed10 = 4'b0001,
				speed20 = 4'b0010,
				speed30 = 4'b0011,
				speed40 = 4'b0100,
				speed50 = 4'b0101,
				speed60 = 4'b0110;
	
	// 50MHz clk
	parameter 	count10_full_step = 24'h16e360,
				count20_full_step = 24'hb71b0,
				count30_full_step = 24'h7a120,
				count40_full_step = 24'h5b8d8,
				count50_full_step = 24'h493e0,
				count60_full_step = 24'h3d090;
	
	parameter 	count10_half_step = 24'hb71b0,
				count20_half_step = 24'h5b8d8,
				count30_half_step = 24'h3d090,
				count40_half_step = 24'h2dc6c,
				count50_half_step = 24'h249f0,
				count60_half_step = 24'h1e848;
				
	
	always @ (posedge clk or negedge rst)
	begin

		if (~rst)							// restart. reset enable at 0
			maxCountOut = count10_full_step; 	// on reset set maax_count to speed10
		else
			case(speedValue)
				  speed10:	maxCountOut = stepSizeKey ? count10_full_step : count10_half_step;
				  speed20:	maxCountOut = stepSizeKey ? count20_full_step : count20_half_step;
				  speed30:	maxCountOut = stepSizeKey ? count30_full_step : count30_half_step;
				  speed40:	maxCountOut = stepSizeKey ? count40_full_step : count40_half_step;
				  speed50:	maxCountOut = stepSizeKey ? count50_full_step : count50_half_step;
				  speed60:	maxCountOut = stepSizeKey ? count60_full_step : count60_half_step;
				  default:	maxCountOut = count10_full_step; 
			endcase // case		
	end	


endmodule

