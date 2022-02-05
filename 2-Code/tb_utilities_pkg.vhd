library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;

package tb_utilities_pkg is

  constant c_BIT_PERIOD : time := 8680 ns; 
  
  procedure UART_WRITE_BYTE (
  	i_go_bit          : in  std_logic;
    i_data_in         : in  std_logic_vector(7 downto 0);
    signal o_serial   : out std_logic);
    
  procedure UART_COUNTING_PATTERN(
  	i_go_bit          : in  std_logic;
  	i_byte_num        : in  positive;
  	signal o_serial   : out std_logic);
  	
  procedure UART_WALKING_ONE(
  	i_go_bit          : in  std_logic;
  	i_byte_num        : in  positive;
  	signal o_serial   : out std_logic);
  	
  procedure UART_WALKING_ZERO(
  	i_go_bit           : in  std_logic;
  	i_byte_num         : in  positive;
  	signal o_serial    : out std_logic;
  	signal done        : out std_logic);
 
end package tb_utilities_pkg;

package body tb_utilities_pkg is

procedure UART_WRITE_BYTE (
	i_go_bit        : in  std_logic;
    i_data_in       : in  std_logic_vector(7 downto 0);
    signal o_serial : out std_logic) is
    
    file test_vector     : text open append_mode is "uut_output_golden.txt";
  	variable row         : line;
  	
  begin
    if (i_go_bit = '1') then
      -- Send Start Bit
      o_serial <= '0';
      wait for c_BIT_PERIOD;
 
      -- Send Data Byte
      for ii in 0 to 7 loop
        o_serial <= i_data_in(ii);
        wait for c_BIT_PERIOD;
      end loop;  -- ii
 
      -- Send Stop Bit
      o_serial <= '1';
      wait for c_BIT_PERIOD;
    
      write(row, i_data_in, left, 8);
  	  writeline(test_vector,row);
  	  file_close(test_vector);
    end if;
  end UART_WRITE_BYTE;

  procedure UART_COUNTING_PATTERN(
  	i_go_bit          : in  std_logic;
  	i_byte_num        : in  positive;
  	signal o_serial   : out std_logic) is
  	variable count_pattern : std_logic_vector(7 downto 0) := (others => '0');
  	file test_vector     : text open append_mode is "uut_output_golden.txt";
  	variable row         : line;
  begin
    if (i_go_bit = '1') then
  	  for jj in 0 to i_byte_num loop
  	    -- Send start bit
  	    o_serial <= '0';
  	    wait for c_BIT_PERIOD;
  	    -- Send Data Byte
  	    for ii in 0 to 7 loop
          o_serial <= count_pattern(ii);
          wait for c_BIT_PERIOD;
        end loop;
        write(row, count_pattern, left, 8);
  	    writeline(test_vector,row);
        count_pattern := count_pattern + 1;
        -- Send Stop Bit
        o_serial <= '1';
        wait for c_BIT_PERIOD;
      end loop;
      file_close(test_vector);
    else
  	  o_serial <= '1';
      wait for c_BIT_PERIOD;
      count_pattern := (others => '0');
    end if;
  end UART_COUNTING_PATTERN;

  procedure UART_WALKING_ONE(
  	i_go_bit          : in  std_logic;
  	i_byte_num        : in  positive;
  	signal o_serial   : out std_logic) is
  	variable walk_one : unsigned(7 downto 0) := x"01";
  	file test_vector     : text open append_mode is "uut_output_golden.txt";
  	variable row         : line;
  begin
    if (i_go_bit = '1') then
  	  for jj in 0 to i_byte_num loop
  	    -- Send start bit
  	    o_serial <= '0';
  	    wait for c_BIT_PERIOD;
  	    -- Send Data Byte
  	    for ii in 0 to 7 loop
          o_serial <= walk_one(ii);
          wait for c_BIT_PERIOD;
        end loop;
        write(row, std_logic_vector(walk_one), left, 8);
  	    writeline(test_vector,row);
        walk_one := walk_one rol 1;
        -- Send Stop Bit
        o_serial <= '1';
        wait for c_BIT_PERIOD;
      end loop;
      file_close(test_vector);
    else
  	  o_serial <= '1';
      wait for c_BIT_PERIOD;
      walk_one := x"01";
    end if;
  end UART_WALKING_ONE;

    procedure UART_WALKING_ZERO(
  	i_go_bit           : in  std_logic;
  	i_byte_num         : in  positive;
  	signal o_serial    : out std_logic;
  	signal done        : out std_logic) is
  	variable walk_zero : unsigned(7 downto 0) := x"FE";
  	file test_vector     : text open append_mode is "uut_output_golden.txt";
  	variable row         : line;
  begin
    if (i_go_bit = '1') then
  	  for jj in 0 to i_byte_num loop
  	    -- Send start bit
  	    o_serial <= '0';
  	    wait for c_BIT_PERIOD;
  	    -- Send Data Byte
  	    for ii in 0 to 7 loop
          o_serial <= walk_zero(ii);
          wait for c_BIT_PERIOD;
        end loop;
        write(row, std_logic_vector(walk_zero), left, 8);
  	    writeline(test_vector,row);
        walk_zero := walk_zero rol 1;
        -- Send Stop Bit
        o_serial <= '1';
        wait for c_BIT_PERIOD;
      end loop;
      done <= '1';
      file_close(test_vector);
    else
  	  o_serial <= '1';
      wait for c_BIT_PERIOD;
      walk_zero := x"FE";
    end if;
  end UART_WALKING_ZERO; 

end package body tb_utilities_pkg;

