```
Sort Breakdown:
===============
Bubble sort the array: [64, 34, 25, 12, 22, 11, 90]: 617.565 ms
  Pass 1: 187.643 ms
    Comparing elements at positions 0 and 1: 0.011 ms
      => Swapping elements 64 and 34
      => Array after swap: [34, 64, 25, 12, 22, 11, 90]
    Comparing elements at positions 1 and 2: 0.051 ms
      => Swapping elements 64 and 25
      => Array after swap: [34, 25, 64, 12, 22, 11, 90]
    Comparing elements at positions 2 and 3: 0.021 ms
      => Swapping elements 64 and 12
      => Array after swap: [34, 25, 12, 64, 22, 11, 90]
    Comparing elements at positions 3 and 4: 0.019 ms
      => Swapping elements 64 and 22
      => Array after swap: [34, 25, 12, 22, 64, 11, 90]
    Comparing elements at positions 4 and 5: 0.019 ms
      => Swapping elements 64 and 11
      => Array after swap: [34, 25, 12, 22, 11, 64, 90]
    Comparing elements at positions 5 and 6: 0.011 ms
      => No swap needed for elements 64 and 90
  Pass 2: 143.693 ms
    Comparing elements at positions 0 and 1: 0.016 ms
      => Swapping elements 34 and 25
      => Array after swap: [25, 34, 12, 22, 11, 64, 90]
    Comparing elements at positions 1 and 2: 0.052 ms
      => Swapping elements 34 and 12
      => Array after swap: [25, 12, 34, 22, 11, 64, 90]
    Comparing elements at positions 2 and 3: 0.084 ms
      => Swapping elements 34 and 22
      => Array after swap: [25, 12, 22, 34, 11, 64, 90]
    Comparing elements at positions 3 and 4: 0.052 ms
      => Swapping elements 34 and 11
      => Array after swap: [25, 12, 22, 11, 34, 64, 90]
    Comparing elements at positions 4 and 5: 0.021 ms
      => No swap needed for elements 34 and 64
  Pass 3: 108.589 ms
    Comparing elements at positions 0 and 1: 0.046 ms
      => Swapping elements 25 and 12
      => Array after swap: [12, 25, 22, 11, 34, 64, 90]
    Comparing elements at positions 1 and 2: 0.051 ms
      => Swapping elements 25 and 22
      => Array after swap: [12, 22, 25, 11, 34, 64, 90]
    Comparing elements at positions 2 and 3: 0.100 ms
      => Swapping elements 25 and 11
      => Array after swap: [12, 22, 11, 25, 34, 64, 90]
    Comparing elements at positions 3 and 4: 0.028 ms
      => No swap needed for elements 25 and 34
  Pass 4: 90.732 ms
    Comparing elements at positions 0 and 1: 0.015 ms
      => No swap needed for elements 12 and 22
    Comparing elements at positions 1 and 2: 0.048 ms
      => Swapping elements 22 and 11
      => Array after swap: [12, 11, 22, 25, 34, 64, 90]
    Comparing elements at positions 2 and 3: 0.013 ms
      => No swap needed for elements 22 and 25
  Pass 5: 50.597 ms
    Comparing elements at positions 0 and 1: 0.022 ms
      => Swapping elements 12 and 11
      => Array after swap: [11, 12, 22, 25, 34, 64, 90]
    Comparing elements at positions 1 and 2: 0.011 ms
      => No swap needed for elements 12 and 22
```