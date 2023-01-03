-- The switch register is used at first to input the instructions sets
-- It also inputs the data in a second cycle to be placed in a specific register
---------------------------------------------------------------------------------
Library IEEE;
USE IEEE.Std_logic_1164.all;

entity switch_reg is 
   port(
      Q : out std_logic_vector(7 downto 0):="00000000";    
      Clk :in std_logic;  
   sync_reset: in std_logic;  
      D :in  std_logic_vector(7 downto 0)    
   );
end switch_reg;
architecture sr of switch_reg is  
begin  
 process(Clk)
 begin 
    if(rising_edge(Clk)) then
        if(sync_reset='1') then 
            Q <= (others => '0');
        else 
            Q <= D; 
        end if;
    end if;       
 end process;  
end sr; 