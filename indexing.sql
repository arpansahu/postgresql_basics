Primary Index:
    ordered, key (data is unique)
    It is generally sparse since it is in sorted order so no fo entries = no of blocks in hard disk
    search time: log base 2 (N +1)
ex:
    pages in ram                  index table
    ----------- page 1          index page
    1 arpan                     1     page 1
    2 shivanshu                 2     page 2
    3 deeptanshu
    4 vd
    ----------- page 2
    5 vismay
    6 divanshu
    7 anirudh
    8 hussain




Clustered Index:
    ordered, non key (data is not unique)
    IT is also always sparse

    note: if someone asks if clustered index can have more than one index for same data then lets just
        say it is possible obviously but unnecessary

    space complexity : no of dep  + anchors
    time complexity : search time: log base 2 (N +1 + 1)

ex:
    pages in ram                  index table
    dep no--- emp name ---- page 1                                              index page
    1 arpan                                                                     1     page 1
    2 shivanshu                                                                 2     page 1
    2 deeptanshu                                                                3     page 1
    3 vd       (since dep 3 is extended a block hanker will point to page 2 )   4     page 2
    ----------- page 2
    3 vismay  --
    4 divanshu
    4 anirudh
    4 hussain

Secondary Index:
    unordered, [key, as well as non key]
    secondary index is dense in key based,  sparse + dense = dense in non key
    -Key:
        search time: log base 2  (N + 1)  / log base 2  (N +1(x) + 1)
        pan no is search attribute which is unique

    -Non Key:
