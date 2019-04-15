----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:54:54 10/03/2018 
-- Design Name: 
-- Module Name:    alphabet_list - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
USE STD.STANDARD.ALL;
--use STD.STANDARD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;


entity message_generation is
		Port (clk 				: in std_logic;
				reset 				: in std_logic;
				switch 				: in std_logic;
				CONFIG_BITS   : in std_logic_vector(2 downto 0);
				phone_num		  : in std_logic_vector(55 downto 0);
				soil_tol_pos	: in std_logic_vector(15 downto 0);
				soil_tol_neg  : in std_logic_vector(15 downto 0);
				WARNING_SIGNAL: in std_logic_vector(1 downto 0);
				MESSAGE       : out std_logic_vector(439 downto 0));--:=(others => '0');			: out std_logic_vector(31 downto 0););
end message_generation;

architecture Behavioral of message_generation is
	constant testString 		: string(1 to 23):="This is a test string!"&CR;
	constant SLAVE_ID				: string(1 to 6) :="7951: ";
	constant AT_START				: string(1 to 7) :="+++"&NUL&NUL&NUL&NUL;
	constant AT_CNFM				: string(1 to 5) :="a"&NUL&NUL&NUL&NUL;
	constant AT_SAVE				: string(1 to 5) :="AT+S"&CR;
	constant AT_RESET				: string(1 to 5) :="AT+Z"&CR;
	constant AT_WKMOD 			: string(1 to 15):="AT+WKMOD=""SMS"""&CR;
  constant AT_DSTNUM	  	: string(1 to 13):="AT+DSTNUM="""""&CR;
	constant POS_WARNING		: string(1 to 48):=LF&SLAVE_ID&"Warning! Soil Moisture over threshold: %"&CR;
	constant IN_RANGE_MSG		: string(1 to 42):=LF&SLAVE_ID&"Notice! Soil Moisture within range"&CR;
	constant NEG_WARNING		: string(1 to 49):=LF&SLAVE_ID&"Warning! Soil Moisture under threshold: %"&CR;
	constant SYS_CONFIG_S 	: string(1 to 50):=LF&"System configured successfully! Happy Farming :D"&CR;
	constant ERROR					: string(1 to 41):=LF&"Error Administrator intervention needed"&CR;
	constant MAX_MSG_LENGTH : integer := 55;
	constant CONFIGURE			: string(1 to 45):= AT_START&AT_CNFM&AT_DSTNUM&AT_WKMOD&AT_SAVE;

 
	signal MSG_GEN_ENABLE :  std_logic:='0';
	signal GSM_CONFIG_READY:  std_logic:='0';
	

	signal GSM_CONFIG_RDY : std_logic_vector(2 downto 0):=(others=>'0');
	
	
	--------------------FUNCTIONS----------------------------
	--This function was taken from the string_utils package and 
	--not developed by Simeon Ramjit. For more information see:
	--stackoverflow.com/questions/22900938/vhdl-is-there-a-convenient-way-to-assign-ascii-values-to-std-logic-vector
	
	  function to_slv(s: string) return std_logic_vector is 
        constant ss: string(1 to s'length) := s; 
        variable answer: std_logic_vector(1 to 8 * s'length); 
        variable p: integer; 
        variable c: integer; 
    begin 
        for i in ss'range loop
            p := 8 * i;
            c := character'pos(ss(i));
            answer(p - 7 to p) := std_logic_vector(to_unsigned(c,8)); 
        end loop; 
        return answer; 
    end function; 
		
	--------------------FUNCTION END----------------------------
	
begin


message_generation_enable:process(clk,reset)
 constant sys_confgd: std_logic_vector(2 downto 0):="111";
 constant GSM_CONFG	: std_logic_vector(2 downto 0):="100";
 variable sys_present: std_logic_vector(2 downto 0):="000";
 variable	message	: std_logic:='0';
begin
	if(reset='1')then
		MSG_GEN_ENABLE<='0';
		GSM_CONFIG_READY<='0';
		message:='0';
	elsif(rising_edge(clk))then
		if(switch='1')then
			sys_present:=CONFIG_BITS; --phone_num_set &lower_thresh_set &upper_thresh_set;
			
			if(sys_present=GSM_CONFG)then
				GSM_CONFIG_READY<='1';
			elsif(CONFIG_BITS(2)='0')then
				GSM_CONFIG_READY<='0';
			end if;
			
			if(sys_present=sys_confgd)then
				MSG_GEN_ENABLE<='1';
			elsif(sys_present/=sys_confgd)then
				MSG_GEN_ENABLE<='0';
			end if;
		end if;
	 end if;
 end process;
 
 
 phone_num_rise: process(clk,reset)

 begin
	if(reset='1')then
		GSM_CONFIG_RDY<=(others=>'0');
	elsif(rising_edge(clk))then
		if(switch='1')then
			GSM_CONFIG_RDY(0) <= GSM_CONFIG_READY;
			GSM_CONFIG_RDY(1) <= GSM_CONFIG_RDY(0);
		end if;
	end if;
	GSM_CONFIG_RDY(2) <=  not GSM_CONFIG_RDY(1) and GSM_CONFIG_RDY(0)   ;
end process;
	
 string_to_ascii:process(clk,reset,switch)
	constant filler: std_logic_vector(279 downto 0):=(others => '0');
 	variable ASCII: std_logic_vector((MAX_MSG_LENGTH*8)-1 downto 0):=(others => '0');
	variable config_count : integer range 0 to 4:=0;
	begin
		if(reset='1')then 
			ASCII:=(others => '0');
	    MESSAGE<=(others => '0');
			config_count:=0;
		elsif rising_edge(clk)then
			if(switch='1')then
			
--				if(GSM_CONFIG_RDY(2)='1')then 
--				 ASCII:=(others => '0');
--				-- ASCII:=to_slv(CONFIGURE(1 to 23))&phone_num&to_slv(CONFIGURE(24 to 45));
----				 case config_count is
----				 when 0 => ASCII := to_slv(AT_START);
----				 when 1 => ASCII := to_slv(AT_CNFM);
----				 when 2 => ASCII := to_slv(AT_DSTNUM(1 to 11))&phone_num &to_slv(AT_DSTNUM(12 to 13)) &filler;
----				 when 3 => ASCII := to_slv(AT_WKMOD);
----				 when 4 => ASCII := to_slv(AT_SAVE);						  
----				 end case;
----				 config_count:=config_count+1;
--				
--				end if;
				
				if(MSG_GEN_ENABLE='1')then
						ASCII:=(others => '0');
						case WARNING_SIGNAL is
						when "00" => ASCII:=to_slv(IN_RANGE_MSG);
						when "01" => ASCII:=to_slv(POS_WARNING (1 to 46)) &soil_tol_pos &to_slv(POS_WARNING (47 to 48));
						when "10" => ASCII:=to_slv(NEG_WARNING (1 to 47)) &soil_tol_neg &to_slv(NEG_WARNING (48 to 49));
						when others=> ASCII:=to_slv(ERROR);
						end case;
				end if;
	end if;
	end if;
	MESSAGE<=ASCII;
end process;
	

	
	


end Behavioral;



