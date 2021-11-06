module StepMotorControllerTop(clk, rst, speedKey, stepSizeKey, rotateDirectionKey, operationModekey, quarterTurnKey, unitsDisplay, tensDisplay, out);

	input wire clk, rst, speedKey, stepSizeKey, rotateDirectionKey, operationModekey, quarterTurnKey;

	output wire [3:0] out;
	output wire [6:0] unitsDisplay;
	output wire [6:0] tensDisplay;
	
	wire [3:0] speedValueBusWire;
	wire speedControllerOutWire;

	speed speed(.rst(rst), .speedKey(speedKey), .unitsDisplay(unitsDisplay), .tensDisplay(tensDisplay), .speedValue(speedValueBusWire));
	
	motorController motorController(.clk(clk), .rst(rst), .speedValue(speedValueBusWire), .stepSizeKey(stepSizeKey),
									.quarterTurnKey(quarterTurnKey), .operationModekey(operationModekey), .speedControllerOut(speedConvertorOutWire));

	motorStateMachine motorStateMachine(.clk(clk), .rst(rst), .make_step(speedConvertorOutWire), .rotateDirectionKey(rotateDirectionKey),
	                                    .stepSizeKey(stepSizeKey), .out(out));

endmodule

