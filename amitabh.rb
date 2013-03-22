r=0
i=0
j=0
count=0
print('Enter a string: ')
s1=gets()
print('Enter another string: ')
s2=gets()
n=s1.length
m=s2.length
n-=1
m-=1

for i in (0..n-1) do                                                      #a loop to traverse first string
	flag=0
	for j in (0..m-1) do                                    #a loop to traverse second string
		if (s1[i]==s2[j]) 
			loop do  
				if (a[r]==nil) 
					break
				end
				if (a[r]==s1[i])
					flag=1
					break
				end
				r++
				if (flag==1) 
					break
				else
					a[r]=s1[i]          #if alphabets are common they are stored in array a[ ] 
					count+=1
					break
				end
			                  #loop to check for common alphabets
			end
		end
	end
puts(count)
end