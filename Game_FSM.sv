typedef enum { START_SCREEN, RESET ,GAME_OVER, PLAYING } State;
module game_fsm_state(input logic clk,
				input logic[9:0] ball_y,
				input logic start,
				input logic reset_n,
				output logic reset,
				output logic show_start,
				output logic show_gameover
				);
	State state;
	parameter GAMEOVER_Y = 500;
	logic [2:0] out;
	assign reset = out[0];
	assign show_start = out[1];
	assign show_gameover = out[2];
	always_ff@(posedge clk, negedge reset_n) begin
		if(!reset_n)
			state <= START_SCREEN;
		else
			begin
				if(start)
					state <= RESET;
				else if ((ball_y > GAMEOVER_Y) & state == PLAYING)
					state <= GAME_OVER;
				else if(state == RESET)
					state <= PLAYING;
				else begin
					state <= state;
					end
			end
		end
	
	always_ff@(posedge clk)
		case (state)
			START_SCREEN: out <= 'b110;
			RESET: out <= 'b100;
			GAME_OVER: out <= 'b101;
			PLAYING: out <= 'b000;
			default: out <= 'b100;
		endcase
endmodule
