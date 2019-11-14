library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genImm32 is
	port (
		inst : in std_logic_vector(31 downto 0);
		imm32 : out std_logic_vector(31 downto 0)
	);
end entity genImm32;

architecture gen_arch of genImm32 is
	-- sinal que vai separar o OpCode da instrução
	signal op: std_logic_vector(6 downto 0);

	begin
	
	op <= inst(6 downto 0); -- op recebe a parte com o código da operação

	process(inst, op)
		begin
			-- Optamos por usar o switch case pela praticidade, em cada caso de OP,
			-- as operações realizam os passos explicados na especificação.
			case op is
				-- tipo R
				-- Imediato é zero
				when "0110011" => imm32 <= X"00000000";
				
				-- tipo I
				-- Aqui e em outras operações abaixo, usamos a função "resize" do numeric_std,
				-- que recebe uma sequência de bits e expande para o tamanho desejado passado
				-- no segundo parâmetro da função, extendendo o sinal por conta da função "signed".
				when "0000011" | "0010011" | "1100111" => 
					imm32 <= std_logic_vector(resize(signed(inst(31 downto 20)), inst'length));
				
				-- tipo S
				when "0100011" => 
					imm32 <= std_logic_vector(resize(signed(inst(31 downto 25) & inst(11 downto 7)), inst'length));
				
				-- tipo B
				when "1100011" => 
					imm32 <= std_logic_vector(resize(signed(inst(31) & inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0'), inst'length));
				
				-- tipo U
				when "0010111" | "0110111" => 
					imm32 <= inst(31 downto 12) & "000000000000";
				
				-- tipo J
				when "1101111" => 
					imm32 <= std_logic_vector(resize(signed(inst(31) & inst(19 downto 12) & inst(20) & inst(30 downto 21) & '0'), inst'length));
				
				-- Caso OP seja outro valor, não faz nada.
				when others => null;
			end case;
	end process;
end gen_arch;