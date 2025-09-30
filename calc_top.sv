module calc_top( input logic  [9:0] SW,        // SW[3:0] = input new number, SW[8] = enable register B, SW[9] = enable register A
					  input logic  [1:0] KEY,		  // KEY[1] = clock, KEY[0] == active low reset
 					  output logic  [9:0] LEDR,	  // shows the value of SW
					  output logic  [6:0] HEX5,	  // displays input value saved in register A
					  output logic  [6:0] HEX4,	  // off
					  output logic  [6:0] HEX3,	  // displays input value saved in register B
					  output logic  [6:0] HEX2,     // off
					  output logic  [6:0] HEX1,     // second digit of the sum
					  output logic  [6:0] HEX0 );  // first digit of the sum
					  
		logic clock;
		logic reset;

	
		assign LEDR = SW; //Display switch  sequence with LEDs
		
		assign HEX2 = 7'b0110111; // Make sure HEX2 is = sign
		assign HEX4 = 7'b0001111; // Make sure HEX4 is + sign

	
		assign clock = KEY[1];
		assign reset = KEY[0];
		
		logic [3:0] A;		  //first input
		logic [3:0] B;      //second input
		logic [3:0] fdigit; //first digit of input
		logic [3:0] sdigit; //second digit of output
		logic [7:0] answer; //8 bits sum
		
		
		always_ff @(posedge clock or negedge reset) begin
	
		
			if(~reset) begin //if falling edge
				
					A <= 4'b0000;
					B <= 4'b0000;

				
				end else begin // if rising edge
				   
					if(SW[9]) A <= SW[3:0]; // store register A to value SW[3:0]
					
				   if(SW[8]) B <= SW[3:0]; // store register B to value SW[3:0] 
				
					
				end
				
			
		 end
		
		assign answer = A + B;
		assign fdigit = answer[3:0];
		assign sdigit = answer[7:4];
		
		
		
		sevenseg hex5(A,HEX5);
		sevenseg hex3(B,HEX3);
		sevenseg hex0(fdigit,HEX0);
		sevenseg hex1(sdigit,HEX1);
		
		
		
	endmodule

			