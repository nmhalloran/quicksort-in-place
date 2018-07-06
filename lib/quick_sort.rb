require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)

    return array if array.length == 1

    pivot = array.shift
    left_array = array.select { |el| el >= pivot }
    right_array = array.select { |el| el < pivot }

    return self.sort1(left_array) + [pivot] + self.sort1(right_array)

  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return [array[start]] if length <= 1

    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    partition = partition(array, start, length, &prc)

    sort2!(array, start, partition - start, &prc)
    sort2!(array, partition + 1, length - partition - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    
    idx = start
    finish = start + length - 1
    finish = array.length - 1 if finish >= array.length

    (start + 1).upto(finish) do |i|
      if prc.call(array[start], array[i]) >= 0
        idx += 1
        if i != idx
          array[i], array[idx] = array[idx], array[i]
        end
      end
    end
    array[idx], array[start] = array[start], array[idx]
    idx
  end
end
