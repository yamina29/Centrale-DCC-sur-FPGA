library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;


entity TB_MAE_GLOBALE is
--  Port ( );
end TB_MAE_GLOBALE;

architecture Behavioral of TB_MAE_GLOBALE is

    signal CLK_100MHz: std_logic:='0';
    signal Reset: std_logic;
    signal COM_REG: std_logic_VECTOR(1 downto 0);
    signal OUT_DCC: std_logic;
    signal FIN_DCC: std_logic; 
   
 signal FIN_0: STD_LOGIC;
    signal FIN_1: STD_LOGIC;
    signal Fin_Tempo: STD_LOGIC;
     
    signal GO_0: STD_LOGIC;
    signal GO_1: STD_LOGIC;
    signal Start_Tempo: STD_LOGIC;
    
begin
    L1:entity work.MAE_GLOBALE
    port map (CLK_100MHz => CLK_100MHz ,
              Reset => Reset, 
              COM_REG => COM_REG, 
              OUT_DCC => OUT_DCC,
              FIN_DCC => FIN_DCC,
              FIN_0 => FIN_0,
              FIN_1 => FIN_1,
              Fin_Tempo => Fin_Tempo,
              GO_0 => GO_0,
              GO_1 => GO_1,
              Start_Tempo => Start_Tempo
     );
    
    CLK_100MHz <= not CLK_100MHz after 5 ns; --horloge
    Reset <= '1','0' after 5 ns; -- reset
    OUT_DCC	<= '0','1' after 6 ns ,'0' after 6 ns ,'1' after 6 ns , '0' after 6 ns; -- activation et desactivation de out_dcc (le bit que la machine à états doit recevoir à partir du registre_dcc).
    FIN_0 <= '0','1' after 12 ns ,'0' after 24 ns ,'1' after 30 ns , '0' after 50 ns; --activation et desactivation de FIN_0 (le signal que la machine à etats doit recevoir à partir de Dcc_bit0 à la fin de la generation).
    FIN_1 <= '0','1' after 20 ns ,'0' after 36 ns ,'1' after 46 ns , '0' after 66 ns; --activation et desactivation de FIN_1 (le signal que la machine à etats doit recevoir à partir de Dcc_bit1 à la fin de la generation).
    FIN_DCC	<= '0','1' after 6 ns ,'0' after 40 ns; --activation et desaction de FIN_dcc (le signal que la machine à etats doit recevoir à partir du registre-dcc à la fin de la trame).
    Fin_Tempo <= '0','1' after 45 ns ,'0' after 70 ns;--activation et desaction de FIN_tempo (le signal que la machine à etats doit recevoir à partir de Tempo à la fin de la mesure de l'intervale de temps entre deux trames).
    
                       
end Behavioral;