LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
ENTITY RS_232_Rx_tb IS
END RS_232_Rx_tb;
 
ARCHITECTURE behavior OF RS_232_Rx_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RS_232_Rx
    PORT(
         Clock : IN  std_logic;
         Data_Out : OUT  unsigned(7 downto 0);
         Valid : OUT  std_logic;
         Serial_In : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Serial_In : std_logic := '0';

 	--Outputs
   signal Data_Out : unsigned(7 downto 0);
   signal Valid : std_logic;

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RS_232_Rx PORT MAP (
          Clock => Clock,
          Data_Out => Data_Out,
          Valid => Valid,
          Serial_In => Serial_In
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

      wait for Clock_period*10;

      -- insert stimulus here 
		-- idle
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- start bit		
		Serial_In		<=		'0';
      wait for Clock_period*5208;

		-- data bit 0
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 1
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 2
		Serial_In		<=		'0';
      wait for Clock_period*5208;

		-- data bit 3
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 4
		Serial_In		<=		'0';
      wait for Clock_period*5208;
		
		-- data bit 5		
		Serial_In		<=		'0';
      wait for Clock_period*5208;

		-- data bit 6
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 7
		Serial_In		<=		'0';
      wait for Clock_period*5208;

		-- parity
		Serial_In		<=		'0';
      wait for Clock_period*5208;

		-- stop bit 1
		Serial_In		<=		'1';		
      wait for Clock_period*5208;

		-- idle
		Serial_In		<=		'1';		



		-- idle
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- start bit		
		Serial_In		<=		'0';
      wait for Clock_period*5208;

		-- data bit 0
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 1
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 2
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 3
		Serial_In		<=		'0';
      wait for Clock_period*5208;

		-- data bit 4
		Serial_In		<=		'0';
      wait for Clock_period*5208;
		
		-- data bit 5		
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 6
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- data bit 7
		Serial_In		<=		'0';
      wait for Clock_period*5208;

		-- parity
		Serial_In		<=		'1';
      wait for Clock_period*5208;

		-- stop bit 1
		Serial_In		<=		'1';		
      wait for Clock_period*5208;

		-- idle
		Serial_In		<=		'1';		



      wait;
   end process;

END;
