-- The memory stores the instruction from the user input in the switch register
-- It is composed of a 16-word with 8-bit words.
---------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

package mem_array is  -- global use of package to be able to use the array type in all entities
        type mem_array_type is array(0 to 15) of std_logic_vector(7 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.mem_array.all;

entity memory is port(
							inst_addr:in std_logic_vector(7 downto 0);
							sel_l:in std_logic; --read control
							wr_l:in std_logic; --write control
							inst_mem:out mem_array_type:=("00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000");
							q:out std_logic_vector(7 downto 0):="00000000";
							addr:in natural  -- to be replaced by counter
);
end memory;
architecture behav of memory is 

signal outp:std_logic;
signal and_gate:std_logic;
signal inst : mem_array_type:=("00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000");
begin
outp<=not sel_l;
and_gate<=(not sel_l) and (not wr_l); 
inst(addr)<=inst_addr when and_gate='1'; -- when both controls are low => write in memory address
q<=inst(addr) when outp='1' and and_gate='0'; -- when outp='1' and write enable is low => read the value in memory address
inst_mem<=inst;
end behav;