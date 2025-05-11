module KSM
(
    input [31:0] a, b,
    output [63:0] KSM_WYNIK    
);

    parameter n = 2; 
    
    function [63:0] KSM;
        input [31:0] a, b;
        reg [15:0] a1, a0, b1, b0;
        reg [16:0] as, bs; 
        reg [63:0] c1, cs, c0;
        
        begin
            if (n > 1) 
            begin

            a1 = a[31:16];
            a0 = a[15:0];
            b1 = b[31:16];
            b0 = b[15:0];


            as = a1 + a0;
            bs = b1 + b0;


            c1 = a1 * b1;
            cs = as * bs;
            c0 = a0 * b0;


            KSM = (c1 << 32) +
            ((cs - c1 - c0) << 16) 
            + c0;

        end

        else 
        begin
            KSM = a * b;
        end

        end
    endfunction

    assign KSM_WYNIK = KSM(a, b);

endmodule 
/*
    KOMENDY:
    yosys -p "read_verilog ksm_wizualizacja.v; proc; opt; write_json ksm_wizualizacja.json"
    netlistsvg ksm_wizualizacja.json -o ksm_wizualizacja.svg
    open ksm_wizualizacja.svg
    */