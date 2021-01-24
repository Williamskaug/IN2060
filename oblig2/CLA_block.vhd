library IEEE; -- bibliotek
	use IEEE.STD_LOGIC_1164.all; -- pakke

-- CLA block
entity CLA_block is
	port(
	a, b : in std_logic_vector(3 downto 0);
	cin : in std_logic;
	s : out std_logic_vector(3 downto 0);
	cout : out std_logic
	);	
end entity CLA_block;

architecture mixed of CLA_block is

--Fulladder
component fulladder
	port(
	a, b, cin : in std_logic; -- inputs
	s : out std_logic; -- sum
	cout: out std_logic -- carry
	);
end component;

	signal c : std_logic_vector(4 downto 0);
	signal p : std_logic_vector(3 downto 0);
	signal p30 : std_logic;
	signal g : std_logic_vector(3 downto 0);
	signal g30 : std_logic;


begin
	p <= a or b;
	g <= a and b;
	p30 <= p(0) and p(1) and p(2) and p(3);
	g30 <= ( ( ( ( ( (g(0) and p(1)) or g(1)) and p(2)) or g(2)) and p(3)) or g(3));
	cout <= ((p30 and cin) or g30);

	c(0) <= cin;

	u0 : fulladder
	port map (
	a => a(0),
	b => b(0),
	cin => c(0),
	s => s(0),
	cout => c(1)
	);

	u1 : fulladder
	port map (
	a => a(1),
	b => b(1),
	cin => c(1),
	s => s(1),
    cout => c(2)
	);

	u2 : fulladder
	port map (
	a => a(2),
	b => b(2),
	cin => c(2),
	s => s(2),
	cout => c(3)
	);

	u3 : fulladder
	port map (
	a => a(3),
	b => b(3),
	cin => c(3),
	s => s(3),
	cout => c(4)
	);
end architecture mixed;
