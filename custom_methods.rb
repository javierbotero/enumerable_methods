# rubocop:disable Style/CaseEquality 

module Enumerable 

    def my_each 
      return to_enum if !block_given?
      i = 0
      while i < length
        yield self[i]
        i += 1
      end
    self 
    end

    def my_each_with_index
      return to_enum if !block_given?
      i = 0
      while i < length
        yield self[i], i
        i += 1
      end  
      self
    end

    def my_select
      return to_enum if !block_given?
      arr = []
      i = 0
      while i < length 
        arr.push(self[i]) unless !yield self[i]
        i += 1
      end
      arr
    end

    def my_all?(pattern = false)
      if block_given?        
        i = 0
        bool = true
        while i < length
          if !yield self[i]
            bool = false 
            break
          end
          i += 1  
        end
        return bool
      elsif pattern
        i = 0
        while i < length
          return false unless pattern === self[i]
          i += 1
        end
        return true
      else
        my_all?{|item|item}  
      end
    end

    def my_any? (pattern = false)
      if block_given?
        i = 0
        while i < length
          return true if yield self[i] 
          i += 1
        end
        return false
      elsif pattern
        i = 0
        while i < length 
          return true if pattern === self[i]
          i += 1
        end
        return false
      else
        my_any?{|item| item}
      end 
    end

    def my_none? (pattern = false)
      if block_given?
        i = 0
        while i < length
          return false if yield self[i] 
          i += 1
        end
        return true
      elsif pattern
        i = 0
        while i < length
          return false if pattern === self[i]
          i += 1  
        end
        return true
      else
        my_none?{|item|item}
      end
    end

    def my_count(item=false)
      counter = 0
      if block_given?       
         i = 0
         while i < length
           counter += 1 unless !yield self[i]  
           i += 1    
         end
         return counter
      elsif item
        i = 0
        while i < length
          counter += 1 unless item != self[i]
          i += 1
        end
        return counter
      else 
        return length
      end  
    end

    def my_map
      arr = []
      if block_given?
        i = 0
        while i < length
          arr.push(yield self[i])
          i += 1  
        end 
        return arr
      end 
      return to_enum 
    end

    def my_inject (memo = false, symbol = false)      
      if memo && symbol
        i = 0
        while i < length
          memo = memo.send(symbol, self[i])  
          i += 1 
        end
        return memo
      elsif memo && block_given?
        i = 0
        while i < length
          memo = yield memo, self[i] 
          i += 1  
        end
        return memo
      elsif memo    
        sum = self[0]
        i = 1 
        while i < length
          sum = sum.send(memo, self[i])
          i += 1
        end
        return sum
      else
        memo = self[0]
        i = 1
        while i < length
          memo = yield memo, self[i] 
          i += 1
        end
        return memo
      end  
    end

end
  
