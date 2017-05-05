import tiny8_types::*;

module control
(
    input clk,
    input tiny8_opcode opcode,

    /* mem signals */
    input mem_resp
);

typedef enum int unsigned {
    ST_FETCH,
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
        ST_FETCH : begin
        end
        ST_DECODE : begin
        end
        ST_EXECUTE : begin
        end
        ST_MEMORY : begin
        end
end

endmodule