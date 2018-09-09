module paddle_controller (input logic clk,
					      input logic reset,
						  input logic move_right, move_left,
						  output logic [9:0] x, y
						  );

	parameter INIT_POS = 100;
	parameter DX = 5;
	assign y = 400;
	always_ff@(posedge clk, posedge reset)
		begin
			if(reset)
				x <= INIT_POS;
			else
				begin
					if(move_right)
						begin
							x <= x + DX;
						end
					else if(move_left)
						begin
							x <= x - DX;		
						end
					else
						begin
							x <= x;
						end
					
				end
		end
	
endmodule

module ball_controller(input logic clk,
					   input logic reset,
					   input logic collision,
					   input logic [9:0] ddy,
					   output logic[9:0] x, y);

	parameter INIT_POS_X = 100;
	parameter INIT_POS_Y = 300;
	parameter INIT_DX = 3;
	parameter INIT_DY = 0;
	logic signed [9:0] dy;
	logic signed [9:0] dx;
	logic collision_latch;
	always_ff@(posedge clk, posedge reset)
		begin
			if(reset)
				begin
					collision_latch <= 0;
					dy <= INIT_DY;
					dx <= INIT_DX;
					x <= INIT_POS_X;
					y <= INIT_POS_Y;
				end
			else
				begin
					//collision rising edge
					if(collision & ~collision_latch)
						begin
							dx <= -dx;
							dy <= -dy;				
							collision_latch <= 1;
						end
					else if(~collision & collision_latch)
						collision_latch <= 0;
					else
						dy <= dy + ddy;		
					x <= x + dx;
					y <= y + dy;
				end
		end
endmodule

module collision_detector(input logic [9:0] a_w, a_h, a_x, a_y,
						  input logic [9:0] b_w, b_h, b_x, b_y,
						  output logic collision);
	logic collision_y;
	logic collision_x;
	assign collision_x = (((b_x + b_w) >= a_x) & (b_x <= (a_x + a_w)));
	assign collision_y = (((b_y + b_h) > a_y)); 
	assign collision = collision_y & collision_x;
endmodule


module game_controller(input logic [9:0] p1_paddle_w, p1_paddle_h,
					   input logic [9:0] ball_w, ball_h,
					   input logic clk,
					   input logic reset,
					   input logic p1_move_right, p1_move_left,
					   output logic [9:0] ball_x, ball_y, p1_paddle_x, p1_paddle_y
					   );
	
	
	logic collision;
	
	
	paddle_controller player1(
		.clk(clk),
		.reset(reset),
		.move_right(p1_move_right),
		.move_left(p1_move_left),
		.x(p1_paddle_x),
		.y(p1_paddle_y)
	);
	collision_detector cdetect(
		.a_w(p1_paddle_w),
		.a_h(p1_paddle_h),
		.a_x(p1_paddle_x),
		.a_y(p1_paddle_y),
		.b_w(ball_w),
		.b_h(ball_h),
		.b_x(ball_x),
		.b_y(ball_y),
		.collision(collision)
	);
	ball_controller ball(
		.clk(clk),
		.reset(reset),
		.ddy(1),
		.x(ball_x),
		.y(ball_y),
		.collision(collision)
	);
endmodule