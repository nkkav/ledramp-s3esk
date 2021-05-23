library IEEE, STD;
use STD.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_1164.all;


entity ledramp_tb is
end ledramp_tb;


architecture tb_arch of ledramp_tb is

  -- UUT component
  component ledramp
    generic (
      PWM_RANGE_MAX : integer := 5000000
    );
    port (
      clk  : in  std_logic;
      ramp : out std_logic_vector(7 downto 0)
    );
  end component;
  -- I/O signals
  signal clk   : std_logic := '0';
  signal ramp  : std_logic_vector(7 downto 0);
  -- Constant declarations
  constant CLK_PERIOD : time := 20 ns;
  -- Declare results file
  file ResultsFile: text open write_mode is "ledramp_results.txt";

begin

  uut : ledramp
    generic map (
      PWM_RANGE_MAX => 1000
    )
    port map (
      clk   => clk,
      ramp  => ramp
    );

  CLK_GEN_PROC: process(clk)
  begin
    if (clk = '0') then
      clk <= '1';
    else
      clk <= not clk after CLK_PERIOD/2;
    end if;
  end process CLK_GEN_PROC;

  process (clk)
    variable line_el: line;
    variable ramp_ext : std_logic_vector(7 downto 0);
  begin
    if rising_edge(clk) then
      -- Write the time
      write(line_el, now);   -- write the line
      write(line_el, ':');   -- write the line

      -- Write the ramp signal
      write(line_el, ' ');
      write(line_el, ramp);  -- write the line

      writeline(ResultsFile, line_el); -- write the contents into the file
    end if;
  end process;

end tb_arch;

