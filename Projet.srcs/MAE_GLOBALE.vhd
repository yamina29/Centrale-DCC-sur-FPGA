library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity MAE_GLOBALE is
    Port (  CLK_100MHz: in STD_LOGIC;	
            Reset	: in STD_LOGIC;
            FIN_0: in STD_LOGIC; -- fin de la generation d'un 0 dans dcc_bit0
            FIN_1: in STD_LOGIC; -- fin de la generation d'un 1 dans dcc_bit1
            Fin_Tempo: in STD_LOGIC; --fin de la mesure du temps entre deux trames
            OUT_DCC	: in STD_LOGIC; --le bit envoyé par le registre_dcc
            FIN_DCC	: in STD_LOGIC;  --fin de la trame 
            COM_REG	: out STD_LOGIC_VECTOR(1 downto 0); --pour controler le regitre_dcc
            GO_0: out STD_LOGIC; --pour controler le module DCC_bit0 pour commencer à generer un 0
            GO_1: out STD_LOGIC; -- pour controler le DCC_bit1 pour commencer à generer un 0
            Start_Tempo: out STD_LOGIC -- pour controler le module tempo pour commencer la mesure du temps
            );           
end MAE_GLOBALE;

architecture Behavioral of MAE_GLOBALE is   
type etat is ( S1, S2, S3,S4);		-- Etats de la MAE
signal EP,EF: etat;											-- Etat Présent, Etat Futur

begin

    ---------------------------
	-- MAE - Registre d'Etat --
	---------------------------

process(CLK_100MHz, Reset)
begin
    if Reset ='1' then EP <= S1; -- signal de sortie au niveau bas
    elsif rising_edge(CLK_100MHz) then EP <= EF;
    end if; 
end process;

    ----------------------------------------------
	-- MAE - Evolution des Etats et des Sorties --
	----------------------------------------------

process(EP,FIN_0,FIN_1,Fin_Tempo,OUT_DCC,FIN_DCC)
begin
COM_REG <="00";GO_0 <= '0'; GO_1 <= '0';  Start_Tempo <= '0';
case (EP) is
     when S1 => EF<=S2;COM_REG <="01"; -- chargement de la trame
     when S2 =>EF<=S2; 
               if Fin_dcc='0' then   -- Si on n'est pas encore arrivé au drnier bit de la trame.
               if OUT_DCC ='1' then GO_1 <= '1'; else GO_0 <= '1'; end if;end if; -- mettre go_1 à 1 et l'envoyer à dcc_bit1 pour generer un 1 si la bit envoyer par le registre_dcc est un 1 si c'est un 0 mettre go_0 à 1 et l'envoyer à dcc_bit0 pour generer un 0.
               if (FIN_0='1' or FIN_1='1')then EF<=S3; end if; -- à la reception de fin_0 ou fin_1 à partir de dcc_bit0 ou dcc_bit1 indiquant la fin de la geneartion d'un bit la machine passe à l'etat S3
               if (FIN_DCC ='1') then EF<=S4;end if; -- à la reception de fin_dcc='1' du registre_dcc indiquant la fin de la trame la machine a etat passe à l'etat S4
               
     when S3 => EF<=S2;
                COM_REG <="10"; -- faire un decalage pour avoir le prochain bit dans la trame
                
     when S4 =>EF<=S4; 
              Start_Tempo <= '1';-- mettre start_tempo à 1 et l'envoyer au module tempo pour mesurer l'intervalde temps qui doit separer deux Trames DCC 
              if (Fin_Tempo = '1') then EF<=S1; end if; -- à la reception de fin_tempo ='1' du module tempo indiquat la fin de la mesure du temps necessaire la machine à etats passe à l'etat S1 pour charger une autre trame.
end case;

end process;

end Behavioral;