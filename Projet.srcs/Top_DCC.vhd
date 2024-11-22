library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Top_DCC is
    Port ( 
        -- Ports d'horloge et de réinitialisation
        CLK_100MHz : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Interrupteur	: in STD_LOGIC_VECTOR(7 downto 0);
        -- Sortie de la top module
        SORTIE_DCC : out STD_LOGIC
    );
end Top_DCC;

architecture Behavioral of Top_DCC is
    signal CLK_1MHz : STD_LOGIC;
    signal DCC_0_Reg ,DCC_1_Reg: STD_LOGIC;
    signal GO_0,GO_1: STD_LOGIC;
    signal FIN_0,FIN_1 :  STD_LOGIC;
    signal DCC_0,DCC_1:  STD_LOGIC;
   
    signal COM_REG :STD_LOGIC_VECTOR(1 downto 0);
    signal Trame_DCC :  STD_LOGIC_VECTOR(50 downto 0);
    signal OUT_DCC :  STD_LOGIC;
    signal FIN_DCC :  STD_LOGIC;  
    signal Fin_Tempo: STD_LOGIC;
    signal Start_Tempo: STD_LOGIC;

begin
   -- Instanciation du module MAE_GLOBALE
  MAE_GLOBALE : entity work.MAE_GLOBALE
        port map (
            CLK_100MHz => CLK_100MHz,
            Reset => Reset,
            FIN_0  => FIN_0,
            FIN_1  => FIN_1,
            Fin_Tempo  => Fin_Tempo,
            COM_REG => COM_REG,
            GO_0  => GO_0,
            GO_1  => GO_1,
            OUT_DCC => OUT_DCC,
            FIN_DCC => FIN_DCC,
            Start_Tempo  => Start_Tempo
        );
        
    -- Instanciation de DCC_BIT0
    DCC_BIT0_inst : entity work.DCC_BIT0
        port map (
            CLK_100MHz => CLK_100MHz,
            CLK_1MHz => CLK_1MHz,
            Reset => Reset,
            GO_0 => GO_0,
            FIN_0 => FIN_0,
            DCC_0=> DCC_0
        );
        
     -- Instanciation de DCC_BIT1
    DCC_BIT1_inst : entity work.DCC_BIT1
        port map (
            CLK_100MHz => CLK_100MHz,
            CLK_1MHz => CLK_1MHz,
            Reset => Reset,
            GO_1 => GO_1,
            FIN_1 => FIN_1,
            DCC_1 => DCC_1
        );

    -- Instanciation du module REGISTRE_DCC
    REGISTRE_DCC : entity work.REGISTRE_DCC
        port map (
            CLK_100MHz => CLK_100MHz,
            Reset => Reset,
            COM_REG => COM_REG,
            Trame_DCC => Trame_DCC,
            OUT_DCC => OUT_DCC,
            FIN_DCC => FIN_DCC
        );
        
     -- Instanciation du module COMPTEUR_TEMPO
     COMPTEUR_TEMPO : entity work.COMPTEUR_TEMPO
        port map (
           Clk  =>  CLK_100MHz,
           Reset  => Reset,
           Clk1M =>  CLK_1MHz,
           Start_Tempo  => 	Start_Tempo,
           Fin_Tempo => Fin_Tempo
           );
        
      -- Instanciation du module DCC_FRAME_GENERATOR
      DCC_FRAME_GENERATOR : entity work.DCC_FRAME_GENERATOR
        port map (
            Interrupteur => Interrupteur,
            Trame_DCC  => Trame_DCC
        );
        
      -- Instanciation du module CLK_DIV
      CLK_DIV : entity work.CLK_DIV
        port map (
           Reset => Reset,	
           Clk_In  => CLK_100MHz,	
           Clk_Out => CLK_1MHz	  
        );

    -- Traitement de la sortie SORTIE_DCC
process(CLK_1MHz)
  begin
    if rising_edge(CLK_1MHz) then
      DCC_0_Reg <= DCC_0;
      DCC_1_Reg <= DCC_1;
    end if;
  end process;

  -- Use the registered versions of DCC_0 and DCC_1 for the XOR operation
  SORTIE_DCC <= DCC_0_reg xor DCC_1_reg;
       

end Behavioral;

