-- Stores value of specific register depending on sel (dst) and if alu_out=1 or din=1
--------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity dmuxb is port(
val_in:in std_logic_vector (3 downto 0);
alu_out,din:in std_logic;
sel:in std_logic_vector (1 downto 0);
regd_1,regd_2,regd_3,regd_4:out std_logic_vector(3 downto 0):="0000");
end dmuxb;

architecture db of dmuxb is
begin
regd_1<=val_in when sel="00" and (alu_out='1' or din='1');
regd_2<=val_in when sel="01" and (alu_out='1' or din='1');
regd_3<=val_in when sel="10" and (alu_out='1' or din='1');
regd_4<=val_in when sel="11" and (alu_out='1' or din='1');
end db;