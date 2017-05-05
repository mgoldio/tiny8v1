import tiny8_types::*;

module control
(
    input clk,
    input tiny8_opcode opcode,

    output logic load_pc,
    output logic load_acc,
    output logic load_regfile,
    output logic load_ir,

    output logic pcmux_sel,
    output logic alumux1_sel,
    output logic alumux2_sel,
    output logic [1:0] addrmux_sel,

    /* mem signals */
    input mem_resp
);

typedef enum int unsigned {
    ST_FETCH1,
    ST_FETCH2,
    ST_DECODE,
    ST_EXECUTE,
    ST_MEMORY
} control_state;

control_state state, next_state;

always_ff @(posedge clk)
begin
    state <= next_state;
end

always_comb
begin : state_actions

end

always_comb
begin : next_state_logic
    case (state)
        ST_FETCH1 : begin
        end
        ST_FETCH2 : begin
        end
        ST_DECODE : begin
        end
        ST_EXECUTE : begin
        end
        ST_MEMORY : begin
        end
end

endmodule
