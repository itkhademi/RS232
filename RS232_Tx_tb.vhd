LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
 
ENTITY RS232_Tx_tb IS
END RS232_Tx_tb;
 
ARCHITECTURE behavior OF RS232_Tx_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RS_232_Tx
    PORT(
         Clock : IN  std_logic;
         Data_In : IN  unsigned(7 downto 0);
         Send : IN  std_logic;
         Busy : OUT  std_logic;
         Serial_Out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Data_In : unsigned(7 downto 0) := (others => '0');
   signal Send : std_logic := '0';

 	--Outputs
   signal Busy : std_logic;
   signal Serial_Out : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RS_232_Tx PORT MAP (
          Clock => Clock,
          Data_In => Data_In,
          Send => Send,
          Busy => Busy,
          Serial_Out => Serial_Out
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		
      -- insert stimulus here 
		Data_In		<=		"11001011";
		Send			<=		'1';
		
		wait for Clock_period;
		Send			<=		'0';

		wait for 1.5 ms;
		Data_In		<=		"01010101";
		Send			<=		'1';
		
		wait for Clock_period;
		Send			<=		'0';
		

      wait;
   end process;

END;
