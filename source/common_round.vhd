----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/12/21 23:28:21
-- Design Name: 
-- Module Name: common_round - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity common_round is
    port(
        round_in:in std_logic_vector(127 downto 0);
        key_in:in std_logic_vector(127 downto 0);
        round_out:out std_logic_vector(127 downto 0)
    );
end common_round;

architecture Behavioral of common_round is
    component subbytes
        Port (
            state_in:in std_logic_vector(127 downto 0);
            state_out:out std_logic_vector(127 downto 0)
        );
    end component;
    component shift_rows
        port(
            state_in: in std_logic_vector(127 downto 0);
            state_out: out std_logic_vector(127 downto 0)
        );
    end component;
    component mixclumn
        port(
            state_in:in std_logic_vector(127 downto 0);
            state_out: out std_logic_vector(127 downto 0)
        );
    end component;
    component addroundkey
        port(
            state_in:in std_logic_vector(127 downto 0);
            state_out:out std_logic_vector(127 downto 0);
            key:in std_logic_vector(127 downto 0)
        );
    end component;
    signal s1,s2,s3:std_logic_vector(127 downto 0);
begin
    Sub:subbytes port map(state_in=>round_in,state_out=>s1);
    Sft:shift_rows port map(state_in=>s1,state_out=>s2);
    Mx:mixclumn port map(state_in=>s2,state_out=>s3);
    Adk:addroundkey port map(state_in=>s3,state_out=>round_out,key=>key_in);
end Behavioral;
