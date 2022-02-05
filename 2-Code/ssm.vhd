 library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
 
entity SSM is
  port (
    i_Clk       : in  std_logic;
    i_ready     : in  std_logic;
	i_busy      : in  std_logic;
	crnt_id     : out std_logic_vector(2 downto 0)
    );
end SSM;

architecture RTL of SSM is


signal next_id     : std_logic_vector(1 downto 0)  := (others => '0');
signal id_out      : std_logic_vector(2 downto 0)  := (others => '0');


begin


 p_ssm : process (i_Clk)
  begin
    if rising_edge(i_Clk) then
	
      next_id <= i_ready & i_busy;
	  
      case next_id is
 
        when "00" =>
		  id_out <= id_out;
        
		when "01" =>
		  id_out <= id_out;
		
		when "11" =>
		  id_out <= id_out;
		
		when "10" =>
		  id_out <= id_out + 1;
		  
		when others =>
     
      end case;
    end if;
  end process p_ssm;
  
  crnt_id <= id_out;
  
end RTL;