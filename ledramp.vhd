-- Original source:
-- http://www.avrfreaks.net/index.php?name=PNphpBB2&file=printview&t=54866&start=40
-- by user "buserror"
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity ledramp is
  port (
    clk  : in  std_logic;
    ramp : out std_logic_vector(7 downto 0)
  );
end ledramp;


architecture behavioral of ledramp is
  --
  -- Type declarations
  type state_type is (PULSE, SHIFT);
  type pwm_range is range 0 to 5000000;
  --
  -- Constant declarations
  constant pwm_max : pwm_range := 5000000;
  --
  -- Signal declarations
  signal state : state_type := PULSE;
  --
begin

  process (clk)
    --
    -- Variable declarations
    variable up        : std_logic_vector(7 downto 0) := "00000001";
    variable direction : std_logic := '0';
    variable mark      : pwm_range := 0;
    --
  begin
    if (rising_edge(clk)) then
      case state is
        when PULSE =>
          ramp <= up;
          --
          mark := mark + 1;
          --
          if (mark = pwm_max) then
            state <= SHIFT;
            mark := 0;
          end if;
          --
        when SHIFT =>
          if (direction = '0') then
            if (up = "10000000") then
              direction := '1';
              up := "01000000";
            else
              up := up(6 downto 0) & up(7);
            end if;
          else
            if (up = "00000001") then
              direction := '0';
              up := "00000010";
            else
              up := up(0) & up(7 downto 1);
            end if;
          end if;
          --
          state <= PULSE;
          --
      end case;
    end if;
  end process;

end behavioral;
