# rubocop:disable Style/CaseEquality 

module Enumerable 

    def my_each 
      my_array = self
      my_array = * my_array if my_array.class == Range
      return to_enum if !block_given?
      i = 0
      while i < my_array.length
        yield my_array[i]
        i += 1
      end
    my_array 
    end

    def my_each_with_index
      my_array = self
      my_array = * my_array if my_array.class == Range
      return to_enum if !block_given?
      i = 0
      while i < my_array.length
        yield my_array[i], i
        i += 1
      end  
      my_array
    end

    def my_select
      my_array = self
      my_array = * my_array if my_array.class == Range
      return to_enum if !block_given?
      arr = []
      i = 0
      while i < my_array.length 
        arr.push(my_array[i]) unless !yield my_array[i]
        i += 1
      end
      arr
    end

    def my_all?(pattern = false)
      my_array = self
      my_array = * my_array if my_array.class == Range
      if block_given?        
        i = 0
        bool = true
        while i < my_array.length
          if !yield my_array[i]
            bool = false 
            break
          end
          i += 1  
        end
        return bool
      elsif pattern
        i = 0
        while i < my_array.length
          return false unless pattern === my_array[i]
          i += 1
        end
        return true
      else
        my_all?{|item|item}  
      end
    end

    def my_any? (pattern = false)
      my_array = self
      my_array = * my_array if my_array.class == Range
      if block_given?
        i = 0
        while i < my_array.length
          return true if yield my_array[i] 
          i += 1
        end
        return false
      elsif pattern
        i = 0
        while i < my_array.length 
          return true if pattern === my_array[i]
          i += 1
        end
        return false
      else
        my_any?{|item| item}
      end 
    end

    def my_none? (pattern = false)
      my_array = self
      my_array = * my_array if my_array.class == Range
      if block_given?
        i = 0
        while i < my_array.length
          return false if yield my_array[i] 
          i += 1
        end
        return true
      elsif pattern
        i = 0
        while i < my_array.length
          return false if pattern === my_array[i]
          i += 1  
        end
        return true
      else
        my_none?{|item|item}
      end
    end

    def my_count(item=false)
      my_array = self
      my_array = * my_array if my_array.class == Range
      counter = 0
      if block_given?       
         i = 0
         while i < my_array.length
           counter += 1 unless !yield my_array[i]  
           i += 1    
         end
         return counter
      elsif item
        i = 0
        while i < my_array.length
          counter += 1 unless item != my_array[i]
          i += 1
        end
        return counter
      else 
        return length
      end  
    end

    def my_map (proc = false)
      my_array = self
      my_array = * my_array if my_array.class == Range
      arr = []
      if block_given? 
        i = 0
        while i < my_array.length
          arr.push(yield my_array[i])
          i += 1  
        end 
        return arr
      elsif proc   
        i = 0
        while i < my_array.length
          arr.push(proc.call(my_array[i]))
          i += 1
        end
        return arr
      else     
        return to_enum 
      end
    end

    def my_inject (memo = false, symbol = false)
      arr = self 
      if arr.class == Range
        arr = *arr
      end  
      if memo && symbol
        i = 0
        while i < arr.length
          memo = memo.send(symbol, arr[i])  
          i += 1 
        end
        return memo
      elsif memo && block_given?
        i = 0
        while i < arr.length
          memo = yield memo, arr[i] 
          i += 1  
        end
        return memo
      elsif memo.class == Symbol 
        sum = arr[0]
        i = 1 
        while i < arr.length
          sum = sum.send(memo, arr[i])
          i += 1
        end
        return sum
      elsif memo.class == Integer
        i = 0
        while i < arr.length
          memo += arr[i]
          i += 1
        end
        return memo
      else 
        memo = arr[0]
        i = 1
        while i < arr.length
          memo = yield memo, arr[i] 
          i += 1
        end
        return memo
      end  
    end

end

arr = [1 , 2, 3, 4]

def multiply_els (els)
  els.my_inject(:*)
end

puts multiply_els(arr)