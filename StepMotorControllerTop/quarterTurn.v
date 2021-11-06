module quarterTurn(clk, rst, in, quarterTurnKey, stepSizeKey, quarterTurnOut); // sw3 (on) full step, (off) half step

	// input and output declaration
	input wire clk, rst, in, quarterTurnKey, stepSizeKey;
	output wire  quarterTurnOut;
	
	reg [6:0] count;
	reg [1:0] enableCount;
	reg longToShortPressReg;
	
	wire longToShortPressWire;
	
	parameter MaxFullStep = 7'h32,
			  MaxHalfStep = 7'h64,
			  
			  enableCountFullStep = 2'b10, // Enable full step
			  enableCountHalfStep = 2'b01; // Enable half step
			
	always @ (posedge clk or negedge rst) begin    
		if(~rst)
			longToShortPressReg <= 1'b0;
		
		else
			longToShortPressReg <= ~quarterTurnKey;	
	end

	assign longToShortPressWire = (~quarterTurnKey & ((~quarterTurnKey)^longToShortPressReg));
			
			
			
	always @ (posedge clk or negedge rst) begin
		if(~rst) begin
			enableCount <= 2'b0;
			count <= 7'b0;
		end
		
		else if (in && (enableCount != 2'b0)) begin         
			count <= count + 7'b1;     							// increase counter by 1 
			
		end
		else if ((count == MaxFullStep && enableCount == enableCountFullStep) ||
		 (count == MaxHalfStep && enableCount == enableCountHalfStep)) begin // if end count
			enableCount <= 2'b0;
			
		end
		

		else if (longToShortPressWire && enableCount == 2'b0) begin            // start to count
			count <= 7'b0;  
		    if(stepSizeKey)                    									// full or half step
		        enableCount = enableCountFullStep; 
		    else
		        enableCount = enableCountHalfStep;		        	        
		end

	end
		
	assign  quarterTurnOut = ((enableCount == enableCountFullStep) || (enableCount == enableCountHalfStep)) ? in: 1'b0;

endmodule

