onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB_Signals /ssm_tb/r_CLOCK
add wave -noupdate -expand -group TB_Signals /ssm_tb/r_ready
add wave -noupdate -expand -group TB_Signals /ssm_tb/r_busy
add wave -noupdate -expand -group TB_Signals /ssm_tb/r_count_id
add wave -noupdate -expand -group SSM_Module /ssm_tb/SSM_INST/i_Clk
add wave -noupdate -expand -group SSM_Module /ssm_tb/SSM_INST/i_ready
add wave -noupdate -expand -group SSM_Module /ssm_tb/SSM_INST/i_busy
add wave -noupdate -expand -group SSM_Module /ssm_tb/SSM_INST/crnt_id
add wave -noupdate -expand -group SSM_Module /ssm_tb/SSM_INST/next_id
add wave -noupdate -expand -group SSM_Module /ssm_tb/SSM_INST/id_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {159 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
