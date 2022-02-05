----------------------------------------------------------------------
-- File Downloaded from http://www.nandland.com
----------------------------------------------------------------------
library ieee;
library std;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use std.env.all;
--use work.tb_utilities_pkg.all;
 
entity ssm_tb is
end ssm_tb;
 
architecture behave of ssm_tb is
 
  component SSM is
    port (
      i_Clk       : in  std_logic;
      i_ready     : in  std_logic;
	  i_busy      : in  std_logic;
	  crnt_id     : out std_logic_vector(2 downto 0)
      );
  end component SSM;
    
   
  signal r_CLOCK     : std_logic                    := '0';
  signal r_ready     : std_logic                    := '0';
  signal r_busy      : std_logic                    := '0';
  signal r_count_id  : std_logic_vector(2 downto 0) := (others => '0');
   
begin
 
  -- Instantiate UART transmitter
  SSM_INST : SSM
    port map (
      i_clk       => r_CLOCK,
      i_ready     => r_ready,
      i_busy      => r_busy,
      crnt_id     => r_count_id
      );
 
  r_CLOCK <= not r_CLOCK after 3.3 ns;
   
  process is
  begin
 
    wait until rising_edge(r_CLOCK);
    wait until rising_edge(r_CLOCK);
    r_ready   <= '0';
    r_busy    <= '0';
    wait until rising_edge(r_CLOCK);
    r_ready   <= '1';
    
	wait for 500 ns;
    stop(2);
     
  end process;
   
end behave;