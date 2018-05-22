module paddle_controller (input logic clk,
					      input logic reset,
						  input logic move_right, move_left,
						  output logic [9:0] x, y
						  );
	logic [9:0] dx;
	assign y = 10;
	always_ff@(posedge clk)
		begin
			if(reset)
				x <= 0;
			if(move_right)
				dx <= 10;
			else if(move_left)
				dx <= -10;
			x <= x + dx;
		end
	
endmodule

module ball_controller(input logic clk,
					   input logic reset,
					   input logic collision,
					   input logic [9:0] ddy,
					   output logic[9:0] x, y);
	logic [9:0] dy;
	//TODO: ask how to trigger on clk and reset signal
	always_ff@(posedge clk)
		begin
			if(!reset)
				begin
					dy <= 0;
					x <= 0;
					y <= 0;
				end
			if(collision)
				begin
					//dx <= -dx;
					dy <= -dy;
				end
				
			x <= x + 10;			
			dy <= dy + ddy;
			y <= y + dy;
		end
endmodule

module collision_detector(input logic [9:0] a_w, a_h, a_x, a_y,
						  input logic [9:0] b_w, b_h, b_x, b_y,
						  output logic collision);
	logic collision_y;
	assign collision_y = (a_y <= b_y + b_h) | (a_y + a_h >= b_y); //Just checking collision on y axis for now, add x if feeling fancy
	assign collision = collision_y;
endmodule

module game_controller(input logic [9:0] p1_paddle_w, p1_paddle_h,
					   input logic [9:0] ball_w, ball_h,
					   input logic clk,
					   input logic reset,
					   input logic p1_move_right, p1_move_left,
					   output logic [9:0] ball_x, ball_y, p1_paddle_x, p1_paddle_y
					   );
	
	logic [9:0] ball_x, ball_y;
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
		.a_x(paddle_x),
		.a_y(paddle_y),
		.b_w(ball_w),
		.b_h(ball_h),
		.b_x(ball_x),
		.b_y(ball_y),
		.collision(collision)
	);
	ball_controller ball(
		.clk(clk),
		.reset(reset),
		.ddy(-10),
		.x(ball_x),
		.y(ball_y),
		.collision(collision)
	);
endmodule