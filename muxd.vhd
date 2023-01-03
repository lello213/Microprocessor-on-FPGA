-- The Multiplexer-D sends an incr_pc signal to allow the pc to increment
-- Only if start signal (start the operation) and incr_pc are both high
---------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity muxd is port (
start,incr_pc:in std_logic;
enable:out std_logic);
end muxd;

architecture m of muxd is
begin
enable<='1' when (start='1' and incr_pc='1') else '0';
end m;
