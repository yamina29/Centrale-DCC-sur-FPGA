library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DCC_BIT1 is 
 port( CLK_100MHz , CLK_1MHZ , Reset: in std_logic;
       GO_1: in std_logic;
       FIN_1: out std_logic;
       DCC_1: out std_logic);
end DCC_BIT1;

architecture behavioral of DCC_BIT1 is
signal compt : integer range 0 to 117:=0;
type etat is (S0 , S1, S2 ,S3);
signal EP, EF : etat;
begin
--compteur pour la durée des impulsions 
process(CLK_1MHz , Reset)
begin
if Reset='1' then compt <=0;
elsif rising_edge(CLK_1MHz) then
   if (EP=S1) or (EP=S2) then 
   compt<= compt+1;
   if (compt=115)then compt<=0;end if;
   end if;
end if;   
end process;   
--Machine à états 
process(CLK_100MHz , Reset)
begin 
if reset='1' then EP<= S0;
elsif rising_edge(CLK_100MHz) then EP<=EF;
end if;
end process;
process(compt,GO_1,EP)
begin 

case EP is 
when S0 => EF<=S0;
           DCC_1<='0'; -- à l'etats S0 la sortie du module est mise à 0
           FIN_1<='0'; 
           if GO_1='1' then EF<=S1; -- si go_1 est à 1 la machine à etats passe à l'états S1
           end if;
when S1 => EF<=S1;
           DCC_1<='0'; --generation d'une impulsion à 0 pendant 58 us
          if compt=58 then EF<=S2;
          end if;
when S2 => EF<=S2; 
          DCC_1<='1'; -- generation d'une impulsion à 1 pendant 58 us
          if compt=0 then EF<=S3;
          end if;   
when S3 => DCC_1<='0'; -- remise à zero de la sortie 
           FIN_1<='1'; -- mettre Fin_1 à 1 pour indiquer la fin de la generation d'un bit
           EF<=S0;          
end case;         
end process;
end;