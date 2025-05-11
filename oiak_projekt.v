module KSM_i_KMM4x4 
(
    input [31:0] a, b,
    output [63:0] KSM_WYNIK,


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


module karacuby_glowny_4x4;
    reg [31:0] a, b; 
    wire [63:0] KSM_WYNIK;
    reg [31:0] AA, AB, AC, AD, BA, BB, BC, BD, CA, CB, CC, CD, DA, DB, DC, DD;
    reg [31:0] EA, EB, EC, ED, FA, FB, FC, FD, GA, GB, GC, GD, HA, HB, HC, HD;
    wire [63:0] IA_w, IB_w, IC_w, ID_w, IE_w, IF_w, IG_w, IH_w, II_w, IJ_w, IK_w, IL_w, IM_w, IN_w, IO_w, IP_w; 
    integer i, ksm_czy_kmm;


    KSM_i_KMM4x4 kar 
    (
        .a(a), .b(b), .KSM_WYNIK(KSM_WYNIK),

        .AA(AA), .AB(AB), .AC(AC), .AD(AD),
        .BA(BA), .BB(BB), .BC(BC), .BD(BD),
        .CA(CA), .CB(CB), .CC(CC), .CD(CD),
        .DA(DA), .DB(DB), .DC(DC), .DD(DD),

        .EA(EA), .EB(EB), .EC(EC), .ED(ED), 
        .FA(FA), .FB(FB), .FC(FC), .FD(FD),
        .GA(GA), .GB(GB), .GC(GC), .GD(GD),
        .HA(HA), .HB(HB), .HC(HC), .HD(HD),

        .IA_w(IA_w), .IB_w(IB_w), .IC_w(IC_w), .ID_w(ID_w),
        .IE_w(IE_w), .IF_w(IF_w), .IG_w(IG_w), .IH_w(IH_w),
        .II_w(II_w), .IJ_w(IJ_w), .IK_w(IK_w), .IL_w(IL_w), 
        .IM_w(IM_w), .IN_w(IN_w), .IO_w(IO_w), .IP_w(IP_w) 
    );

    initial 
    begin
        ksm_czy_kmm = 1; // WYBÓR ALGORYTMU: 1 - KSM; 2 - KMM na macierzach 4x4
        
    
        if(ksm_czy_kmm == 1) // KSM
        begin
        $display("\n TEST ALGORYTMU KSM");
        for (i = 1; i <= 5000; i = i + 1) 
        begin
            a = i;
            b = i + 10;  
            #1;            
            $display("\n");
            $display("NR. TESTU: %d", i); 
            $display("OPERAND 1: %d  OPERAND 2: %d  WYNIK: %d", a, b, KSM_WYNIK);
        end
        end


        else if(ksm_czy_kmm == 2) // KMM 4x4
        begin
            $display("\n TEST ALGORYTMU KMM NA MACIERZACH 4x4");
            AA = 32'd10;
            AB = 32'd11;
            AC = 32'd12;
            AD = 32'd13;
    
            BA = 32'd14;
            BB = 32'd15;
            BC = 32'd16;
            BD = 32'd17;
    
            CA = 32'd18;
            CB = 32'd19;
            CC = 32'd20;
            CD = 32'd21;
    
            DA = 32'd22;
            DB = 32'd23;
            DC = 32'd24;
            DD = 32'd25;



            EA = 32'd26;
            EB = 32'd27;
            EC = 32'd28;
            ED = 32'd29;
    
            FA = 32'd30;
            FB = 32'd31;
            FC = 32'd32;
            FD = 32'd33;
    
            GA = 32'd34;
            GB = 32'd35;
            GC = 32'd36;
            GD = 32'd37;
    
            HA = 32'd38;
            HB = 32'd39;
            HC = 32'd40;
            HD = 32'd41;
            #1;

            $display("MACIERZ A:");
            $display("%d %d %d %d", AA, AB, AC, AD);
            $display("%d %d %d %d", BA, BB, BC, BD);
            $display("%d %d %d %d", CA, CB, CC, CD);
            $display("%d %d %d %d", DA, DB, DC, DD);
            $display("\n");
                
            $display("MACIERZ B:");
            $display("%d %d %d %d", EA, EB, EC, ED);
            $display("%d %d %d %d", FA, FB, FC, FD);
            $display("%d %d %d %d", GA, GB, GC, GD);
            $display("%d %d %d %d", HA, HB, HC, HD);
            $display("\n");
                
            $display("MACIERZ WYNIKOWA:");
            $display("%d %d %d %d", IA_w, IB_w, IC_w, ID_w);
            $display("%d %d %d %d", IE_w, IF_w, IG_w, IH_w);
            $display("%d %d %d %d", II_w, IJ_w, IK_w, IL_w);
            $display("%d %d %d %d", IM_w, IN_w, IO_w, IP_w);
            $display("\n");
            
            end
        
        $finish;
    end

endmodule




