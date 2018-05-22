typedef enum { START_SCREEN, RESET ,GAME_OVER, PLAYING } State;
module game_fsm_state(input logic clk,
				input logic[9:0] ball_y,
				input logic start,
				output logic reset
				);
	State state;
	initial state = START_SCREEN;
	always_ff@(posedge clk)
		if(start)
			state <= RESET;
		else if (ball_y < 10 & state & PLAYING)
			state <= GAME_OVER;
		else if(RESET)
			state <= PLAYING;
	
	always_ff@(posedge clk)
		case (state)
			START_SCREEN: reset <= 1;
			RESET: reset <= 1;
			GAME_OVER: reset <= 1;
			PLAYING: reset <= 0;
			default: reset <= 1;
		endcase
endmodule
