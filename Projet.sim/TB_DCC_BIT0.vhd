----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2024 10:29:02
-- Design Name: 
-- Module Name: TB_DCC_BIT0 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_DCC_BIT0 is
end TB_DCC_BIT0;

architecture Behavioral of TB_DCC_BIT0 is
signal CLK_100MHz , CLK_1MHZ : std_logic :='0'; 
signal Reset: std_logic;
signal GO_0: std_logic;
signal DCC_0, FIN_0: std_logic;
begin
 L0 :entity work.DCC_BIT0
  port map( CLK_100MHz =>CLK_100MHz,
            CLK_1MHZ => CLK_1MHZ,
            Reset=> Reset,
            GO_0=> GO_0, 
            DCC_0=> DCC_0,
            FIN_0=>FIN_0);
 CLK_100MHz <= not CLK_100MHz after 5ns; --horloge pour la mae du dcc_bit0.
 CLK_1MHZ   <= not CLK_1MHz after 0.5 us; -- horloge pour le compteur.
 Reset <= '1' , '0' after 5ns;   --reset
 GO_0 <= '0' ,'1' after 10ns, '0' after 20ns, '1' after 30ns , '0' after 40ns, '1' after 400us,'0' after 500us,'1' after 600us; -- activation et desaction de GO_0 (le signal que le dcc_bit0 doit recevoir à partir de la machine à états pour commencer le generation du bit).       
end Behavioral;
