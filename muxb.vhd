-- Output either cc (carry) or value of destination register depending on enable
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity muxb is port (
val_in:in std_logic_vector (3 downto 0);
ci_out:in std_logic;
en:in std_logic; -- depends on ci_out_en signal
val_out:out std_logic_vector (3 downto 0):="0000");
end muxb;

architecture mb of muxb is 
signal tmp:std_logic_vector(3 downto 0); 
begin
tmp<="000" & ci_out;
val_out<=tmp when en='1' else val_in;
end mb;