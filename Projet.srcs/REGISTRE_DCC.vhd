library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity REGISTRE_DCC is
    Port (  CLK_100MHz: in STD_LOGIC;	
            Reset	: in STD_LOGIC;
            COM_REG	: in STD_LOGIC_VECTOR(1 downto 0):="00";	
            Trame_DCC	: in STD_LOGIC_VECTOR(50 downto 0);	
            OUT_DCC	: out STD_LOGIC; --le bit de sortie envoyé à la machine à états
            FIN_DCC	: out STD_LOGIC  --fin de la trame pour qu'il charge une nvl
    
            
           );           
end REGISTRE_DCC;
architecture Behavioral of REGISTRE_DCC is   
signal reg : std_logic_vector(50 downto 0) := (others => '0');
begin
   OUT_DCC <= reg(50); -- le bit à la sortie du registre_dcc
   process(CLK_100MHz,Reset)
    begin
        if Reset='1' then reg<=(others => '0'); -- RAZ ASYNCHRONE
        elsif rising_edge(CLK_100MHz) then
            case (COM_REG) is
                when "01" => reg <= Trame_DCC;  --chargement parallele et initialisation
                when "10" => reg <= reg(49 downto 0) & '0';  --decalage
                when others => reg <= reg; -- maintien de la valeur ;   
                           
             end case; 

         end if;

    end process;

    FIN_DCC <= '1' when reg = "000" & x"000000000000" else '0'; --mettre fin_dcc à 1 pour indiquer la fin de la trame si tous les bits de reg sont à 0 si non fin_dcc est à0
end Behavioral;



