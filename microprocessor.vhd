library ieee;
use ieee.std_logic_1164.all;
use work.all;
use work.mem_array.all;
use work.state_pckg.all;

entity microprocessor is port (
clk,reset,start:in std_logic;
sel_l,wr_l:in std_logic;
C:in std_logic;
state: out state_type;
inst:in std_logic_vector(7 downto 0));
end microprocessor;

architecture uc of microprocessor is
signal q_sw,q_out_mem:std_logic_vector(7 downto 0);
signal q_mem:mem_array_type;
signal pc:natural ;
signal fetch_en:std_logic;
signal incr_pc:std_logic;
signal src_reg_en:std_logic;
signal dst_reg_en:std_logic;
signal addsub:std_logic;
signal din:std_logic; --NOT IMPLEMENTED YET (USE CYCLE_COUNT TO STORE DATA IN REGISTERS)
signal ssd:std_logic;
signal pc_reg:std_logic;
signal alu_out:std_logic;
signal muxa_out:std_logic;
signal ci_out_en:std_logic;
signal ci_out:std_logic;
signal op,cc,src,dst: std_logic_vector(1 downto 0);
signal en,en1,en2,en3,en4:std_logic;
signal regd1,regd2,regd3,regd4:std_logic_vector(3 downto 0);
signal q1,q2,q3,q4:std_logic_vector(3 downto 0);
signal q_out_mux1,q_out_mux2:std_logic_vector (3 downto 0);
signal q_out_dmuxa,q_disp:std_logic_vector (3 downto 0);
signal q_out_muxa:std_logic_vector( 3 downto 0);
signal disp1,disp2:std_logic_vector(0 to 6);
signal q_out_muxb:std_logic_vector (3 downto 0);
signal q_out_alu:std_logic_vector (3 downto 0);
signal cout,overflow:std_logic;
signal temp_reg_out:std_logic_vector(3 downto 0);
signal q_out_muxc:std_logic_vector(3 downto 0);



begin
SW_REG1	: entity switch_reg 				port map (q_sw,clk,reset,inst);

MUXD1		: entity muxd						port map (start,incr_pc,en);

PC_1		: entity pc1						port map (clk,reset,en,pc_reg,src,dst,pc);

MEM1		: entity memory 	  				port map (q_sw,sel_l,wr_l,q_mem,q_out_mem,pc);

IR1		: entity instruction_register port map (clk,fetch_en,q_out_mem,op,cc,src,dst);

CU1		: entity control_unit			port map (clk,reset,start,op,cc,src,C,state,fetch_en,incr_pc,src_reg_en,dst_reg_en,ci_out_en,addsub,din,ssd,pc_reg,alu_out,muxa_out,ci_out);

DMUX1		: entity dmux						port map (dst,din,alu_out,en1,en2,en3,en4);

DMUXB1	: entity dmuxb						port map (q_out_muxc,alu_out,din,dst,regd1,regd2,regd3,regd4);

REG1		: entity reg						port map (clk,reset,en1,en2,en3,en4,q1,q2,q3,q4,regd1,regd2,regd3,regd4);

MUX_1		: entity mux1 						port map (src,src_reg_en,regd1,regd2,regd3,regd4,q_out_mux1);

MUX_2		: entity mux2 						port map (dst,dst_reg_en,q1,q2,q3,q4,q_out_mux2);

MUXA1		: entity muxa						port map (temp_reg_out,q_out_mux1,muxa_out,q_out_muxa);

DMUXA1	: entity dmuxa 					port map (q_out_mux2,ssd,q_out_dmuxa,q_disp);

DISP_1	: entity display					port map (q_disp,disp1,disp2);

MUXB1		: entity muxB						port map (q_out_dmuxa,ci_out,ci_out_en,q_out_muxb);

ALU1     : entity alu						port map (addsub,q_out_muxb,q_out_muxa,q_out_alu,cout,overflow);

TMP1		: entity temp_reg					port map (temp_reg_out,clk,src_reg_en,dst_reg_en,reset,q_out_alu);

MUXC1		: entity muxc						port map (inst(3 downto 0),temp_reg_out,alu_out,din,q_out_muxc);

end uc;



