-- Output either value of source register or value of source register + carry coming from ALU in second cycle 
-- Depends on enable
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity muxa is port (
alu_out,d_reg:in std_logic_vector (3 downto 0);
en:in std_logic; -- depends on muxa_out signal
val_out:out std_logic_vector (3 downto 0):="0000");
end muxa;

architecture ma of muxa is 
begin
val_out<=alu_out when en='1' else d_reg;
end ma;