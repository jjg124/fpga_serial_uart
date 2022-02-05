library ieee;
library std;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use std.env.all;
use work.tb_utilities_pkg.all;
 
entity uart_rx_basic_tb is
end uart_rx_basic_tb;
 
architecture behave of uart_rx_basic_tb is
	
  type t_Memory is array (0 to 1024) of std_logic_vector(7 downto 0);
  signal r_Mem          : t_Memory := (others => (others => '0'));
  signal r_Mem_uut_data : t_Memory := (others => (others => '0'));
   
  -- Test Bench uses a 10 MHz Clock
  -- Want to interface to 115200 baud UART
  -- 10000000 / 115200 = 87 Clocks Per Bit.
  constant c_CLKS_PER_BIT    : integer := 87;
  constant write_byte        : std_logic_vector(7 downto 0) := x"3F";
  constant write_byte_go     : std_logic := '1';
  constant count_pattern_go  : std_logic := '1';
  constant walking_ones_go   : std_logic := '1';
  constant walking_zeros_go  : std_logic := '1';
   
  signal r_CLOCK       : std_logic                    := '0';
  signal w_RX_DV       : std_logic;
  signal w_RX_BYTE     : std_logic_vector(7 downto 0);
  signal r_RX_SERIAL   : std_logic := '1';
  signal r_data        : std_logic_vector(7 downto 0);
  signal uut_count     : integer := 0;
  signal test_done     : std_logic := '0';
  signal done          : std_logic := '0';
   
begin
 
  -- Instantiate UART Receiver
  UART_RX_INST : entity work.UART_RX_BASIC
    generic map (
      g_CLKS_PER_BIT => c_CLKS_PER_BIT
      )
    port map (
      i_Clk       => r_CLOCK,
      i_RX_Serial => r_RX_SERIAL,
      o_RX_DV     => w_RX_DV,
      o_RX_Byte   => w_RX_BYTE
      );
 
  r_CLOCK <= not r_CLOCK after 50 ns;
   
 uut_stimulus : process is
    file test_vector_gold  : text open read_mode is "uut_output_golden.txt";
  	variable v_line        : line;
  	variable v_write_row   : line;
  	variable bin_term      : std_logic_vector(7 downto 0);
  	variable i             : integer := 0;
  	variable gold_count    : integer := 0;
  begin
 
    -- Send a command to the UART
      UART_WRITE_BYTE(write_byte_go,write_byte,r_RX_SERIAL);
      UART_COUNTING_PATTERN(count_pattern_go,4,r_RX_SERIAL);
      UART_WALKING_ONE(walking_ones_go,4,r_RX_SERIAL);
      UART_WALKING_ZERO(walking_zeros_go,4,r_RX_SERIAL,done);
      
      test_done <= '1';
      
    wait until done = '1';
      while not endfile(test_vector_gold) loop
        readline (test_vector_gold,v_line);
        read(v_line,bin_term);
        r_Mem(i) <= bin_term;
        wait for 5 ns;
  	    write(v_write_row,string'("Input Data: "));
  	    write(v_write_row, bin_term);
  	    
  	    write(v_write_row,string'("  Output Data: "));
  	    write(v_write_row, r_Mem(i));
  	    writeline(OUTPUT,v_write_row);
  	    i := i + 1;
  	    gold_count := gold_count + 1;
  	  end loop;
  	wait for 5 ns;
  	
  	 if r_Mem_uut_data /= r_Mem then
  		report "Test Failed : Data Mismatch" severity failure;
  		stop(2);
  	 else
  		report "Test : UART BYTE Write       : OK" severity note;
  		report "Test : UART Counting Pattern : OK" severity note;
  		report "Test : UART Walking Ones     : OK" severity note;
  		report "Test : UART Walking Zeros    : OK" severity note;
  		stop(2);
  	 end if;
   
    stop(2);
     
  end process;

  uut_output_data : process(r_CLOCK,w_RX_DV)
  	file test_vector       : text open write_mode is "uut_output.txt";
  	variable row           : line;
  	variable i             : integer := 0;
  begin
  	if rising_edge(r_CLOCK) then
  	  if (w_RX_DV = '1') then
  		write(row, w_RX_BYTE, left, 8);
  		writeline(test_vector,row);
  		r_Mem_uut_data(i) <= w_RX_BYTE;
  		i := i + 1;
  		uut_count <= uut_count + 1;
  	  end if;
  	
    end if;
 
 end process;

 monitor : process(r_Mem_uut_data,r_Mem,done)
 begin
  	if done = '1' then
      --if r_Mem_uut_data /= r_Mem then
  		--report "Test Failed : Data Mismatch" severity failure;
  		--stop(2);
  	  --else
  		--report "Test : UART BYTE Write       : OK" severity note;
  		--report "Test : UART Counting Pattern : OK" severity note;
  		--report "Test : UART Walking Ones     : OK" severity note;
  		--report "Test : UART Walking Zeros    : OK" severity note;
  		--stop(2);
  	  --end if;
  	end if;
 end process;  
end behave;