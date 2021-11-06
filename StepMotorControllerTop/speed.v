module speed(rst, speedKey, unitsDisplay, tensDisplay, speedValue);

	// input declarations
	input wire rst ,speedKey;

	// output declarations
	output wire [6:0] unitsDisplay;
	output wire [6:0] tensDisplay;
	output reg  [3:0] speedValue;
		
	// internal registers
	reg countDirection; 					//1 - up ; 0 - down
	
	// internal parameters
	parameter 	up 		= 1'b1,	
				zero	= 4'b0000,
				speed10 = 4'b0001,
				speed60 = 4'b0110;
		
	always @ (negedge speedKey or negedge rst)
		begin
			if (~rst) begin					// restart. reset enable at 0
				speedValue = speed10; 		// initial speed = 10
				countDirection = ~up; 			// initial direction = down
			end	
			
			else begin
					if(speedValue == speed10 || speedValue == speed60)		
						countDirection = ~countDirection;		//change direction	
					if(countDirection == up)					
						speedValue <= speedValue + 1;	// increase speed by 1
					else 
						speedValue <= speedValue - 1;	// decrease speed by 1
						

				end
		end	

	//output logic
	sevenSegment unitsConvert(.in(zero), 		 .out(unitsDisplay));		// output to display
	sevenSegment tensConvert(.in(speedValue),    .out(tensDisplay));		// output to display

endmodule
