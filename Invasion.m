function [OB_M_phase, OB_M_power, OB_B_phase, OB_B_power] = ...
    Invasion(PowerFinal, PhaseFinal, Positions, d_BS, lambda_t, lambda_r, Gt)
% The invading object is regarded to have identical area as BS and is
% parallel with BS

[BS_T_power, MT_R_power, MT_T_power, BS_R_power] = Parse_compact_return(PowerFinal);
[BS_T_phase, MT_R_phase, MT_T_phase, BS_R_phase] = Parse_compact_return(PhaseFinal);
[BS_T_pos, MT_R_pos, MT_T_pos, BS_R_pos] = Parse_compact_return(Positions);
OB_pos = BS_T_pos;
OB_pos(3,:) = d_BS;

[OB_M_phase, OB_M_power, ~] = power_transfer_from_array_to_array_v2...
            (MT_T_phase, MT_T_power, MT_T_pos, BS_R_pos, lambda_r, Gt);
[OB_B_phase, OB_B_power, ~] = power_transfer_from_array_to_array_v2...
            (BS_T_phase, BS_T_power, BS_T_pos, MT_R_pos, lambda_t, Gt);

