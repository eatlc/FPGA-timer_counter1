library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity top is
generic(
c_clkfreq	:integer :=100_000_000
);
port(
clk			:in std_logic;
sw_i		:in std_logic_vector(1 downto 0);
counter_o	:out std_logic_vector(3 downto 0)
);
end top;

architecture Behavioral of top is

constant c_timer2seclim		: integer := c_clkfreq*2;
constant c_timer1seclim		: integer := c_clkfreq;
constant c_timer500mslim	: integer := c_clkfreq/2;
constant c_timer250mslim	: integer := c_clkfreq/4;

signal timer				:integer range 0 to c_timer2seclim :=0;
signal timerlim				:integer range 0 to c_timer2seclim :=0;
signal counterint			:std_logic_vector(3 downto 0) := (others => '0');

begin

timerlim <= 	c_timer2seclim when sw_i = "00" else
				c_timer1seclim when sw_i = "01" else				
				c_timer500mslim when sw_i = "10" else
				c_timer250mslim;

process (clk) begin
if (rising_edge(clk)) then
	
	if(timer >=c_timer2seclim) then
		counterint <= counterint+1;
		timer <=0;
	else 
		timer <= timer +1 ;
	
	end if;

end if;
end process;
counter_o <= counterint;
end Behavioral;
