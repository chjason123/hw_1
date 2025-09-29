library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_two_counter is
end tb_two_counter;

architecture behavior of tb_two_counter is

    -- �ŧi�ݴ�����
    component two_counter
        generic (
            count1_min_in : std_logic_vector(7 downto 0) := "00000001";
            count1_max_in : std_logic_vector(7 downto 0) := "00000011"; -- ���դ�K�A�]�̤j�Ȭ�3
            count2_min_in : std_logic_vector(7 downto 0) := "00000001";
            count2_max_in : std_logic_vector(7 downto 0) := "00000010"  -- ���դ�K�A�]�̤j�Ȭ�2
        );
        port (
            rst      : in  std_logic;
            clk      : in  std_logic;
			count1_set      : in  std_logic;
			count2_set      : in  std_logic;
            count1_o : out std_logic_vector(7 downto 0);
            count2_o : out std_logic_vector(7 downto 0)
        );
    end component;

    -- ���հT��
    signal rst      : std_logic := '0';
    signal clk      : std_logic := '0';
	signal count1_set      : std_logic := '1';
	signal count2_set      : std_logic := '0';
    signal count1_o : std_logic_vector(7 downto 0);
    signal count2_o : std_logic_vector(7 downto 0);

begin

    -- �Ҥ� DUT
    uut: two_counter
        generic map (
            count1_min_in => std_logic_vector(to_unsigned(0, 8)),
            count1_max_in => std_logic_vector(to_unsigned(9, 8)), -- 3
            count2_min_in => std_logic_vector(to_unsigned(79, 8)),
            count2_max_in => std_logic_vector(to_unsigned(253, 8))  -- 2
        )
        port map (
            rst      => rst,
            clk      => clk,
            count1_set => count1_set,
            count2_set => count2_set,
            count1_o => count1_o,
            count2_o => count2_o
        );

    -- ���ͮɯ�
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;

    -- ���լy�{
    stim_proc: process
    begin
        -- ��l��
        rst <= '0';
        wait for 30 ns;
        rst <= '1';
        wait for 20 ns;
        
  
        -- ���p�ƾ�����B�@
        wait for 200 ns;
        -- ��������
        wait;
    end process;

end behavior;