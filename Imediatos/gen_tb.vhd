library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_tb is
end gen_tb;

architecture gentb_arch of gen_tb is

	signal inst: std_logic_vector(31 downto 0);
	signal imm32: std_logic_vector(31 downto 0);

component genImm32
	port (
		inst: in std_logic_vector(31 downto 0);
		imm32: out std_logic_vector(31 downto 0)
	);
end component;

begin
	i1 : genImm32
	port map(
		inst => inst,
		imm32 => imm32
	);
	process
		begin
			-- testes propostos na especificaçao
		
			-- resultado esperado: 0
			inst <= X"000002b3";
			wait for 4 ps;
			
			-- resultado esperado: 16
			inst <= X"01002283";
			wait for 4 ps;
			
			-- resultado esperado: -100
			inst <= X"f9c00313";
			wait for 4 ps;
			
			-- resultado esperado: -1
			inst <= X"fff2c293";
			wait for 4 ps;
			
			-- resultado esperado: 354
			inst <= X"16200313";
			wait for 4 ps;
			
			-- resultado esperado: 0x18 / 24
			inst <= X"01800067";
			wait for 4 ps;
			
			-- resultado esperado: 0x2000
			inst <= X"00002437";
			wait for 4 ps;
			
			-- resultado esperado: 60
			inst <= X"02542e23";
			wait for 4 ps;
			
			-- resultado esperado: -32
			inst <= X"fe5290e3";
			wait for 4 ps;
			
			-- resultado esperado: 0xC / 12
			inst <= X"00c000ef";
			wait for 4 ps;
	end process;
end gentb_arch;