----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/12/19 20:47:27
-- Design Name: 
-- Module Name: aes_encryptor - Behavioral
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

entity aes_encryptor is
    generic(n:integer:=128);
    port(
        clk,run:in std_logic;
        input_text:in std_logic_vector(127 downto 0);
        key:in std_logic_vector(n-1 downto 0);
        output_text:out std_logic_vector(127 downto 0);
        done:out std_logic
    );
end aes_encryptor;
architecture Behavioral of aes_encryptor is
    component common_round
        port(
            round_in:in std_logic_vector(127 downto 0);
            key_in:in std_logic_vector(127 downto 0);
            round_out:out std_logic_vector(127 downto 0)
        );
    end component;
    component common_last_round
        port(
            round_in:in std_logic_vector(127 downto 0);
            key_in:in std_logic_vector(127 downto 0);
            round_out:out std_logic_vector(127 downto 0)
        );
    end component;
    component kexp256
        port(
            key:in std_logic_vector(n-1 downto 0);
            k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14:out std_logic_vector(127 downto 0)
        );
    end component;
    component kexp192
        port(
            key:in std_logic_vector(n-1 downto 0);
            k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12:out std_logic_vector(127 downto 0)
        );
    end component;
    component kexp128
        port(
            key:in std_logic_vector(n-1 downto 0);
            k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10:out std_logic_vector(127 downto 0)
        );
    end component;
    signal cnt:integer:=0;
    signal k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11,k12,k13,k14:std_logic_vector(127 downto 0);
    signal s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14:std_logic_vector(127 downto 0);
begin
aes128:if n=128 generate
    R1:common_round port map(round_in=>s0,round_out=>s1,key_in=>k1);
    R2:common_round port map(round_in=>s1,round_out=>s2,key_in=>k2);
    R3:common_round port map(round_in=>s2,round_out=>s3,key_in=>k3);
    R4:common_round port map(round_in=>s3,round_out=>s4,key_in=>k4);
    R5:common_round port map(round_in=>s4,round_out=>s5,key_in=>k5);
    R6:common_round port map(round_in=>s5,round_out=>s6,key_in=>k6);
    R7:common_round port map(round_in=>s6,round_out=>s7,key_in=>k7);
    R8:common_round port map(round_in=>s7,round_out=>s8,key_in=>k8);
    R9:common_round port map(round_in=>s8,round_out=>s9,key_in=>k9);
    R10:common_last_round port map(round_in=>s9,round_out=>s10,key_in=>k10);
    Keyexp:kexp128 port map(key=>key,k0=>k0,k1=>k1,k2=>k2,k3=>k3,k4=>k4,k5=>k5,k6=>k6,k7=>k7,k8=>k8,k9=>k9,k10=>k10);
    s0<=input_text xor k0;
    process(clk,run)
    begin
        if run='0' then
            output_text<=(others=>'0');
            done<='0';
            cnt<=0;
        elsif rising_edge(clk) then
            cnt<=cnt+1;
            if cnt=1 then
                done<='1';
                cnt<=0;
                output_text<=s10;
            end if;
        end if;
    end process;
end generate;

-- 256 bits
aes256:if n=256 generate
    R1:common_round port map(round_in=>s0,round_out=>s1,key_in=>k1);
    R2:common_round port map(round_in=>s1,round_out=>s2,key_in=>k2);
    R3:common_round port map(round_in=>s2,round_out=>s3,key_in=>k3);
    R4:common_round port map(round_in=>s3,round_out=>s4,key_in=>k4);
    R5:common_round port map(round_in=>s4,round_out=>s5,key_in=>k5);
    R6:common_round port map(round_in=>s5,round_out=>s6,key_in=>k6);
    R7:common_round port map(round_in=>s6,round_out=>s7,key_in=>k7);
    R8:common_round port map(round_in=>s7,round_out=>s8,key_in=>k8);
    R9:common_round port map(round_in=>s8,round_out=>s9,key_in=>k9);
    R10:common_round port map(round_in=>s9,round_out=>s10,key_in=>k10);
    R11:common_round port map(round_in=>s10,round_out=>s11,key_in=>k11);
    R12:common_round port map(round_in=>s11,round_out=>s12,key_in=>k12);
    R13:common_round port map(round_in=>s12,round_out=>s13,key_in=>k13);
    R14:common_last_round port map(round_in=>s13,round_out=>s14,key_in=>k14);
    Keyexp:kexp256 port map(key=>key,k0=>k0,k1=>k1,k2=>k2,k3=>k3,k4=>k4,k5=>k5,k6=>k6,k7=>k7,k8=>k8,k9=>k9,k10=>k10,k11=>k11,k12=>k12,k13=>k13,k14=>k14);
    s0<=input_text xor k0;
    process(clk,run)
    begin
        if run='0' then
            output_text<=(others=>'0');
            done<='0';
            cnt<=0;
        elsif rising_edge(clk) then
            cnt<=cnt+1;
            if cnt=1 then
                done<='1';
                cnt<=0;
                output_text<=s14;
            end if;
        end if;
    end process;
end generate;

-- 192 bits
aes192:if n=192 generate
    R1:common_round port map(round_in=>s0,round_out=>s1,key_in=>k1);
    R2:common_round port map(round_in=>s1,round_out=>s2,key_in=>k2);
    R3:common_round port map(round_in=>s2,round_out=>s3,key_in=>k3);
    R4:common_round port map(round_in=>s3,round_out=>s4,key_in=>k4);
    R5:common_round port map(round_in=>s4,round_out=>s5,key_in=>k5);
    R6:common_round port map(round_in=>s5,round_out=>s6,key_in=>k6);
    R7:common_round port map(round_in=>s6,round_out=>s7,key_in=>k7);
    R8:common_round port map(round_in=>s7,round_out=>s8,key_in=>k8);
    R9:common_round port map(round_in=>s8,round_out=>s9,key_in=>k9);
    R10:common_round port map(round_in=>s9,round_out=>s10,key_in=>k10);
    R11:common_round port map(round_in=>s10,round_out=>s11,key_in=>k11);
    R12:common_last_round port map(round_in=>s11,round_out=>s12,key_in=>k12);
    Keyexp:kexp192 port map(key=>key,k0=>k0,k1=>k1,k2=>k2,k3=>k3,k4=>k4,k5=>k5,k6=>k6,k7=>k7,k8=>k8,k9=>k9,k10=>k10,k11=>k11,k12=>k12);
    s0<=input_text xor k0;
    process(clk,run)
    begin
        if run='0' then
            output_text<=(others=>'0');
            done<='0';
            cnt<=0;
        elsif rising_edge(clk) then
            cnt<=cnt+1;
            if cnt=1 then
                done<='1';
                cnt<=0;
                output_text<=s12;
            end if;
        end if;
    end process;
end generate;
end Behavioral;
