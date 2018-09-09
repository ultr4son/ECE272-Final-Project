module tennis (input logic p1_move_right, p1_move_left, start,
			   input logic reset_n,
			   output logic vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b
			   );
	logic [9:0] ball_x, ball_y, p1_paddle_x, p1_paddle_y;
	logic draw_start, draw_gameover;
	logic clk;
	logic game_clk;
	logic p1_move_right_inv;
	logic p1_move_left_inv;
	logic start_inv;
	assign p1_move_right_inv = ~p1_move_right;
	assign p1_move_left_inv = ~p1_move_left;
	assign start_inv = ~start;
	

	//assign draw_start = 1;
	//This is an instance of a special, built in module that accesses our chip's oscillator
	OSCH #("24.18") osc_int (	//"2.08" specifies the operating frequency, 2.08 MHz.
								//Other clock frequencies can be found in the MachX02's documentation
		.STDBY(1'b0),			//Specifies active state
		.OSC(clk),				//Outputs clock signal to 'clk' net
		.SEDSTDBY());			//Leaves SEDSTDBY pin unconnected

	clock_counter counter_1(
	.clk_i(clk),
	.reset_n(reset_n),
	.clk_o(game_clk));

	game gamelogic(
		.p1_move_right(p1_move_right_inv),
		.p1_move_left(p1_move_left_inv),
		.start(start_inv),
		.clk(game_clk),
		.reset_n(reset_n),
		.ball_x(ball_x),
		.ball_y(ball_y),
		.p1_paddle_x(p1_paddle_x),
		.p1_paddle_y(p1_paddle_y),
		.draw_start(draw_start),
		.draw_gameover(draw_gameover)
	);
	renderer render(
		.clk(clk),
		.ball_x(ball_x),
		.ball_y(ball_y),
		.p1_paddle_x(p1_paddle_x),
		.p1_paddle_y(p1_paddle_y),
		.draw_start(draw_start),
		.draw_gameover(draw_gameover),
		.vga_h_sync(vga_h_sync),
		.vga_v_sync(vga_v_sync),
		.vga_r(vga_r),
		.vga_g(vga_g),
		.vga_b(vga_b)
	);
endmodule