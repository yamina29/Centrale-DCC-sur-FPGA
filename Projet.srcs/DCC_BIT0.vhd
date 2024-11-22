library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DCC_BIT0 is 
 port( CLK_100MHz , CLK_1MHZ , Reset: in std_logic;
       GO_0: in std_logic;
       FIN_0: out std_logic;
       DCC_0: out std_logic);
end DCC_BIT0;

architecture behavioral of DCC_BIT0 is
signal compt : integer range 0 to 201:=0;
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
   if (compt=199)then compt<=0;end if;
   end if;
end if;   
end process;   

--Machine à etats
process(CLK_100MHz , Reset)
begin 
if reset='1' then EP<= S0;
elsif rising_edge(CLK_100MHz) then EP<=EF;
end if;
end process;
process(compt,GO_0,EP)
begin 
case EP is 
when S0 => EF<=S0;
           DCC_0<='0';-- à l'etats S0 la sortie du module est mise à 0
           FIN_0<='0';
           if GO_0='1' then EF<=S1; -- si go_0 est à 1 la machine à etats passe à l'états S1
           end if;
when S1 => EF<=S1;
           DCC_0<='0'; --generation d'une impulsion à 0 pendant 100 us
          if compt=100 then EF<=S2;
          end if;
when S2 => EF<=S2;
          DCC_0<='1'; -- generation d'une impulsion à 1 pendant 100 us
          if compt=0 then EF<=S3;
          end if;   
when S3 => DCC_0<='0'; -- remise à zero de la sortie 
           FIN_0<='1'; -- mettre Fin_0 à 1 pour indiquer la fin de la generation d'un bit
           EF<=S0;          
end case;         
end process;
end;   
       