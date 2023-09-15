module board_specific_top
# (
    parameter clk_mhz = 50,
              w_key   = 4,
              w_sw    = 4,
              w_led   = 8,
              w_digit = 8,
              w_gpio  = 16
)
(
    input                  CLK,

    input  [w_key   - 1:0] KEY,
    input  [w_sw    - 1:0] SW,
    output [w_led   - 1:0] LED,

    output [          7:0] ABCDEFGH,
    output [w_digit - 1:0] DIGIT,

    output                 VGA_HSYNC,
    output                 VGA_VSYNC,
    output [          2:0] VGA_RGB,

    input                  UART_RXD,

    inout  [w_gpio  - 1:0] GPIO
);

    //------------------------------------------------------------------------

    wire clk = CLK;

    localparam w_top_key = w_key - 1;  // One key is used as a reset

    wire                  rst     = ~ KEY [w_key     - 1];
    wire [w_top_key - 1:0] top_key = ~ KEY [w_top_key - 1:0];


    //------------------------------------------------------------------------

    wire [w_led   - 1:0] led;

    wire [          7:0] abcdefgh;
    wire [w_digit - 1:0] digit;

    wire [          3:0] red, green, blue;
    wire [         23:0] mic;

    //------------------------------------------------------------------------

    top
    # (
        .clk_mhz ( clk_mhz   ),
        .w_key   ( w_top_key ),
        .w_sw    ( w_sw      ),
        .w_led   ( w_led     ),
        .w_digit ( w_digit   ),
        .w_gpio  ( w_gpio    )
    )
    i_top
    (
        .clk      ( clk       ),
        .rst      ( rst       ),

        .key      ( top_key   ),
        .sw       ( SW        ),

        .led      ( led       ),

        .abcdefgh ( abcdefgh  ),
        .digit    ( digit     ),

        .vsync    ( VGA_VSYNC ),
        .hsync    ( VGA_HSYNC ),

        .red      ( red       ),
        .green    ( green     ),
        .blue     ( blue      ),

        .mic      ( mic       ),

        .gpio     ( GPIO      )

    );

    //------------------------------------------------------------------------

    assign LED      = ~ led;

    assign ABCDEFGH = ~ abcdefgh;
    assign DIGIT    = ~ digit;

    assign VGA_RGB = { | red, | green, | blue};

    /*
    inmp441_mic_i2s_receiver i_microphone
    (
        .clk   ( clk       ),
        .rst   ( rst       ),
        .lr    ( LCD_D [1] ),
        .ws    ( LCD_D [2] ),
        .sck   ( LCD_D [3] ),
        .sd    ( LCD_D [6] ),
        .value ( mic       )
    );

    assign LCD_D [4] = 1'b0;  // GND
    assign LCD_D [5] = 1'b1;  // VCC
    */

endmodule
