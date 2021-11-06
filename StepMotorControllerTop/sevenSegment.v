// Convert 4bit binary number to seven segment representation
module sevenSegment(in, out);

input wire [3:0] in;
output wire [6:0] out;

assign out = (in == 4'b0000) ? 7'h40 : 
			 (in == 4'b0001) ? 7'h79 :
			 (in == 4'b0010) ? 7'h24 :
			 (in == 4'b0011) ? 7'h30 :
			 (in == 4'b0100) ? 7'h19 :
			 (in == 4'b0101) ? 7'h12 :
			 (in == 4'b0110) ? 7'h02 :
			 (in == 4'b0111) ? 7'h78 :
			 (in == 4'b1000) ? 7'h00 :
		     (in == 4'b1001) ? 7'h10 :
			 //default
			 7'h40;		
endmodule
