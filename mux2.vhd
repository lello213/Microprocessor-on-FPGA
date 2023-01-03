-- Output value of specific destination register depending on select and if enable is high
-- Is only used wen op="01" or op="10"
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux2 is port (
sel:in std_logic_vector (1 downto 0); -- depends on dst signal
en:in std_logic; -- depends on dst_reg_en signal
val_in1,val_in2,val_in3,val_in4: in std_logic_vector (3 downto 0);
val_out: out std_logic_vector (3 downto 0):="0000");
end mux2;

architecture m2 of mux2 is
begin
val_out<=val_in1 when (sel="00" and en='1') else val_in2 when (sel="01" and en='1')
						else val_in3 when (sel="10" and en='1') else val_in4 
						when (sel="11" and en='1');
						
end m2;