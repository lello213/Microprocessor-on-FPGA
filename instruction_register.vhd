-- The instruction register receives the instruction 
-- If fetch enable is high it divides the instruction to 4 parts of 2 bits each op,cc,src,dst
---------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity instruction_register is port (
clk:in std_logic;
en:in std_logic;
inst:in std_logic_vector (7 downto 0);
op,cc,src,dst:out std_logic_vector(1 downto 0));
end instruction_register;

architecture ir of instruction_register is
begin
P1:process (clk)
begin
if rising_edge (clk) then
	if en='1' then
	op<=inst(7 downto 6);
	cc<=inst(5 downto 4);
	src<=inst(3 downto 2);
	dst<=inst(1 downto 0);
	end if;
end if;
end process P1;
end ir;