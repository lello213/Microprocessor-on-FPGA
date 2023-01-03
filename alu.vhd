-- ALU performs addition or substraction between src reg and carry or src reg with carry and dst reg
-----------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.all;
entity alu is
   port( OP: in std_logic;		-- if OP='1' then substraction elsif op='0' addition
          A,B  : in std_logic_vector(3 downto 0); 
          R  : out std_logic_vector(3 downto 0):="0000"; --Result
          Cout, OVERFLOW : out std_logic);
end alu;
 
architecture struct of alu is
signal C1, C2, C3, C4: std_logic:='0';
signal TMP: std_logic_vector(3 downto 0);
signal res:std_logic_vector(3 downto 0);
 
-- explanation of code below:
--------------------------------
--5-2=3 => 5 (0101)
--			- 2 (0010) => we convert 2 into its two's complement form (1110)
-- Let's apply the following in the code below for the number 2 two's complement (1110)
-- B<="0010"
begin
TMP(0)<='0'; 									
TMP(1)<=B(1) when op='0' else not B(1); --'1' if op='1'
TMP(2)<=B(2) when op='0' else not B(2); --'1' if op='1'
TMP(3)<=B(3) when op='0' else not B(3); --'1' if op='1'

FA0:entity full_adder port map(A(0),B(0),'0', res(0),C1); -- R0
FA1:entity full_adder port map(A(1),TMP(1),C1, res(1),C2); -- R1
FA2:entity full_adder port map(A(2),TMP(2),C2, res(2),C3); -- R2
FA3:entity full_adder port map(A(3),TMP(3),C3, res(3),C4); -- R3

OVERFLOW <= C3 XOR C4 ; --Last Bit carried
Cout <= C4;
R<=res(3) & res(2) & res(1) & res (0);
end struct;