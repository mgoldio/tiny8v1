import tiny8_types::*;

module control
(
    input clk,
    input tiny8_opcode opcode,
    input branch_enable,

    output logic load_pc,
    output logic load_acc,
    output logic load_rs,
    output logic load_rd,
    output logic load_ir,
    output logic load_mar,
    output logic load_mdr,

    output logic pcmux_sel,
    output logic [1:0] alumux1_sel,
    output logic alumux2_sel,
    output logic [1:0] addrmux_sel,
    output logic marmux_sel,
    output logic mdrmux_sel,

    output tiny8_aluop aluop,

    /* mem signals */
    input mem_resp,
    output mem_read,
    output mem_write
);

typedef enum int unsigned {
    ST_FETCH1,
    ST_FETCH2,
    ST_FETCH3,
    ST_DECODE,
    ST_ADS,
    ST_BPD,
    ST_LDP_1,
    ST_LDP_2,
    ST_LDP_3,
    ST_STP_1,
    ST_STP_2,
    ST_STP_3
} control_state;

control_state state, next_state;

always_ff @(posedge clk)
begin
    state <= next_state;
end

always_comb
begin : state_actions
    load_pc = 0;
    load_acc = 0;
    load_rs = 0;
    load_rd = 0;
    load_ir = 0;
    load_mdr = 0;
    load_mar = 0;
    pcmux_sel = 0;
    alumux1_sel = 0;
    alumux2_sel = 0;
    addrmux_sel = 0;

    case(state)

        ST_FETCH1 : begin
            /* MAR <= PC */
            marmux_sel = 2;
            load_mar = 1;
            /* PC <= PC + 2 */
            pcmux_sel = 0;
            load_pc = 1;
        end

        ST_FETCH2 : begin
            /* Read memory */
            mem_read = 1;
            mdrmux_sel = 1;
            load_mdr = 1;
        end

        ST_FETCH3 : begin
            /* Load IR */
            load_ir = 1;
        end

        ST_DECODE : begin
            // do nothing
        end

        ST_ADS : begin
            load_acc = 1;
            alu_op = alu_mul;
            alumux2_sel = 1;
        end

        ST_BPD : begin
            load_pc = 1;
            pcmux_sel = 1;
            aluop = alu_dec;
            load_rs = 1;
        end

        ST_LDP_1 : begin
            load_mar = 1;
        end

        ST_LDP_2 : begin
            mdrmux_sel = 1;
            load_mdr = 1;
            mem_read = 1;
        end

        ST_LDP_3 : begin
            regfilemux_sel = 1;
            load_rs = 1;
            load_rd = 1;
            alu_op = alu_sub;
            alumux1_sel = 1;
        end

        ST_STP_1 : begin
            load_mar = 1;
        end

        ST_STP_2 : begin
            load_mdr = 1;
            load_rs = 1;
            alu_op = alu_sub;
            alumux1_sel = 1;
        end

        ST_STP_3 : begin
            mem_write = 1;
        end

    endcase // state
end

always_comb
begin : next_state_logic
    next_state = ST_FETCH1;
    case (state)

        ST_FETCH1 : begin
            next_state = ST_FETCH2;
        end

        ST_FETCH2 : begin
            if(mem_resp==0)
                next_state = ST_FETCH2;
            else
                next_state = ST_FETCH3;
        end

        ST_FETCH3 : begin
            next_state = ST_DECODE;
        end

        ST_DECODE : begin
            case(opcode)
                op_ads:
                    next_state = ST_ADS;
                op_bpd: begin
                    if(branch_enable)
                        next_state = ST_BPD;
                end
                op_ldp:
                    next_state = ST_LDP_1;
                op_stp:
                    next_state = ST_STP_1;
            endcase
        end

        ST_LDP_1:
            next_state = ST_LDP_2;

        ST_LDP_2: begin
            if(mem_resp==0)
                next_state = ST_LDP_2;
            else
                next_state = ST_LDP_3;
        end

        ST_STP_1:
            next_state = ST_STP_2;

        ST_STP_2:
            next_state = ST_STP_3;

        ST_STP_3: begin
            if(mem_resp==0)
                next_state = ST_STP_3;
        end

    endcase
end

endmodule
