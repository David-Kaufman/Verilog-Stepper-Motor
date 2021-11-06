module motorStateMachine(clk ,rst, make_step, out, rotateDirectionKey, stepSizeKey);
	input wire 	clk,
				rst,
				make_step,
				rotateDirectionKey,			// ON(1) = clockwise ; OFF(0) = counter_clockwise;
				stepSizeKey;				// ON(1) = full step ; OFF(0) = half step;

	output wire [3:0] out;
	//wire make_step;
	
	reg [3:0] cs;
	reg [3:0] ns;
	
	parameter 	A  = 4'b1000, 	//8
				B  = 4'b0010, 	//2
				C  = 4'b0100, 	//4
				D  = 4'b0001, 	//1
				AB = 4'b1010,	//A
				BC = 4'b0110, 	//6
				CD = 4'b0101,	//5
				DA = 4'b1001;	//9
				
	//next state logic			
	always @ (posedge clk or negedge rst)
		begin
			if (~rst)	// restart. reset enable at 0
				cs = A;
				
			else if (make_step) begin
				
					cs = ns;
					
					// clockwise - full step
					// SW1 = 1 && SW3 = 1	
					if(rotateDirectionKey && stepSizeKey == 1'b1)	begin
						case(cs)
							A: ns = B;
							B: ns = C;
							C: ns = D;
							D: ns = A;
							default: ns = A;
						endcase
						end
					
					// clockwise - half step
					// SW1 = 1 && SW3 = 0	
					else if(rotateDirectionKey && stepSizeKey == 1'b0)	begin
							case(cs)
								A:  ns = AB;
								AB: ns = B;
								B:  ns = BC;
								BC: ns = C;
								C:  ns = CD;
								CD: ns = D;
								D:  ns = DA;
								DA: ns = A;
								default: ns = A;
							endcase
						end
					// counter clockwise - full step 
					// SW1 = 0 && SW3 = 1	
					else if((~rotateDirectionKey) && stepSizeKey == 1'b1)	begin
							case(cs)
								D: ns = C;
								C: ns = B;
								B: ns = A;
								A: ns = D;	
								default: ns = D;
							endcase
						end
					// counter clockwise - half step
					// SW1 = 0 && SW3 = 0	
					else if((~rotateDirectionKey) && stepSizeKey == 1'b0)	begin
							case(cs)
								D:  ns = CD;
								CD: ns = C;
								C:  ns = BC;
								BC: ns = B;
								B:  ns = AB;
								AB: ns = A;
								A:  ns = DA;
								DA: ns = D;
								default: ns = D;
							endcase
						end
				end //else if
				
			else
				cs <= cs;		
		end
	assign out = cs;
	
endmodule

