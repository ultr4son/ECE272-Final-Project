module physics_object (
					  input logic [10:0] x, y
					  input logic [10:0] dx, dy
					  input logic [10:0] ddx, ddy
					  output logic [10:0] n_x, n_y
					  output logic [10:0] n_dx, n_dy);
		always_comb
			begin
				n_dx = dx + ddx;
				n_dy = dx + ddy;
				n_x = x + dx;
				n_y = y + dy;				
			end
endmodule;				 
