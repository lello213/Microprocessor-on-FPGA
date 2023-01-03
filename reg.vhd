-- Consists of 4 8-bit register
-- Value is only stored in them if enable is high
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity reg is port (
clk,reset:in std_logic;
en1,en2,en3,en4:in std_logic; -- enable signal of specific register, coming from dmux 
q1,q2,q3,q4:out std_logic_vector(3 downto 0):="0000";
d1,d2,d3,d4:in std_logic_vector (3 downto 0));
end reg;

architecture r of reg is
begin
reg1: entity RisingEdge_DFlipFlop_SyncReset port map (q1,clk,en1,reset,d1);
reg2: entity RisingEdge_DFlipFlop_SyncReset port map (q2,clk,en2,reset,d2);
reg3: entity RisingEdge_DFlipFlop_SyncReset port map (q3,clk,en3,reset,d3);
reg4: entity RisingEdge_DFlipFlop_SyncReset port map (q4,clk,en4,reset,d4);

end r;