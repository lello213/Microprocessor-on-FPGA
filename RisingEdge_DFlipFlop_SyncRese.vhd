Library IEEE;
USE IEEE.Std_logic_1164.all;

entity RisingEdge_DFlipFlop_SyncReset is --For storing data of each register (A,G,R0->R7)
   port(
      Q : out std_logic_vector(3 downto 0);    
      Clk :in std_logic;
      en : in std_logic;  
   sync_reset: in std_logic;  
      D :in  std_logic_vector(3 downto 0)    
   );
end RisingEdge_DFlipFlop_SyncReset;
architecture Behavioral of RisingEdge_DFlipFlop_SyncReset is  
begin  
 process(Clk)
 begin 
    if(rising_edge(Clk)) then
        if(sync_reset='1') then 
            Q <= (others => '0');
        elsif(en = '1') then
            Q <= D; 
        end if;
    end if;       
 end process;  
end Behavioral; 