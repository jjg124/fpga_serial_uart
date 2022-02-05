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
use work.tb_utilities_pkg.all;
 
entity uart_tx_basic_tb is
end uart_tx_basic_tb;
 
architecture behave of uart_tx_basic_tb is
 
  component UART_TX_BASIC is
    generic (
      g_CLKS_PER_BIT : integer := 2604;   -- Needs to be set correctly
	  g_CLKS_BCTR    : integer := 26042
      );
    port (
      i_clk       : in  std_logic;
      i_tx_dv     : in  std_logic;
      i_tx_byte   : in  std_logic_vector(7 downto 0);
      o_tx_active : out std_logic;
      o_tx_serial : out std_logic;
      o_tx_done   : out std_logic;
	  bctr_out    : out std_logic_vector(7 downto 0);
	  tx_urdy     : out std_logic_vector(7 downto 0)
      );
  end component UART_TX_BASIC;
    
  -- Test Bench uses a 10 MHz Clock
  -- Want to interface to 115200 baud UART
  -- 10000000 / 115200 = 87 Clocks Per Bit.
  constant c_CLKS_PER_BIT : integer := 2604;
 
  --constant c_BIT_PERIOD : time := 8680 ns;
   
  signal r_CLOCK     : std_logic                    := '0';
  signal r_TX_DV     : std_logic                    := '0';
  signal r_TX_BYTE   : std_logic_vector(7 downto 0) := (others => '0');
  signal w_TX_SERIAL : std_logic;
  signal w_TX_DONE   : std_logic;
  signal r_RX_SERIAL : std_logic := '1';
  signal bcntr       : std_logic_vector(7 downto 0);
  signal tx_urdy     : std_logic_vector(7 downto 0);
 
   
begin
 
  -- Instantiate UART transmitter
  UART_TX_INST : UART_TX_BASIC
    generic map (
      g_CLKS_PER_BIT => c_CLKS_PER_BIT,
	  g_CLKS_BCTR    => 26042
      )
    port map (
      i_clk       => r_CLOCK,
      i_tx_dv     => r_TX_DV,
      i_tx_byte   => r_TX_BYTE,
      o_tx_active => open,
      o_tx_serial => w_TX_SERIAL,
      o_tx_done   => w_TX_DONE,
	  bctr_out    => bcntr,
	  tx_urdy     => tx_urdy
      );
 
  r_CLOCK <= not r_CLOCK after 1.67 ns;
   
  process is
  begin
 
    -- Tell the UART to send a command.
    wait until rising_edge(r_CLOCK);
    wait until rising_edge(r_CLOCK);
    r_TX_DV   <= '1';
    r_TX_BYTE <= X"AB";
    wait until rising_edge(r_CLOCK);
    r_TX_DV   <= '0';
    wait until w_TX_DONE = '1';
	wait for 500 ms;
    stop(2);
     
  end process;
   
end behave;