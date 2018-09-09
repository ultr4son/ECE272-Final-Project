module game (input logic p1_move_left, p1_move_right, start,
			 input logic clk,
			 input logic reset_n,
			 output logic [9:0] ball_x, ball_y, p1_paddle_x, p1_paddle_y,
			 output logic draw_start, draw_gameover
			 );
	parameter PADDLE_W = 50;
	parameter PADDLE_H = 100;
	parameter BALL_H = 10;
	parameter BALL_W = 10;
	
	logic reset;
	
	game_fsm_state fsm( 
		.clk(clk),
		.ball_y(ball_y),
		.start(start),
		.reset(reset),
		.reset_n(reset_n),
		.show_start(draw_start),
		.show_gameover(draw_gameover)
		);

	game_controller game(
		.p1_paddle_w(PADDLE_W),
		.p1_paddle_h(PADDLE_H),
		.ball_w(BALL_W),
		.ball_h(BALL_H),
		.clk(clk),
		.reset(reset),
		.p1_move_right(p1_move_right),
		.p1_move_left(p1_move_left),
		.ball_x(ball_x),
		.ball_y(ball_y),
		.p1_paddle_x(p1_paddle_x),
		.p1_paddle_y(p1_paddle_y)
	);
endmodule