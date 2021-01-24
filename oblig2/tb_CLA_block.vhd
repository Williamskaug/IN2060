library IEEE;
	use IEEE.STD_LOGIC_1164.all;

entity tb_CLA_block is -- testbenkentiteter er normalt tomme.
--
end entity tb_CLA_block;

architecture behavioral of tb_CLA_block is
 -- en komponent er en entitet definert i en annen fil, og som vi vil bruke.
 -- komponentdeklarasjonen må matche entiteten.
	component CLA_block is
		port(
			a : in std_logic_vector(3 downto 0);
			b : in std_logic_vector(3 downto 0);
			cin : in std_logic;
			s 	: out std_logic_vector(3 downto 0);
			cout : out std_logic
		);
 	end component;
 
	-- Tilordning av startverdi ved deklarasjon gjøres med :=
 	signal tb_cin : std_logic := '0';
	signal tb_a : std_logic_vector(3 downto 0) := (others => '0');
	signal tb_b : std_logic_vector(3 downto 0) := (others => '0');

	-- outputs bør ikke få en startverdi i testbenken, da det kan maskere feil.
 	signal tb_cout : std_logic;
	signal tb_s : std_logic_vector(3 downto 0);

begin
	-- instansiering:
	DUT: CLA_block -- Merkelappen DUT betyr «device under test» som er en av mange
	port map( -- vanlige betegnelser på simuleringsobjektet.
	a => tb_a, -- Mappinger gjøres med =>, til forskjell fra tilordninger som
	b => tb_b, -- bruker <= eller :=
	cin => tb_cin, -- Mappinger kan ses på en ren sammenkobling av ledninger
 	s => tb_s, -- Vi mapper alltid testenhetens porter til testbenkens signaler
 	cout => tb_cout -- Siste informasjon før parantes-slutt har ikke ',' eller ';'
);
 	-- I testbenker kan vi ha prosesser uten sensitivitetsliste..
 	-- i slike prosesser kan vi angi tid med «wait» statements, og
 	-- vi kan sette signaler flere ganger etter hverandre uten å gi konflikter.
 	-- NB: Prosessen vil trigges om og om igjen om vi ikke hindrer det.
 process

begin
--1
	wait for 10 ns;
 	tb_a <= "0000";
 	tb_b <= "0000";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_cout = '0') report ("1. tb_cout er ikke riktig") severity failure;
	assert(tb_s = "0000") report ("1. tb_s er ikke riktig") severity failure;

--2
	wait for 10 ns;
 	tb_a <= "0001";
 	tb_b <= "0001";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_cout = '0') report ("2. tb_cout er ikke riktig") severity failure;
 	assert(tb_s = "0010") report ("2. tb_s er ikke riktig") severity failure;

--3
	wait for 10 ns;
 	tb_a <= "1101";
 	tb_b <= "0010";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_cout = '0') report ("3. tb_cout er ikke riktig") severity failure;
 	assert(tb_s = "1111") report ("3. tb_s er ikke riktig") severity failure;

--4
	wait for 10 ns;
 	tb_a <= "1100";
 	tb_b <= "1001";
 	tb_cin <= '1';
	wait for 10 ns;
	assert(tb_cout = '1') report ("4. tb_cout er ikke riktig") severity failure;
 	assert(tb_s = "0110") report ("4. tb_s er ikke riktig") severity failure;

--5
	wait for 10 ns;
 	tb_a <= "1111";
 	tb_b <= "0000";
 	tb_cin <= '1';
	wait for 10 ns;
	assert(tb_cout = '1') report ("5. tb_cout er ikke riktig") severity failure;
 	assert(tb_s = "0000") report ("5. tb_s er ikke riktig") severity failure;

--6
	wait for 10 ns;
 	tb_a <= "1010";
 	tb_b <= "1001";
 	tb_cin <= '0';
	wait for 10 ns;
	assert(tb_cout = '1') report ("6. tb_cout er ikke riktig") severity failure;
 	assert(tb_s = "0011") report ("6. tb_s er ikke riktig") severity failure;

--7
	wait for 10 ns;
 	tb_a <= "0001";
 	tb_b <= "1000";
 	tb_cin <= '1';
	wait for 10 ns;
	assert(tb_cout = '0') report ("7. tb_cout er ikke riktig") severity failure;
 	assert(tb_s = "1010") report ("7. tb_s er ikke riktig") severity failure;


	report("Testen foregikk feilfritt!") severity note;
	std.env.stop; -- stopper simuleringen
end process;
end architecture behavioral;