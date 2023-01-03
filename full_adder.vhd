library ieee;
use ieee.std_logic_1164.all;
entity full_adder is
   port( X, Y, Cin : in std_logic;
         sum, Cout : out std_logic);
end full_adder;
 
architecture bhv of full_adder is
begin
   sum <= (X xor Y) xor Cin;
   Cout <= (X and Y) OR ((X xor Y) and Cin);
end bhv;