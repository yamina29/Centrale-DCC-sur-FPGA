library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Top_DCC is
end TB_Top_DCC;

architecture Behavioral of TB_Top_DCC is
    signal CLK_100MHz : STD_LOGIC:='0';
    signal Reset : STD_LOGIC;
    signal Interrupteur : STD_LOGIC_VECTOR(7 downto 0);
    signal SORTIE_DCC: STD_LOGIC;
    
begin
    TOP :entity work.Top_DCC 
    port map( CLK_100MHz => CLK_100MHz,
              Reset => Reset,
              Interrupteur => Interrupteur, 
              SORTIE_DCC => SORTIE_DCC);
            
 CLK_100MHz <= not CLK_100MHz after 5ns; --horloge
 Reset <= '1' , '0' after 5ns, '1' after 9ms, '0' after 10ms;  --test  du rest en l'activant et en le desactivant. 
 Interrupteur <= "10000000","01000000" after 8ms,"00010000" after 24ms,"10001000" after 42ms; --activation de l'interrupteur 8 puis l'interrupteur 7 puis l'interrupteur 5 et la fin on active l'interrupteur 8
end Behavioral;