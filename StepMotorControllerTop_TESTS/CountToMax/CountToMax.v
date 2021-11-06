module CountToMax(clk, rst, endCountValue, countMaxOutOut);

	// inputs declarations
	input wire clk, rst;
	input wire [23:0] endCountValue;
	
	// output declarations
	output wire countMaxOutOut;
	
	// internal registers
	reg [23:0] count;
	
	always @ (posedge clk or negedge rst) begin
			
		if (~rst)								// restart. reset enable at 0
			count <= 24'b0;
		else if (count >= endCountValue)		// counting is done
			count <= 24'b0;
		else
			count <= count + 24'b1; 			// increase count by 1
	end
		
	assign countMaxOutOut = (count >= endCountValue)? 1'b1: 1'b0;
	
endmodule


