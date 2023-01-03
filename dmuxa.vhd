-- Output value of destination register to either multiplexer B or to 7 seg display if sel='1'
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity dmuxa is port(
val_in:in std_logic_vector (3 downto 0);
sel:in std_logic; -- depends on ssd signal
val_out:out std_logic_vector(3 downto 0):="0000"; -- output to muxB
display_out:out std_logic_vector(3 downto 0):="0000"); -- output to 7seg disp
end dmuxa;

architecture da of dmuxa is
begin
val_out<=val_in when sel='0';
display_out<=val_in when sel='1';
end da;