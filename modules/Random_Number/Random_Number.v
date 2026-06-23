module Random_Number (
    output [6:0] sevenseg_ten, sevenseg_one,
    input clock, reset, enable, generate_on, timer_exceed, display
);
 
    wire [5:0] index, random_number;       // Index and delivered random number
    wire [3:0] tens_index, ones_index;    // Tens and ones digits
    wire count, stop, shift;              // Signals from Index_Controller
 
    // Instance: Index_Controller
    Index_Controller controller (
        .count(count),
        .stop(stop),
        .shift(shift),
        .clock(clock),
        .reset(reset),
        .enable(enable),
        .generate_on(generate_on),
        .timer_exceed(timer_exceed)
    );
 
    // Instance: Index_Generator
    Index_Generator generator (
        .index(index),
        .clock(clock),
        .reset(reset),
        .enable(count),
        .stop(stop)
    );
 
    // Instance: Index_Deliver
    Index_Deliver deliver (
        .random_number(random_number),
        .shift(shift),
        .clock(clock),
        .reset(reset),
        .index(index)
    );
 
    // Instance: HexToBin
    HexToBin hextobin (
        .Index(random_number),
        .Tens_Index(tens_index),
        .Ones_Index(ones_index)
    );
 
    // Instance: Seven_Segment_Decoder
    Seven_Segment_Decoder decoder (
        .ten(tens_index),
        .one(ones_index),
        .display(display),
        .sevenseg_ten(sevenseg_ten),
        .sevenseg_one(sevenseg_one)
    );
 
endmodule