module renderer(input logic clk,
				input logic [8:0] p1_paddle_x, p1_paddle_y, 
				input logic [8:0] ball_x, ball_y,
				input logic draw_start, draw_gameover,
				output logic vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b
				);
	parameter BALL_R = 1;
	parameter BALL_G = 0;
	parameter BALL_B = 1;
	
	parameter PADDLE_R = 1;
	parameter PADDLE_G = 1;
	parameter PADDLE_B = 1;
	
	parameter ball_h = 10;
	parameter ball_w = 10;
	
	parameter paddle_h = 10;
	parameter paddle_w = 50;
	
	logic inDisplayArea;
	logic [9:0] CounterX;
	logic [8:0] CounterY;


	hvsync_generator syncgen(.clk(clk), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), 
  .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));

	always_ff @ (posedge clk)
	begin
		if(inDisplayArea)
			begin
				if(draw_start)
					begin
						vga_r <= 0;
						vga_g <= 1;
						vga_b <= 0;
					end
				else if(draw_gameover)
					begin
						vga_r <= 1;
						vga_g <= 0;
						vga_b <= 0;
					end
				else if(CounterX >= ball_x & CounterX <= ball_x + ball_w & CounterY >= ball_y & CounterY <= ball_y + ball_h)
					begin
						vga_r <= BALL_R;
						vga_g <= BALL_G;
						vga_b <= BALL_B;
					end
				else if(CounterX >= p1_paddle_x & CounterX <= p1_paddle_x + paddle_w & CounterY >= p1_paddle_y & CounterY <= p1_paddle_y + paddle_h)
					begin 
						vga_r <= PADDLE_R;
						vga_g <= PADDLE_G;
						vga_b <= PADDLE_B;
					end
				else 
					begin
						vga_r <= 0;
						vga_g <= 0;
						vga_b <= 0;
					end
			end
		else
			begin
				vga_r <= 0;
				vga_g <= 0;
				vga_b <= 0;
			end
	end
	
endmodule