import numpy as np

# Creating a 4x3 array of integers
A = np.array([[9, 8, 7, 6],
                       [5, 4, 3, 2],
                       [1, 9, 8, 7]])
B = np.array([[1, 2, 3],
                       [4, 5, 6],
                       [7, 8, 9],
                       [1, 2, 3]])

# Creating a 3x4 array of integers

A_rows=len(A)
A_cols=len(A[0])
B_rows=len(B)
B_cols=len(B[0])

# print("4x3 Array:")
# print(array_4x3)

# print("\n3x4 Array:")
# print(array_3x4)
print(A_cols)
sys_rows=2
sys_cols=2
C=None
for i in range(0,A_cols,sys_cols):#iterate over B
    for j in range(0,B_rows,sys_rows):#interate over A and B
        tile_A=A[:,j:min(j+sys_rows,A_cols)]
        tile_B=B[j:min(j+sys_rows,B_rows),i:min(i+sys_cols,B_cols)]
        if(C is None):
            C=np.dot(tile_A,tile_B)
        else:
            C+=np.dot(tile_A,tile_B)
        # print(tile_A)
    print (C)
    C=None
print (np.dot(A,B))