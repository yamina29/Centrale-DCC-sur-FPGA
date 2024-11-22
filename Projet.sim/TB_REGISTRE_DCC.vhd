library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TB_REGISTRE_DCC is
--  Port ( );
end TB_REGISTRE_DCC;

architecture Behavioral of TB_REGISTRE_DCC is
    signal CLK_100MHz: std_logic:='0';
    signal Reset: std_logic;
    signal COM_REG: std_logic_VECTOR(1 downto 0);
    signal Trame_DCC: std_logic_vector(50 downto 0);
    signal OUT_DCC: std_logic;
    signal FIN_DCC: std_logic; 
    
begin
    L0:entity work.REGISTRE_DCC
    port map (CLK_100MHz => CLK_100MHz ,
              Reset => Reset, 
              COM_REG => COM_REG, 
              Trame_DCC => Trame_DCC, 
              OUT_DCC => OUT_DCC,
              FIN_DCC => FIN_DCC
              );
    
    CLK_100MHz <= not CLK_100MHz after 5 ns; --horloge
    Reset <= '1','0' after 5 ns; --reset
    Trame_DCC <= "101" & x"7FFAFFFBCFFA", "111"& x"AFF0FF0BCFFA" after 10 ns, "001" & x"3FF0FF0BCFFA" after 20 ns; -- differentes valeurs de trames
    COM_REG<="00" , "01" after 15ns, "10" after 30 ns, "00" after 100ns; --differentes valeurs de com_reg (le signal que le registre_dcc doit recevoir à partir de la machine à etats pour faire le v=chargement le declage au le maintien de la valeur de reg.

end Behavioral;
