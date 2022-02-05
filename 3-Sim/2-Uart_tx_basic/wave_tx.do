onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB_signals /uart_tx_basic_tb/r_CLOCK
add wave -noupdate -expand -group TB_signals /uart_tx_basic_tb/r_TX_DV
add wave -noupdate -expand -group TB_signals /uart_tx_basic_tb/r_TX_BYTE
add wave -noupdate -expand -group TB_signals /uart_tx_basic_tb/w_TX_SERIAL
add wave -noupdate -expand -group TB_signals /uart_tx_basic_tb/w_TX_DONE
add wave -noupdate -expand -group TB_signals /uart_tx_basic_tb/r_RX_SERIAL
add wave -noupdate -expand -group TB_signals /uart_tx_basic_tb/bcntr
add wave -noupdate -expand -group TB_signals /uart_tx_basic_tb/tx_urdy
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/i_Clk
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/i_TX_DV
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/i_TX_Byte
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/o_TX_Active
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/o_TX_Serial
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/o_TX_Done
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/bctr_out
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/tx_urdy
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/r_SM_Main
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/r_Clk_Count
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/free_run
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/r_Bit_Index
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/bctr
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/u_rdy_cnt
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/r_TX_Data
add wave -noupdate -expand -group UART_TX /uart_tx_basic_tb/UART_TX_INST/r_TX_Done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {925 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
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
WaveRestoreZoom {0 ns} {963 ns}
