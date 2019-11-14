library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	generic (DATA_WIDTH: natural := 32);
	
	port (
	A, B: in std_logic_vector(DATA_WIDTH-1 downto 0);
	op: in std_logic_vector(3 downto 0);
	result: out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end entity alu;

architecture alu of alu is

	begin
	
	-- Process é percorrido sempre que houver alterações em op, A ou B.
	process(op, A, B)
		begin
			-- Optamos por utilizar o switch case pela praticidade, as operações realizadas
			-- abaixo seguem o que foi demonstrado na especificação do trabalho.
			case op is
			  -- add
			  -- A função "signed" é usada aqui e em outras operações abaixo. Ela permite
			  -- que o sinal do número seja identificado.
			  when "0000" => result <= std_logic_vector(signed(A) + signed(B)); 
			  
			  -- sub
			  when "0001" => result <= std_logic_vector(signed(A) - signed(B));
			  
			  -- sll
			  -- Usamos a função "shift_left" que realiza o deslocamento para a esquerda,
			  -- "unsigned" que ignora o sinal e "to_integer" que identifica como inteiro.
			  -- Essas mesmas funções e variações, como "shift_right", são usadas em outros
			  -- casos abaixo.
			  when "0010" => result <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
			  
			  -- slt
			  when "0011" => if (signed(A) < signed(B)) then 
									result <= X"00000001";
			                 elsif (signed(A) > signed(B)) then
									result <= X"00000000";
								  end if;
			  
			  -- sltu
			  when "0100" => if (unsigned(A) < unsigned(B)) then 
									result <= X"00000001";
			                 elsif (unsigned(A) > unsigned(B)) then
									result <= X"00000000";
								  end if;
								  
			  -- xor
			  when "0101" => result <= A xor B;
			  
			  -- srl
			  when "0110" => result <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
			  
			  -- sra
			  when "0111" => result <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
			  
			  -- or
			  when "1000" => result <= A or B;
			 
			  -- and
			  when "1001" => result <= A and B;
			  
			  -- seq
			  when "1010" => if (A = B) then 
									result <= X"00000001";
			                 else
									result <= X"00000000";
								  end if;
			  
			  -- sne
			  when "1011" => if (A /= B) then 
									result <= X"00000001";
			                 else
									result <= X"00000000";
								  end if;
			  
			  -- sge
			  when "1100" => if (signed(A) >= signed(B)) then 
									result <= X"00000001";
			                 elsif (signed(A) < signed(B)) then
									result <= X"00000000";
								  end if;
			  
			  -- sgeu
			  when "1101" => if (unsigned(A) >= unsigned(B)) then 
									result <= X"00000001";
			                 elsif (unsigned(A) < unsigned(B)) then
									result <= X"00000000";
								  end if;
			  
			  -- se op for qualquer outro valor alu não faz nada
			  when others => null;
			end case;
	end process;
end alu;