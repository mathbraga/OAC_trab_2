library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture alutb_arch of alu_tb is

	signal A: std_logic_vector(31 downto 0);
	signal B: std_logic_vector(31 downto 0);
	signal op: std_logic_vector(3 downto 0);
	signal result: std_logic_vector(31 downto 0);

component alu
	generic (DATA_WIDTH: natural := 32);
	port (
		A, B: in std_logic_vector(DATA_WIDTH-1 downto 0);
		op: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(DATA_WIDTH-1 downto 0)
	);
END COMPONENT;

BEGIN
	i1 : alu
	port map(
		A => A,
		B => B,
		op => op,
		result => result
	);
	process
		begin
			-- teste add -> 4 + 3 = 7
			A <= X"00000004"; B <= X"00000003"; op <= "0000";
			wait for 4 ps;
			
			-- teste sub -> 3 - 5 = -2
			A <= X"00000003"; B <= X"00000005"; op <= "0001";
			wait for 4 ps;
			
			-- teste sll
			A <= X"93000002"; B <= X"00000001"; op <= "0010";
			wait for 4 ps;
			
			-- teste slt
			A <= X"FFFFFFFE"; B <= X"00000002"; op <= "0011"; -- result = 1
			wait for 4 ps;
			A <= X"FFFFFFFF"; B <= X"FFFFFF9C"; op <= "0011"; -- result = 0
			wait for 4 ps;
			
			-- teste sltu
			A <= X"FFFFFFF9"; B <= X"00000002"; op <= "0100"; -- result = 0
			wait for 4 ps;
			A <= X"00000005"; B <= X"FFFFFF9C"; op <= "0100"; -- result = 1
			wait for 4 ps;
			
			-- teste xor
			A <= X"11111111"; B <= X"10011031"; op <= "0101";
			wait for 4 ps;
			
			-- teste srl (desloca para a direita e não preserva o sinal)
			A <= X"F0000000"; B <= X"00000002"; op <= "0110";
			wait for 4 ps;
			
			-- teste sra (desloca para a direita e preserva o sinal)
			A <= X"F0000000"; B <= X"00000002"; op <= "0111";
			wait for 4 ps;
			
			-- teste or
			A <= X"F00F0000"; B <= X"000F000F"; op <= "1000";
			wait for 4 ps;
			
			-- teste and
			A <= X"FFFFFFFF"; B <= X"200FF002"; op <= "1001";
			wait for 4 ps;
			
			--teste seq
			A <= X"0000FFFF"; B <= X"0000FFFF"; op <= "1010"; -- result = 1
			wait for 4 ps;
			A <= X"FF000000"; B <= X"00F00000"; op <= "1010"; -- result = 0
			wait for 4 ps;
			
			--teste sne
			A <= X"000FF000"; B <= X"000000AB"; op <= "1011"; -- result = 1
			wait for 4 ps;
			A <= X"FF000000"; B <= X"FF000000"; op <= "1011"; -- result = 0
			wait for 4 ps;
			
			--teste sge 
			A <= X"00000005"; B <= X"FF000002"; op <= "1100"; -- result = 1
			wait for 4 ps;
			A <= X"00000005"; B <= X"00000005"; op <= "1100"; -- result = 1
			wait for 4 ps;
			A <= X"FF000002"; B <= X"00000005"; op <= "1100"; -- result = 0
			wait for 4 ps;
			
			--teste sgeu
			A <= X"FFFF0000"; B <= X"0000FFFF"; op <= "1101"; -- result = 1
			wait for 4 ps;
			A <= X"0000FFFF"; B <= X"0000FFFF"; op <= "1101"; -- result = 1
			wait for 4 ps;
			A <= X"FFFF0000"; B <= X"FFFF00FF"; op <= "1101"; -- result = 0
			wait for 4 ps;
	end process;
end alutb_arch;
