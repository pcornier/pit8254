`timescale 1ns/10ps

module tb();

parameter PERIOD = 10;

reg [7:0] Di;
wire [7:0] Do;
reg RD, WR, CS, A0, A1;
reg clk0, clk1, clk2;
reg gate0, gate1, gate2;
wire out0, out1, out2;

pit8254 pit(
  .Di(Di),
  .Do(Do),
  .RD(RD),
  .WR(WR),
  .CS(CS),
  .A0(A0),
  .A1(A1),
  .clk0(clk0),
  .clk1(clk1),
  .clk2(clk2),
  .gate0(gate0),
  .gate1(gate1),
  .gate2(gate2),
  .out0(out0),
  .out1(out1),
  .out2(out2)
);

initial begin
  clk0 = 0;
  clk1 = 0;
  clk2 = 0;
  forever #(PERIOD/2) clk0 = ~clk0;
  forever #(PERIOD/2) clk1 = ~clk1;
  forever #(PERIOD/2) clk2 = ~clk2;
end


initial begin

  $dumpfile("dump.vcd");
  $dumpvars(0, tb);

  CS = 0;
  WR = 0;
  RD = 0;
  A0 = 0;
  A1 = 0;
  Di = 0;

#(PERIOD) /////////////////////// MODE 0

  // write ctrl word
  A1 = 1; A0 = 1;
  WR = 0;
  RD = 1;
  Di = 8'b00_11_000_0; // c0 h/l mode 0 bin

#(PERIOD)
  RD = 0;

#(PERIOD)

  // write lsb counter 0
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'hff;

#(PERIOD)
  RD = 0;

#(PERIOD)

  // write msb counter 0
  // should be $1ff
  RD = 1;
  Di = 8'h1;

#(PERIOD)

  // start counting
  RD = 0;
  gate0 = 1;

#(PERIOD*2)

  // read counter 0
  RD = 0;
  WR = 1;

#(PERIOD) //////////////// LATCH CMD

  A1 = 1; A0 = 1;
  WR = 0;
  RD = 1;
  Di = 8'b00_00_000_0; // c0 latch

#(PERIOD)

  // read 0 (should be latch)
  RD = 0;
  WR = 1;
  A1 = 0; A0 = 0;

#(PERIOD*10)

  // pause
  gate0 = 0;

#(PERIOD)

  // set format = msb
  A1 = 1; A0 = 1;
  WR = 0;
  RD = 1;
  Di = 8'b00_10_000_0; // c0 lsb mode 0 bin

#(PERIOD)
  WR = 1;

#(PERIOD)

  // write msb counter 0
  // should be $0f1
  A1 = 0; A0 = 0;
  RD = 1;
  WR = 0;
  Di = 8'h0;

#(PERIOD)
  WR = 1;
  gate0 = 1;

#(PERIOD*50) /////////////////////// MODE 1

  A1 = 1; A0 = 1;
  RD = 1;
  WR = 0;
  Di = 8'b00_01_001_0; // c0 lsb mode 1 bin
  gate0 = 0;

#(PERIOD)
  WR = 1;

#(PERIOD)

  // write lsb counter 0
  WR = 0;
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'h1f;

#(PERIOD)
  WR = 1;

#(PERIOD)
  gate0 = 1;

#(PERIOD*50) /////////////////////// MODE 2

  A1 = 1; A0 = 1;
  RD = 1;
  WR = 0;
  Di = 8'b00_01_010_0; // c0 lsb mode 2 bin
  gate0 = 0;

#(PERIOD)
  WR = 1;

#(PERIOD)

  // write lsb counter 0
  WR = 0;
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'h1f;

#(PERIOD)
  WR = 1;
  gate0 = 1;

#(PERIOD*60)
  gate0 = 0;

#(PERIOD*10)
  gate0 = 1;

#(PERIOD*20)
  gate0 = 0;

#(PERIOD*50) /////////////////////// MODE 3

  A1 = 1; A0 = 1;
  RD = 1;
  WR = 0;
  Di = 8'b00_11_011_0; // c0 h/l mode 3 bin
  gate0 = 0;
  
#(PERIOD)
  WR = 1;

#(PERIOD)

  // write lsb counter 0
  WR = 0;
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'hf;

#(PERIOD)
  WR = 1;
  
#(PERIOD)

  // write msb counter 0
  WR = 0;
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'h0; // should be $0f*2=$1e, check

#(PERIOD)
  WR = 1;

#(PERIOD)
  gate0 = 1;

#(PERIOD*100) /////////////////////// MODE 4

  A1 = 1; A0 = 1;
  RD = 1;
  WR = 0;
  Di = 8'b00_11_100_0; // c0 h/l mode 4 bin
  gate0 = 0;

#(PERIOD)
  WR = 1;

#(PERIOD)

  // write lsb counter 0
  WR = 0;
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'hf;

#(PERIOD)
  WR = 1;
  
#(PERIOD)

  // write msb counter 0
  WR = 0;
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'h0;

#(PERIOD)
  WR = 1;

#(PERIOD)
  gate0 = 1;

#(PERIOD*100) /////////////////////// MODE 5

  A1 = 1; A0 = 1;
  RD = 1;
  WR = 0;
  Di = 8'b00_11_101_0; // c0 h/l mode 5 bin
  gate0 = 0;

#(PERIOD)
  WR = 1;

#(PERIOD)

  // write lsb counter 0
  WR = 0;
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'hf;

#(PERIOD)
  WR = 1;
  
#(PERIOD)

  // write msb counter 0
  WR = 0;
  RD = 1;
  A1 = 0; A0 = 0;
  Di = 8'h0;

#(PERIOD)
  WR = 1;

#(PERIOD*10)
  gate0 = 1;

#(PERIOD*8)
  gate0 = 0;

#(PERIOD*10)
  gate0 = 1;

#(PERIOD*200)
  $finish;

end

endmodule