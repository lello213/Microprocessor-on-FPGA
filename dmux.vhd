-- The deMultiplexer stores the data in the specific registers according to the destination control signal
-- It only stores the value if either of the destination register enable, data in or alu output is high
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity dmux is port (
dst: in std_logic_vector (1 downto 0); --sel
din,alu_out: in std_logic; 
en1,en2,en3,en4: out std_logic);
end dmux;

architecture d of dmux is
begin
en1<='1' when ((alu_out='1' or din='1') and dst="00") else '0';
en2<='1' when ((alu_out='1' or din='1') and dst="01") else '0';
en3<='1' when ((alu_out='1' or din='1') and dst="10") else '0';
en4<='1' when ((alu_out='1' or din='1') and dst="11") else '0';
end d;
