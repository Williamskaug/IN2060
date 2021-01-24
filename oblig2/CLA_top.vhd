library IEEE; -- bibliotek
	use IEEE.STD_LOGIC_1164.all; -- pakke

-- CLA_top
entity CLA_top is
	generic(
 		width : positive := 32
 	);

 	port(
 		a, b : in std_logic_vector(width-1 downto 0);
 		cin : in std_logic;
 		s : out std_logic_vector(width-1 downto 0);
 		cout : out std_logic
 	);
end entity CLA_top;

architecture mixed of CLA_top is

--CLA_block
component CLA_block
	port(
	a, b : in std_logic_vector(3 downto 0); -- inputs
	cin : in std_logic;
	s : out std_logic_vector(3 downto 0); -- sum
	cout: out std_logic -- carry
	);
end component;

	signal carry : std_logic_vector(8 downto 0);

begin

	carry(0) <= cin;

port_map_lokke: for i in 0 to 7 generate

	u1 : CLA_block
	port map(
	a => a(i+3 downto i),
	b => b(i+3 downto i),
	cin => carry(i),
	s => s(i+3 downto i),
	cout => carry(i+1)
	);
	end generate;
	cout <= carry(8);
end architecture mixed;
