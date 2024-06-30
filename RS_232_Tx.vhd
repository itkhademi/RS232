library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity RS_232_Tx is
    Port ( 
				Clock 		: in  	STD_LOGIC;
				Data_In		: in  	unsigned 	(7 downto 0);
				Send 			: in  	STD_LOGIC;
				Busy 			: out  	STD_LOGIC;
				Serial_Out 	: out  	STD_LOGIC);
end RS_232_Tx;

architecture Behavioral of RS_232_Tx is

	signal	Data_In_Int			:	unsigned	(7 downto 0)				:=	(others=>'0');
	signal	Send_Int				:	std_logic								:=	'0';
	signal	Send_Prev			:	std_logic								:=	'0';
	signal	Serial_Out_Int		:	std_logic								:=	'0';
	signal	Busy_Int				:	std_logic								:=	'0';
	
	signal	Data_Bit_Count		:	unsigned	(3 downto 0)				:=	(others=>'0');
	signal	Parity_Bit			:	std_logic								:=	'0';
	signal	Packet_Generate	:	std_logic								:=	'0';
	signal	Start_Sending		:	std_logic								:=	'0';
	signal	Full_Packet			:	unsigned	(11 downto 0)				:=	(others=>'0');
	
	
	-----		Baud rate = 9600 => bit width = 1/9600 = 104.16 us.
	-----		Clock Freq. = 50 MHz => Clock Period = 20 ns.
	-----		Bit sample = 104.16 us / 20 ns = 5208.
	constant	Baud_Rate_9600		:	unsigned	(12 downto 0)				:=	to_unsigned(5207,13);
	signal	Bit_Width_Count	:	unsigned	(12 downto 0)				:=	(others=>'0');
	
begin

	Serial_Out						<=		Serial_Out_Int;
	Busy								<=		Busy_Int;

	process(Clock)
	begin
	
		if rising_edge(Clock) then
		
			Data_In_Int				<=		Data_In;
			Send_Int					<=		Send;
			Send_Prev				<=		Send_Int;			
			Serial_Out_Int			<=		'1';
			Packet_Generate		<=		'0';
			
			
			Bit_Width_Count		<=		Bit_Width_Count + 1;
			if (Bit_Width_Count = Baud_Rate_9600) then
			
				Bit_Width_Count	<=		(others=>'0');
				Data_Bit_Count		<=		Data_Bit_Count + 1;
			
			end if;
			
			
			if (Send_Int = '1' and Send_Prev = '0' and Busy_Int = '0') then
				
				Busy_Int				<=		'1';
				Packet_Generate	<=		'1';
				Parity_Bit			<=		Data_In_Int(0) xor Data_In_Int(1) xor Data_In_Int(2) xor Data_In_Int(3) xor
												Data_In_Int(4) xor Data_In_Int(5) xor Data_In_Int(6) xor Data_In_Int(7);
												
			end if;
			
			if (Packet_Generate = '1') then
			
				Start_Sending		<=		'1';
				Full_Packet			<=		'1'&'1'&Parity_Bit&Data_In_Int&'0';
				Data_Bit_Count		<=		(others=>'0');		
				Bit_Width_Count	<=		(others=>'0');		
				
			end if;
			
			if (Start_Sending = '1') then
			
				Serial_Out_Int		<=		Full_Packet(to_integer(Data_Bit_Count));
				
			end if;
			
			if (Data_Bit_Count = to_unsigned(11,4)) then
				
				Start_Sending		<=		'0';
				Busy_Int				<=		'0';
			
			end if;
		
		end if;
	
	end process;

end Behavioral;

