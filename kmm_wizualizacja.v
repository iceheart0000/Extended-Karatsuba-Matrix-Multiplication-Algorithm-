module KMM4x4 
(
    input [31:0] AA, AB, AC, AD, 
                 BA, BB, BC, BD, 
                 CA, CB, CC, CD,
                 DA, DB, DC, DD,

    input [31:0] EA, EB, EC, ED,
                 FA, FB, FC, FD,
                 GA, GB, GC, GD, 
                 HA, HB, HC, HD,
    
    output [63:0] IA_w, IB_w, IC_w, ID_w, 
                  IE_w, IF_w, IG_w, IH_w, 
                  II_w, IJ_w, IK_w, IL_w, 
                  IM_w, IN_w, IO_w, IP_w
);

    parameter n = 2; 
    
    function [63:0] KMM;
        input [31:0] A, B;
        reg [15:0] A1, A0, B1, B0;
        reg [16:0] AS, BS; 
        reg [63:0] C0, C1, CS; 

        
        begin
            if (n > 1) 
            begin
                A1 = A[31:16];
                A0 = A[15:0];
                B1 = B[31:16];
                B0 = B[15:0];
                
                AS = A1 + A0;
                BS = B1 + B0;
                

                C1 = A1 * B1;
                CS = AS * BS;
                C0 = A0 * B0;


                KMM = (C1 << 32) 
                + ((CS - C1 - C0) << 16) 
                + C0;
            end

            else 
            begin
                KMM = A * B;
            end

        end

    
    endfunction

    assign IA_w = KMM(AA, EA) + KMM(AB, FA) + KMM(AC, GA) + KMM(AD, HA);
    assign IB_w = KMM(AA, EB) + KMM(AB, FB) + KMM(AC, GB) + KMM(AD, HB);
    assign IC_w = KMM(AA, EC) + KMM(AB, FC) + KMM(AC, GC) + KMM(AD, HC);
    assign ID_w = KMM(AA, ED) + KMM(AB, FD) + KMM(AC, GD) + KMM(AD, HD);

    assign IE_w = KMM(BA, EA) + KMM(BB, FA) + KMM(BC, GA) + KMM(BD, HA);
    assign IF_w = KMM(BA, EB) + KMM(BB, FB) + KMM(BC, GB) + KMM(BD, HB);
    assign IG_w = KMM(BA, EC) + KMM(BB, FC) + KMM(BC, GC) + KMM(BD, HC);
    assign IH_w = KMM(BA, ED) + KMM(BB, FD) + KMM(BC, GD) + KMM(BD, HD);

    assign II_w = KMM(CA, EA) + KMM(CB, FA) + KMM(CC, GA) + KMM(CD, HA);
    assign IJ_w = KMM(CA, EB) + KMM(CB, FB) + KMM(CC, GB) + KMM(CD, HB);
    assign IK_w = KMM(CA, EC) + KMM(CB, FC) + KMM(CC, GC) + KMM(CD, HC);
    assign IL_w = KMM(CA, ED) + KMM(CB, FD) + KMM(CC, GD) + KMM(CD, HD);

    assign IM_w = KMM(DA, EA) + KMM(DB, FA) + KMM(DC, GA) + KMM(DD, HA);
    assign IN_w = KMM(DA, EB) + KMM(DB, FB) + KMM(DC, GB) + KMM(DD, HB);
    assign IO_w = KMM(DA, EC) + KMM(DB, FC) + KMM(DC, GC) + KMM(DD, HC);
    assign IP_w = KMM(DA, ED) + KMM(DB, FD) + KMM(DC, GD) + KMM(DD, HD);

endmodule

 /*
    KOMENDY:
    yosys -p "read_verilog kmm_wizualizacja.v; proc; opt; write_json kmm_wizualizacja.json"
    netlistsvg kmm_wizualizacja.json -o kmm_wizualizacja.svg
    open kmm_wizualizacja.svg
    */