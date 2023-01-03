library ieee;
use ieee.std_logic_1164.all;

entity display is port (
val_in:in std_logic_vector (3 downto 0);
disp1,disp2:out std_logic_vector(0 to 6):="1110111");
end display;

architecture d of display is
begin
disp1<="1110111" when val_in="0000" or val_in="1010" else
		"0100100" when val_in="0001" or val_in="1011" else
		"1011101" when val_in="0010" or val_in="1100" else
		"1101101" when val_in="0011" or val_in="1101" else
		"0101110" when val_in="0100" or val_in="1110" else
		"1101011" when val_in="0101" or val_in="1111" else
		"1111011" when val_in="0110"  else
		"0100101" when val_in="0111"  else
		"1111111" when val_in="1000"  else
		"1101111" when val_in="1001";
		
disp2<="1110111" when val_in="0000" or 
							 val_in="0001" or 
							 val_in="0010" or 
							 val_in="0011" or 
							 val_in="0100" or 
							 val_in="0101" or 
							 val_in="0110" or 
							 val_in="0111" or 
							 val_in="1000" or 
							 val_in="1001" else
		"0100100"  when val_in="1010" or
							 val_in="1011" or
							 val_in="1100" or
							 val_in="1101" or
							 val_in="1110" or
							 val_in="1111" ;
						
end d;