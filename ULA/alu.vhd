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
	
	process(op, A, B)
		begin
			case op is
			  -- add
			  when "0000" => result <= std_logic_vector(signed(A) + signed(B)); 
			  
			  -- sub
			  when "0001" => result <= std_logic_vector(signed(A) - signed(B));
			  
			  -- sll
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