-- The control unit is responsible for controling the operations realised in the processor by sending control signals to its different components
------------------------------------------------------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package state_pckg is -- to use state type in global mode
        type state_type is (initial,zero,one,two,three,four);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.state_pckg.all;


entity control_unit is port (
clk,reset	: in std_logic;
start			: in std_logic;
op				: in std_logic_vector (1 downto 0);
cc				: in std_logic_vector (1 downto 0);
src			: in  std_logic_vector (1 downto 0);
C				: in std_logic;

st				: out state_type;
fetch_en		: out std_logic:='0'; -- enable fetch of inst from memory to IR
incr_pc		: out std_logic:='0'; -- enable incrementation of pc
src_reg_en	: out std_logic:='0'; --enable to send value from source register along carry to ALU
dst_reg_en  : out std_logic:='0'; -- enable to send value from destination register
ci_out_en	: out std_logic:='0'; --enable ci_out input to muxb
addsub		: out std_logic:='0'; -- 0 for add and 1 for sub
din			: out std_logic:='0'; -- enable for inputs bits loaded into register pointed by dst
ssd			: out std_logic:='0'; -- enable for display content of dsp register on 7seg
pc_reg		: out std_logic:='0'; -- enable for address bits in IR to go to pc
ALUout		: out std_logic:='0'; -- enable for output of alu to go to dest reg
MUXA_out		: out std_logic:='0'; --enable for outp of alu in first clock cycle to go a second time to alu

ci_out		: out std_logic:='0');

end control_unit;

architecture fsm of control_unit is
signal state:state_type;

begin
P1:process (clk)
variable L				: std_logic; -- if cc="00"
variable H				: std_logic; -- if cc="00"
variable ci				:std_logic;
variable cycle_count	:natural; -- for delay in addition or substraction

begin
if reset='1' then
state<=initial;

elsif rising_edge (clk) then

		case state is
		when initial=>
		if start='1' then
		state<=zero;
		incr_pc<='0';
		end if;
		
		when zero=> -- Enable fetch of instructions and reset all other parameters
	
		fetch_en<='1';
		
		incr_pc<='0';			
		src_reg_en<='0';
		dst_reg_en<='0';
		ci_out_en<='0';
		addsub<='0';			
		din<='0';				
		ssd<='0';			
		pc_reg<='0';		
		ALUout<='0';			
		MUXA_out<='0';			
		ci_out<='0';			
		
		L:='0';				
		H:='0';					
		ci:='0';		
	

		if cycle_count<1 then 
		cycle_count:=cycle_count+1;
		else
		state<=one;
		cycle_count:=0;
		fetch_en<='1';
		end if;
		when one=>
		fetch_en<='0';

			if (op="00" or op="01" or op="10") then  -- checking if executable register instruction
							state<=two;
							src_reg_en<='1';
						
							ci_out_en<='1';
							ci_out_en<='1';
							addsub<='0'; -- Result= source + carry in first cycle so in second cycle we can perform -Result=> - source -carry
					
							if    cc="00" then
							ci:='0';
							elsif cc="01" then
							ci:='1';
							elsif cc="10" then
							ci:=C;
							else
							ci:=not C;
							end if;
							ci_out<=ci;
							
		elsif op="11" and cc="00" then
				L:=src(0);
				H:=src(1);
				if (L='1') then
				
				if cycle_count<1 then -- to load data in second cycle
				cycle_count:=cycle_count+1;
				else
				cycle_count:=0;
				incr_pc<='1';
				din<='1';
				state<=zero;
				end if;
		
				elsif (H='1') then
				
				incr_pc<='1';
				cycle_count:=0;
				dst_reg_en<='1';
				ssd<='1';
				state<=initial;
				
				end if;
				
		elsif op="11" and (cc="01" or ((cc="10") and (ci='1')) or ((cc="11") and (ci='0'))) then

				pc_reg<='1';
				state<=zero;
				fetch_en<='1';
		end if;
					
		when two=>	
		
				src_reg_en<='0';	
				incr_pc<='1';
				if op="00" then --src+carry 
				state<=three;
				elsif op="01" then -- src+carry+dst
				MUXA_out<='1';
				dst_reg_en<='1';
				ci_out_en<='0';
				addsub<='0';
				state<=three;
				elsif op="10" then
				MUXA_out<='1';
				dst_reg_en<='1';
				ci_out_en<='0';
				addsub<='1'; -- dst-src-carry
				state<=three;
				end if;
			
			when three=> state<=four;
							 MUXA_out<='0';
							 incr_pc<='0';
							 dst_reg_en<='0';
							 ALUout<='1'; 
			when four=>							 
							ALUout<='0';
							fetch_en<='1';
						   state<=initial;
						  
			end case;
			
end if;
end process P1;
st<=state;
end fsm;
							 
			
				
	
					