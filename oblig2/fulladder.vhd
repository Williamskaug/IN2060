library IEEE; -- bibliotek
	use IEEE.STD_LOGIC_1164.all; -- pakke

entity fulladder is
	port(
	a, b, cin : in std_logic; -- inputs
	s : out std_logic; -- sum
	cout: out std_logic -- carry
	);
end entity fulladder;

architecture dataflow of fulladder is
begin
	s <= (a xor b) xor cin;
	cout <= ((a xor b) and cin) or (a and b);
end architecture dataflow;