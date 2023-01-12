# hash
- .stringify_keys # provided by 'rails' gem
- .invert # swaps keys/values
- setting new values 

# string 
- .delete , .delete! # immutable, mutable(destructive)
- .sub #substitutes first occurence 
- .gsub #global subsitute  - substitutes all occurences 

# integer 
- .to_f # to float (decimal)
- .zero? # is the number a zero
- .even? #} can only be used with integers
- .odd?  #} not available to use in float class

# float (decimals) 
- .to_i # to integer 
- .round 
- .ceil # force it to round up. eg. Number of ppl on a plane != 5.2, so 5.2ceil => 6
- .floor 
- .zero? 

# array 
- .first # gets .[0]
- .last # gets .[-1]
- .shift # mutable, removes first element
- .unshift n # mutable (requires arg) inserts new first element; unshift(n) works too
- .pop # mutable, removes last element
- .push n # mutable (requires arg) inserts new last element; .push(n) works too 
- << n # adds new last element 
- arr - arr_new # subtract latter array from former 
- .join 