----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/12/10 15:47:10
-- Design Name: 
-- Module Name: mixclumn - Behavioral
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
library work;
use work.util_package.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mixclumn is
    port(
        state_in:in std_logic_vector(127 downto 0);
        state_out: out std_logic_vector(127 downto 0)
    );
end mixclumn;

architecture Behavioral of mixclumn is
    type state is array(3 downto 0,3 downto 0) of std_logic_vector(7 downto 0);
    signal s_in:state;
    signal s_out:state;
begin
    s_in_x:for j in 3 downto 0 generate
        s_in_y:for k in 3 downto 0 generate
            s_in(j,k)<=state_in(((3-k)*4+(4-j))*8-1 downto ((3-k)*4+(3-j))*8);
        end generate;
    end generate;
    s_out_x:for j in 3 downto 0 generate
        s_out_y:for k in 3 downto 0 generate
            state_out(((3-k)*4+(4-j))*8-1 downto ((3-k)*4+(3-j))*8)<=s_out(j,k);
        end generate;
    end generate;
    
s_out(0,0)<=mtp2(s_in(0,0)) xor (mtp2(s_in(1,0)) xor s_in(1,0)) xor s_in(2,0) xor s_in(3,0);
s_out(0,1)<=mtp2(s_in(0,1)) xor (mtp2(s_in(1,1)) xor s_in(1,1)) xor s_in(2,1) xor s_in(3,1);
s_out(0,2)<=mtp2(s_in(0,2)) xor (mtp2(s_in(1,2)) xor s_in(1,2)) xor s_in(2,2) xor s_in(3,2);
s_out(0,3)<=mtp2(s_in(0,3)) xor (mtp2(s_in(1,3)) xor s_in(1,3)) xor s_in(2,3) xor s_in(3,3);

s_out(1,0)<=s_in(0,0) xor mtp2(s_in(1,0)) xor (mtp2(s_in(2,0)) xor s_in(2,0)) xor s_in(3,0);
s_out(1,1)<=s_in(0,1) xor mtp2(s_in(1,1)) xor (mtp2(s_in(2,1)) xor s_in(2,1)) xor s_in(3,1);
s_out(1,2)<=s_in(0,2) xor mtp2(s_in(1,2)) xor (mtp2(s_in(2,2)) xor s_in(2,2)) xor s_in(3,2);
s_out(1,3)<=s_in(0,3) xor mtp2(s_in(1,3)) xor (mtp2(s_in(2,3)) xor s_in(2,3)) xor s_in(3,3);

s_out(2,0)<=s_in(0,0) xor s_in(1,0) xor mtp2(s_in(2,0)) xor (mtp2(s_in(3,0)) xor s_in(3,0));
s_out(2,1)<=s_in(0,1) xor s_in(1,1) xor mtp2(s_in(2,1)) xor (mtp2(s_in(3,1)) xor s_in(3,1));
s_out(2,2)<=s_in(0,2) xor s_in(1,2) xor mtp2(s_in(2,2)) xor (mtp2(s_in(3,2)) xor s_in(3,2));
s_out(2,3)<=s_in(0,3) xor s_in(1,3) xor mtp2(s_in(2,3)) xor (mtp2(s_in(3,3)) xor s_in(3,3));

s_out(3,0)<=(mtp2(s_in(0,0)) xor s_in(0,0)) xor s_in(1,0) xor s_in(2,0) xor mtp2(s_in(3,0));
s_out(3,1)<=(mtp2(s_in(0,1)) xor s_in(0,1)) xor s_in(1,1) xor s_in(2,1) xor mtp2(s_in(3,1));
s_out(3,2)<=(mtp2(s_in(0,2)) xor s_in(0,2)) xor s_in(1,2) xor s_in(2,2) xor mtp2(s_in(3,2));
s_out(3,3)<=(mtp2(s_in(0,3)) xor s_in(0,3)) xor s_in(1,3) xor s_in(2,3) xor mtp2(s_in(3,3));
end Behavioral;
