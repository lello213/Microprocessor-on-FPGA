-- Output value of specific source register depending on select and if enable is high
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux1 is port (
sel:in std_logic_vector (1 downto 0); -- depends on src
en:in std_logic; -- depends on src_reg_en
val_in1,val_in2,val_in3,val_in4: in std_logic_vector (3 downto 0);
val_out: out std_logic_vector (3 downto 0):="0000");
end mux1;

architecture m1 of mux1 is
begin
val_out<=val_in1 when (sel="00" and en='1') else val_in2 when (sel="01" and en='1')
						else val_in3 when (sel="10" and en='1') else val_in4 
						when (sel="11" and en='1') ;
						
end m1;