//Source: http://www.fpga4fun.com/PongGame.html

module vga_driver(input logic clk
);
reg [9:0] CounterX;
reg [8:0] CounterY;
wire CounterXmaxed = (CounterX==767);

always @(posedge clk)
if(CounterXmaxed)
  CounterX <= 0;
  CounterY <= CounterY + 1; //CounterY will overflow at 512. This means 512 pixels per column.

else
  CounterX <= CounterX + 1;





endmodule