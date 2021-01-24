library IEEE;
	use IEEE.STD_LOGIC_1164.all;

entity tb_CLA_top is -- testbenkentiteter er normalt tomme.
--
end entity tb_CLA_top;

architecture behavioral of tb_CLA_top is
 -- en komponent er en entitet definert i en annen fil, og som vi vil bruke.
 -- komponentdeklarasjonen m? matche entiteten.
	component CLA_top is
		port(
			a : in std_logic_vector(31 downto 0);
			b : in std_logic_vector(31 downto 0);
			cin : in std_logic;
			s 	: out std_logic_vector(31 downto 0);
			cout : out std_logic
		);
 	end component;

	-- Tilordning av startverdi ved deklarasjon gj?res med :=
 	signal tb_cin : std_logic := '0';
	signal tb_a : std_logic_vector(31 downto 0) := (others => '0');
	signal tb_b : std_logic_vector(31 downto 0) := (others => '0');

	-- outputs b?r ikke f? en startverdi i testbenken, da det kan maskere feil.
 	signal tb_cout : std_logic;
	signal tb_s : std_logic_vector(31 downto 0);

begin
	-- instansiering:
	DUT: CLA_top -- Merkelappen DUT betyr ?device under test? som er en av mange
	port map( -- vanlige betegnelser p? simuleringsobjektet.
	a => tb_a, -- Mappinger gj?res med =>, til forskjell fra tilordninger som
	b => tb_b, -- bruker <= eller :=
	cin => tb_cin, -- Mappinger kan ses p? en ren sammenkobling av ledninger
 	s => tb_s, -- Vi mapper alltid testenhetens porter til testbenkens signaler
 	cout => tb_cout -- Siste informasjon f?r parantes-slutt har ikke ',' eller ';'
);
 	-- I testbenker kan vi ha prosesser uten sensitivitetsliste..
 	-- i slike prosesser kan vi angi tid med ?wait? statements, og
 	-- vi kan sette signaler flere ganger etter hverandre uten ? gi konflikter.
 	-- NB: Prosessen vil trigges om og om igjen om vi ikke hindrer det.
process

begin
--1
	wait for 10 ns;
 	tb_a <= "00000000000000000000000000000001";
 	tb_b <= "00000000000000000000000000000001";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_s = "00000000000000000000000000000010") report ("1. tb_s er ikke riktig") severity failure;

--2
	wait for 10 ns;
 	tb_a <= "00000000000000000000000010101010";
 	tb_b <= "00000000000000000000000011001100";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_s = "00000000000000000000000101110110") report ("2. tb_s er ikke riktig") severity failure;
--3
	wait for 10 ns;
 	tb_a <= "00000000000000000000000010111110";
 	tb_b <= "00000000000000000000000011001100";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_s = "00000000000000000000000110001010") report ("3. tb_s er ikke riktig") severity failure;
--4
	wait for 10 ns;
 	tb_a <= "00000000000000000000000000001110";
 	tb_b <= "00000000000000000000000000000011";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_s = "00000000000000000000000000010001") report ("4. tb_s er ikke riktig") severity failure;
--5
	wait for 10 ns;
 	tb_a <= "00000000000000000000000000001100";
 	tb_b <= "00000000000000000000000000000011";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_s = "00000000000000000000000000001111") report ("5. tb_s er ikke riktig") severity failure;
--6
	wait for 10 ns;
 	tb_a <= "00000000000000000000000000000011";
 	tb_b <= "00000000000000000000000000001100";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_s = "00000000000000000000000000001111") report ("6. tb_s er ikke riktig") severity failure;
--7
  	wait for 10 ns;
   	tb_a <= "01000000000000000000000000000000";
   	tb_b <= "00100000000000000000000000000000";
   	tb_cin <= '0';
  	wait for 10 ns;
  	assert(tb_s = "01100000000000000000000000000000") report ("7. tb_s er ikke riktig") severity failure;
--8
  	wait for 10 ns;
   	tb_a <= "00000000000000000000000011111111";
   	tb_b <= "00000000000000000000000000000001";
   	tb_cin <= '0';
  	wait for 10 ns;
  	assert(tb_s = "00000000000000000000000100000000") report ("8. tb_s er ikke riktig") severity failure;
--9
  	wait for 10 ns;
   	tb_a <= "00000000000000000000000011111111";
   	tb_b <= "00000000000000000000000000000001";
   	tb_cin <= '0';
  	wait for 10 ns;
  	assert(tb_s = "01100000000000000000000100000000") report ("9. tb_s er ikke riktig") severity failure;
--10
  	wait for 10 ns;
   	tb_a <= "00000000000000000000000010111110";
   	tb_b <= "00000000000000000000000010111110";
   	tb_cin <= '0';
  	wait for 10 ns;
  	assert(tb_s = "0110000000000000000000010111110") report ("10. tb_s er ikke riktig") severity failure;


	report("Testen foregikk feilfritt!") severity note;
	std.env.stop; -- stopper simuleringen
end process;
end architecture behavioral;
