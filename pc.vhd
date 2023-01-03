-- The program counter acts as an address to the memory
-- It can only be incremented by a control signal coming from control unit
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all; -- to be ebale to use + with std_logic_vector
use ieee.numeric_std.all;

entity pc1 is port (
clk,reset,en,pc_reg:in std_logic;
src,dst:in std_logic_vector(1 downto 0);
counter:out natural );
end pc1;

architecture count of pc1 is
signal cnt:natural;
begin
P1:process (clk,reset)
begin
	if reset='1' then
	cnt<=0;
	elsif rising_edge (clk) then
		if pc_reg='1' then --Enable for address bits in IR to go to PC
		cnt<=to_integer(unsigned(src & dst));
		elsif en='1' then  -- incr_pc<='1' =>Enable incrementation of pc
		cnt<=cnt+1;
		end if;
	end if;
end process P1;
counter<=cnt;
end count;