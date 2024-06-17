`include "config.svh"
/*
 Hardware required
   2 keys, 4 leds, 3 3.3V GPIO(if tm1638 module is used)

 If led is not available on your board, reuse led[0] or
 connect tm1639 board (7 Segment Display Keypad & LED Module) and uncommenting the line

  `define ENABLE_TM1638 in ../common/lab_specific_config.svh file

 tm1638_board
 clk  - GPIO[1]
 stb  - GPIO[2]
 data - GPIO[0]
 VCC  - 3V3
 GNG  - GND
*/

module top
# (
    parameter clk_mhz   = 50,
              pixel_mhz = 25,
              w_key     = 4,
              w_sw      = 8,
              w_led     = 8,
              w_digit   = 8,
              w_gpio    = 3,  //for tm1638 module
              w_red     = 4,
              w_green   = 4,
              w_blue    = 4
)
(
    input                        clk,
    input                        slow_clk,
    input                        rst,

    // Keys, switches, LEDs

    input        [w_key   - 1:0] key,
    input        [w_sw    - 1:0] sw,
    output logic [w_led   - 1:0] led,

    // A dynamic seven-segment display

    output logic [          7:0] abcdefgh,
    output logic [w_digit - 1:0] digit,

    // VGA

    output logic                 vsync,
    output logic                 hsync,
    output logic [w_red   - 1:0] red,
    output logic [w_green - 1:0] green,
    output logic [w_blue  - 1:0] blue,
    output                       display_on,
    output                       pixel_clk,

    input                        uart_rx,
    output                       uart_tx,

    input        [         23:0] mic,
    output       [         15:0] sound,

    // General-purpose Input/Output

    inout        [w_gpio  - 1:0] gpio
);

    //------------------------------------------------------------------------

    // assign led        = '0;
       assign abcdefgh   = '0;
       assign digit      = '0;
       assign vsync      = '0;
       assign hsync      = '0;
       assign red        = '0;
       assign green      = '0;
       assign blue       = '0;
       assign display_on = '0;
       assign pixel_clk  = '0;
       assign sound      = '0;
       assign uart_tx    = '1;

    //------------------------------------------------------------------------

    wire a = key [0];
    wire b = key [1];

    wire result = a ^ b;

    assign led [0] = result;

    assign led [1] = key [0] ^ key [1];
    //assign led [2] = a ^ b;

    //------------------------------------------------------------------------

    /*
    `ifndef VERILATOR

    generate
        if (w_led > 2)
        begin : unused_led
            assign led [w_led - 1:2] = '0;
        end
    endgenerate

    `endif
    */

    //------------------------------------------------------------------------

    // Exercise 1: Change the code below.
    // Assign to led [2] the result of AND operation.
    //
    // If led [2] is not available on your board,
    // comment out the code above and reuse led [0].

    // assign led [2] =

    // Exercise 2: Change the code below.
    // Assign to led [3] the result of XOR operation
    // without using "^" operation.
    // Use only operations "&", "|", "~" and parenthesis, "(" and ")".

    // assign led [3] =

    // Exercise 3: Create an illustration to De Morgan's laws:
    //
    // ~ (a & b) == ~ a | ~ b
    // ~ (a | b) == ~ a & ~ b

endmodule
