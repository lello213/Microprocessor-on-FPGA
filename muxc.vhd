-- Outputs either value of switch reg (instruction or data) if din=1 (data enable) or value of temp reg if alu_out=1
--------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity muxc is port (
sw_in:in std_logic_vector (3 downto 0);
tmp_in:in std_logic_vector (3 downto 0);
en:in std_logic;--depends on alu_out signal
din:in std_logic;
val_out:out std_logic_vector (3 downto 0):="0000");
end muxc;

architecture mc of muxc is 
begin
val_out<=sw_in when din='1' else tmp_in when en='1'; 
end mc;