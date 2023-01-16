----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:06 01/13/2021 
-- Design Name: 
-- Module Name:    DecompressionLoop - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DecompressionLoop is
port(pause: in std_logic;
Input : in STD_LOGIC_VECTOR(511 downto 0);
Output : out STD_LOGIC_VECTOR(511 downto 0)
);

end DecompressionLoop;

architecture Behavioral of DecompressionLoop is
function to_bstring(sl : std_logic) return string is
  variable sl_str_v : string(1 to 3);  -- std_logic image with quotes around
begin
  sl_str_v := std_logic'image(sl);
  return "" & sl_str_v(2);  -- "" & character to get string
end function;

function to_bstring(slv : std_logic_vector) return string is
  alias    slv_norm : std_logic_vector(1 to slv'length) is slv;
  variable sl_str_v : string(1 to 1);  -- String of std_logic
  variable res_v    : string(1 to slv'length);
begin
  for idx in slv_norm'range loop
    sl_str_v := to_bstring(slv_norm(idx));
    res_v(idx) := sl_str_v(1);
  end loop;
  return res_v;
end function;

procedure shiftbyts(variable Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,byte : inout std_logic_vector(7 downto 0))   is
  
begin
   Reg7:= Reg6;
	Reg6:= Reg5;
	Reg5:= Reg4;
	Reg4:= Reg3;
	Reg3:= Reg2;
	Reg2:= Reg1;
	Reg1:= byte;
		report "reg1 " &integer'image(to_integer((unsigned(Reg1))));
	report "reg2 " &integer'image(to_integer((unsigned(Reg2))));
report "reg3 " &integer'image(to_integer((unsigned(Reg3))));
	report "reg4 " &integer'image(to_integer((unsigned(Reg4))));
	report "reg5 " &integer'image(to_integer((unsigned(Reg5))));
	report "reg6 " &integer'image(to_integer((unsigned(Reg6))));
	report "reg7 " &integer'image(to_integer((unsigned(Reg7))));
	report "    ";

end procedure ;

  

begin



process(Input,pause)
variable A :  STD_LOGIC_VECTOR(12 downto 0);
variable byte : STD_LOGIC_VECTOR(7 downto 0);
variable temp : std_logic_vector(7 downto 0);
variable temp2 : std_logic_vector(7 downto 0);
variable temp3 : std_logic_vector(7 downto 0);
variable Lmax :  STD_LOGIC_VECTOR(1 downto 0);
variable Ip : STD_LOGIC_VECTOR (2 downto 0);
variable Reg1 : std_logic_vector (7 downto 0):= (others => '0');
variable Reg2,Reg3,Reg4,Reg5,Reg6,Reg7 : std_logic_vector (7 downto 0) := (others => '0');
variable Outputf :STD_LOGIC_VECTOR(511 downto 0):= (others => '0');
variable Inputf :STD_LOGIC_VECTOR( 831 downto 0):= (others => '0');

variable Inputparser : integer range 0 to 550;
variable Outputparser : integer range 0 to 511;
variable K : integer range 0 to 512;
variable L : integer range 0 to 512;

begin
--recives input  into inputf    as variable 	
Inputf (831 downto 320) := Input (511 downto 0);
if (pause = '0' ) then
Inputparser :=63;
Outputparser :=504;
-- loop until you reach 64 bits or until the output is full
for i in 0 to 63 loop
  if (Outputparser >0) then
  --input parser fills the A 13 bits by 13 bits till it is finished
   A:= Inputf(((Inputparser *13)+12) downto (Inputparser *13));
   report "A" &integer'image(to_integer(unsigned(A)));
   byte :=A(7 downto 0);
	Ip:=A(12 downto 10);
	Lmax:=A(9 downto 8);
	
	-- if the Ip abd lmax =0 sjip the condition and add the byte directly to the output and the window
	--else according to the ip and lmax fill the output and shift the window
	--input and output parsers start from 511 till zero moving the correct amount of ints every time 
   if (not(Ip ="000" and Lmax = "00")) then
	  if (Ip = "001")then -- I.e the Ip is 1 so we take the value from reg1 and add it to the window and output
	 if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
    Output(Outputparser+7 downto Outputparser) <=Reg1;
	 Outputf(Outputparser+7 downto Outputparser) :=Reg1;
	 Outputparser:=Outputparser -8;
	 temp:=Reg1;
	 shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);--is a procedure that shifts a byte into the registers and throws the last byte
	 report "1";
	 
     elsif(Ip = "010")then
     report "2";
        if (Lmax ="01")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
	        Output(Outputparser+7 downto Outputparser) <=Reg2;
			  Outputf(Outputparser+7 downto Outputparser) :=Reg2;
			 
	        Outputparser:=Outputparser -8;	 
           temp:=Reg2;			  
	        shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);
        elsif(Lmax ="10")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		      Output(Outputparser+7 downto Outputparser) <=Reg2;
		     Outputf(Outputparser+7 downto Outputparser) :=Reg2;
		  
	       Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
	 Output(Outputparser+7 downto Outputparser) <=Reg1;
	 Outputf(Outputparser+7 downto Outputparser) :=Reg1;
	 
	 Outputparser:=Outputparser -8;
	            temp:=Reg2;
               temp2:=Reg1;					
	 shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);
	            			  
	 shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);
        end if ;
     elsif(Ip = "011")then
	   report "3";
        if (Lmax ="01")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		      Output(Outputparser+7 downto Outputparser) <=Reg3;
				Outputf(Outputparser+7 downto Outputparser) :=Reg3;
				           temp:=Reg3;			  
				shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);
	         Outputparser:=Outputparser -8;
				report "1LL";
        elsif(Lmax ="10")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
	   	  Output(Outputparser+7 downto Outputparser) <=Reg3;
			  Outputf(Outputparser+7 downto Outputparser) :=Reg3;
			  
	        Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
	        Output(Outputparser+7 downto Outputparser) <=Reg2;
			  Outputf(Outputparser+7 downto Outputparser) :=Reg2;
			  
	        Outputparser:=Outputparser -8;
			  temp:=Reg3;
			  temp2:=Reg2;
			  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

			  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);
			  
			  report "2LL";
        elsif (Lmax ="11")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
	    	  Output(Outputparser+7 downto Outputparser) <=Reg3;
			  Outputf(Outputparser+7 downto Outputparser) :=Reg3;
			  
	        Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
	        Output(Outputparser+7 downto Outputparser) <=Reg2;
			  Outputf(Outputparser+7 downto Outputparser) :=Reg2;
			  
	        Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
      	  Output(Outputparser+7 downto Outputparser) <=Reg1;
			  Outputf(Outputparser+7 downto Outputparser) :=Reg1;
			  
	        Outputparser:=Outputparser -8;
			  temp:=Reg3;
			  temp2:=Reg2;
			  temp3:=Reg1;
			  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

			  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);

			  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp3);
			report "3LL";
        end if ;
		  
     elsif(Ip = "100")then
	  report "4";
        if (Lmax ="01")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  Output(Outputparser+7 downto Outputparser) <=Reg4;
		  Outputf(Outputparser+7 downto Outputparser) :=Reg4;
		  
	     Outputparser:=Outputparser -8;
		  temp:=Reg4;
		  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);
        elsif(Lmax ="10")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  		  Output(Outputparser+7 downto Outputparser) <=Reg4;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg4;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  		  Output(Outputparser+7 downto Outputparser) <=Reg3;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg3;
				 
	           Outputparser:=Outputparser -8;
				  temp:=Reg4;
				  temp2:=Reg3;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

				   shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);
        elsif (Lmax ="11")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  		  Output(Outputparser+7 downto Outputparser) <=Reg4;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg4;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  		  Output(Outputparser+7 downto Outputparser) <=Reg3;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg3;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  		  Output(Outputparser+7 downto Outputparser) <=Reg2;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg2;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg4;
				  temp2:=Reg3;
				  temp3:=Reg2;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp3);
        end if ;
		  
     elsif(Ip = "101")then
	  report "5";
        if (Lmax ="01")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  		  Output(Outputparser+7 downto Outputparser) <=Reg5;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg5;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg5;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);
        elsif(Lmax ="10")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  		  Output(Outputparser+7 downto Outputparser) <=Reg5;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg5;
				 
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg4;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg4;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg5;
					temp2:=Reg4;
				   shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

					shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);
        elsif (Lmax ="11")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		  		  Output(Outputparser+7 downto Outputparser) <=Reg5;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg5;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg4;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg4;
				  
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg3;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg3;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg5;
				  temp2:=Reg4;
				  temp3:=Reg3;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp3);
        end if ;
		  
     elsif(Ip = "110")then
	  report "6";
	  report "Outputparser" &integer'image(Outputparser);
        if (Lmax ="01")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		        Output(Outputparser+7 downto Outputparser) <=Reg6;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg6;
				  temp:=Reg6;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);
				  
	           Outputparser:=Outputparser -8;
				  
        elsif(Lmax ="10")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		        Output(Outputparser+7 downto Outputparser) <=Reg6;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg6;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg5;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg5;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg6;
				  temp2:=Reg5;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);
        elsif (Lmax ="11")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		        Output(Outputparser+7 downto Outputparser) <=Reg6;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg6;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg5;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg5;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg4;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg4;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg6;
				  temp2:=Reg5;
				  temp3:=Reg4;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp3);
        end if ;
		  
     elsif(Ip = "111")then
	  report "7";
        if (Lmax ="01")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		        Output(Outputparser+7 downto Outputparser) <=Reg7;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg7;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg7;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);
				  
        elsif(Lmax ="10")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		        Output(Outputparser+7 downto Outputparser) <=Reg7;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg7;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg6;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg6;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg7;
              temp2:=Reg6;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);
        elsif (Lmax ="11")then
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
		        Output(Outputparser+7 downto Outputparser) <=Reg7;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg7;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg6;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg6;
				  
	           Outputparser:=Outputparser -8;
if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
				  Output(Outputparser+7 downto Outputparser) <=Reg5;
				  Outputf(Outputparser+7 downto Outputparser) :=Reg5;
				  
	           Outputparser:=Outputparser -8;
				  temp:=Reg7;
				  temp2:=Reg6;
				  temp3:=Reg5;
				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp2);

				  shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,temp3);
        end if ;
		  
   end if;
	
   end if ;
	if (Outputparser <0) then
	 Outputparser:= 0;
	 end if;
	
	--if ((Outputparser <= 511)) then
	-- adds the next byte into the output and decrements the output parser 
	Output(Outputparser+7 downto Outputparser) <=byte;
	Outputf(Outputparser+7 downto Outputparser) :=byte;
	Outputparser:=Outputparser -8;
	--end if;
	
	
	
	
	
	
	
--	Reg7:= Reg6;
--	Reg6:= Reg5;
--	Reg5:= Reg4;
--	Reg4:= Reg3;
--	Reg3:= Reg2;
--	Reg2:= Reg1;
--	Reg1:= byte;
	shiftbyts( Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,byte);
	report "Outputparser" &integer'image(Outputparser);
end if;	
Inputparser :=Inputparser -1;
report to_bstring(outputf);
end loop;
report to_bstring(outputf);
end if ;

end process;

end Behavioral;

