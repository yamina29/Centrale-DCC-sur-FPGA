library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_DCC_BIT1 is
end TB_DCC_BIT1;

architecture Behavioral of TB_DCC_BIT1 is
signal CLK_100MHz , CLK_1MHZ : std_logic :='0'; 
signal Reset: std_logic;
signal GO_1: std_logic;
signal DCC_1, FIN_1: std_logic;
begin
 L0 :entity work.DCC_BIT1
  port map( CLK_100MHz =>CLK_100MHz,
            CLK_1MHZ => CLK_1MHZ,
            Reset=> Reset,
            GO_1=> GO_1, 
            DCC_1=> DCC_1,
            FIN_1=>FIN_1);
 CLK_100MHz <= not CLK_100MHz after 5ns; --horloge pour la mae du dcc_bit1
 CLK_1MHZ   <= not CLK_1MHz after 0.5 us; -- horloge pour le compteur
 Reset <= '1' , '0' after 5ns;   --reset
 GO_1 <= '0' ,'1' after 10ns, '0' after 100us, '1' after 200us , '0' after 300us, '1' after 400us,'0' after 500us,'1' after 600us; -- activation et desaction de GO_1 (le signal que le dcc_bit1 doit recevoir à partir de la machine à états pour commencer le generation du bit).     
end Behavioral;