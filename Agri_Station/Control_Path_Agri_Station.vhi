
-- VHDL Instantiation Created from source file Control_Path_Agri_Station.vhd -- 02:17:35 03/28/2019
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Control_Path_Agri_Station
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		ADC_DONE : IN std_logic;
		IRRI_DONE : IN std_logic;
		TX_DONE : IN std_logic;
		CONFIG_BITS : IN std_logic_vector(2 downto 0);          
		CONFIGURE_EN : OUT std_logic;
		ADC_EN : OUT std_logic;
		IRRI_ACTIVATE : OUT std_logic;
		TRANSMIT_EN : OUT std_logic
		);
	END COMPONENT;

	Inst_Control_Path_Agri_Station: Control_Path_Agri_Station PORT MAP(
		clk => ,
		reset => ,
		ADC_DONE => ,
		IRRI_DONE => ,
		TX_DONE => ,
		CONFIG_BITS => ,
		CONFIGURE_EN => ,
		ADC_EN => ,
		IRRI_ACTIVATE => ,
		TRANSMIT_EN => 
	);


