-- Outputs value of temporary register if src_reg_en=1  or dst_reg_en=1
-----------------------------------------------------------------------------------------------------------
Library IEEE;
USE IEEE.Std_logic_1164.all;

entity temp_reg is --For storing data of each register (A,G,R0->R7)
   port(
      Q : out std_logic_vector(3 downto 0):="0000";    
      Clk :in std_logic;
		
      src_reg_en,dst_reg_en : in std_logic;  
   sync_reset: in std_logic;  
      D :in  std_logic_vector(3 downto 0)    
   );
end temp_reg;
architecture tr of temp_reg is  
begin  
 process(Clk)
 begin 
    if(rising_edge(Clk)) then
        if(sync_reset='1') then 
            Q <= (others => '0');
        elsif(src_reg_en = '1' or dst_reg_en='1') then
            Q <= D; 
        end if;
    end if;       
 end process;  
end tr; 