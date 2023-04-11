###########################################################################################################
# CSCB58 Winter 2023 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Arnav Priyadarshi, 1007338855, priyad11, arnav.priyadarshi@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4 (update this as needed)
# - Unit height in pixels: 4 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3 (choose the one the applies)
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. moving platforms
# 2. score earned by collecting pickups
# 3. fail by falling off screen or touching black hole to the left
# 4. pickups move to stay on top of platforms so they can be reached easier
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# - Have you heard the tragedy of darth plagueis the wise? I thought not.
#   It's not a story the jedi would tell you. It's a sith legend.
#   Darth plagueis was a dark lord of the sith,
#   so powerful and so wise he could use the force to influence the midi-chlorians to create life... He had such a knowledge of the dark side that he could even keep the ones he cared about from dying. The dark side of the force is a pathway to many abilities some consider to be unnatural. He became so powerful... the only thing he was afraid of was losing his power, which eventually, of course, he did. Unfortunately, he taught his apprentice everything he knew, then his apprentice killed him in his sleep. Ironic. He could save others from death, but not himself.
#
###########################################################################################################
# dimensions: 256x256 split into 4x4 chunks -> 64x64 chunks
# Multiply each address by 4. Remember the 0 starts at 10008000
# counting each word as 4 bytes, each row is 256 bytes
# 252 in the x 252 in the y
#    0     4     8    12    16    20    24    28    32    36    40    44    48    52    56    60 (63 <- 252)
#   64    68    72    76    80    84    88    92    96   100   104   108   112   116   120   124
#  128   132   136   140   144   148   152   156   160   164   168   172   176   180   184   188
#  192   196   200   204   208   212   216   220   224   228   232   236   240   244   248   252
#  256   260   264   268   272   276   280   284   288   292   296   300   304   308   312   316
#  320   324   328   332   336   340   344   348   352   356   360   364   368   372   376   380
#  384   388   392   396   400   404   408   412   416   420   424   428   432   436   440   444
#  448   452   456   460   464   468   472   476   480   484   488   492   496   500   504   508
#  512   516   520   524   528   532   536   540   544   548   552   556   560   564   568   572
#  576   580   584   588   592   596   600   604   608   612   616   620   624   628   632   636
#  640   644   648   652   656   660   664   668   672   676   680   684   688   692   696   700
#  704   708   712   716   720   724   728   732   736   740   744   748   752   756   760   764
#  768   772   776   780   784   788   792   796   800   804   808   812   816   820   824   828
#  832   836   840   844   848   852   856   860   864   868   872   876   880   884   888   892
#  896   900   904   908   912   916   920   924   928   932   936   940   944   948   952   956
#  960   964   968   972   976   980   984   988   992   996  1000  1004  1008  1012  1016  1020
# 1024  1028  1032  1036  1040  1044  1048  1052  1056  1060  1064  1068  1072  1076  1080  1084
# 1088  1092  1096  1100  1104  1108  1112  1116  1120  1124  1128  1132  1136  1140  1144  1148
# 1152  1156  1160  1164  1168  1172  1176  1180  1184  1188  1192  1196  1200  1204  1208  1212
# 1216  1220  1224  1228  1232  1236  1240  1244  1248  1252  1256  1260  1264  1268  1272  1276
# 1280  1284  1288  1292  1296  1300  1304  1308  1312  1316  1320  1324  1328  1332  1336  1340
# 1344  1348  1352  1356  1360  1364  1368  1372  1376  1380  1384  1388  1392  1396  1400  1404
# 1408  1412  1416  1420  1424  1428  1432  1436  1440  1444  1448  1452  1456  1460  1464  1468
# 1472  1476  1480  1484  1488  1492  1496  1500  1504  1508  1512  1516  1520  1524  1528  1532
# 1536  1540  1544  1548  1552  1556  1560  1564  1568  1572  1576  1580  1584  1588  1592  1596
# 1600  1604  1608  1612  1616  1620  1624  1628  1632  1636  1640  1644  1648  1652  1656  1660
# 1664  1668  1672  1676  1680  1684  1688  1692  1696  1700  1704  1708  1712  1716  1720  1724
# 1728  1732  1736  1740  1744  1748  1752  1756  1760  1764  1768  1772  1776  1780  1784  1788
# 1792  1796  1800  1804  1808  1812  1816  1820  1824  1828  1832  1836  1840  1844  1848  1852
# 1856  1860  1864  1868  1872  1876  1880  1884  1888  1892  1896  1900  1904  1908  1912  1916
# 1920  1924  1928  1932  1936  1940  1944  1948  1952  1956  1960  1964  1968  1972  1976  1980
# 1984  1988  1992  1996  2000  2004  2008  2012  2016  2020  2024  2028  2032  2036  2040  2044
# 2048  2052  2056  2060  2064  2068  2072  2076  2080  2084  2088  2092  2096  2100  2104  2108
# 2112  2116  2120  2124  2128  2132  2136  2140  2144  2148  2152  2156  2160  2164  2168  2172
# 2176  2180  2184  2188  2192  2196  2200  2204  2208  2212  2216  2220  2224  2228  2232  2236
# 2240  2244  2248  2252  2256  2260  2264  2268  2272  2276  2280  2284  2288  2292  2296  2300
# 2304  2308  2312  2316  2320  2324  2328  2332  2336  2340  2344  2348  2352  2356  2360  2364
# 2368  2372  2376  2380  2384  2388  2392  2396  2400  2404  2408  2412  2416  2420  2424  2428
# 2432  2436  2440  2444  2448  2452  2456  2460  2464  2468  2472  2476  2480  2484  2488  2492
# 2496  2500  2504  2508  2512  2516  2520  2524  2528  2532  2536  2540  2544  2548  2552  2556
# 2560  2564  2568  2572  2576  2580  2584  2588  2592  2596  2600  2604  2608  2612  2616  2620
# 2624  2628  2632  2636  2640  2644  2648  2652  2656  2660  2664  2668  2672  2676  2680  2684
# 2688  2692  2696  2700  2704  2708  2712  2716  2720  2724  2728  2732  2736  2740  2744  2748
# 2752  2756  2760  2764  2768  2772  2776  2780  2784  2788  2792  2796  2800  2804  2808  2812
# 2816  2820  2824  2828  2832  2836  2840  2844  2848  2852  2856  2860  2864  2868  2872  2876
# 2880  2884  2888  2892  2896  2900  2904  2908  2912  2916  2920  2924  2928  2932  2936  2940
# 2944  2948  2952  2956  2960  2964  2968  2972  2976  2980  2984  2988  2992  2996  3000  3004
# 3008  3012  3016  3020  3024  3028  3032  3036  3040  3044  3048  3052  3056  3060  3064  3068
# 3072  3076  3080  3084  3088  3092  3096  3100  3104  3108  3112  3116  3120  3124  3128  3132
# 3136  3140  3144  3148  3152  3156  3160  3164  3168  3172  3176  3180  3184  3188  3192  3196
# 3200  3204  3208  3212  3216  3220  3224  3228  3232  3236  3240  3244  3248  3252  3256  3260
# 3264  3268  3272  3276  3280  3284  3288  3292  3296  3300  3304  3308  3312  3316  3320  3324
# 3328  3332  3336  3340  3344  3348  3352  3356  3360  3364  3368  3372  3376  3380  3384  3388
# 3392  3396  3400  3404  3408  3412  3416  3420  3424  3428  3432  3436  3440  3444  3448  3452
# 3456  3460  3464  3468  3472  3476  3480  3484  3488  3492  3496  3500  3504  3508  3512  3516
# 3520  3524  3528  3532  3536  3540  3544  3548  3552  3556  3560  3564  3568  3572  3576  3580
# 3584  3588  3592  3596  3600  3604  3608  3612  3616  3620  3624  3628  3632  3636  3640  3644
# 3648  3652  3656  3660  3664  3668  3672  3676  3680  3684  3688  3692  3696  3700  3704  3708
# 3712  3716  3720  3724  3728  3732  3736  3740  3744  3748  3752  3756  3760  3764  3768  3772
# 3776  3780  3784  3788  3792  3796  3800  3804  3808  3812  3816  3820  3824  3828  3832  3836
# 3840  3844  3848  3852  3856  3860  3864  3868  3872  3876  3880  3884  3888  3892  3896  3900
# 3904  3908  3912  3916  3920  3924  3928  3932  3936  3940  3944  3948  3952  3956  3960  3964
# 3968  3972  3976  3980  3984  3988  3992  3996  4000  4004  4008  4012  4016  4020  4024  4028
# 4032  4036  4040  4044  4048  4052  4056  4060  4064  4068  4072  4076  4080  4084  4088  4092
#  ^
#  |
# 16,128



# car platformer game
# 0x10008000
#
#  /                      0     ---------------------
# |        rover->    /[####]\                                        you can drive left-right and jump
# |                  o        o                                       you have to avoid the obstacles
# |                 -----------------                                 and jump and land on the platforms
# | ------------ <- debris getting sucked in                          and it's a score based mechanism
# |                                                                   lasting longer gives a higher score
# | <- black hole effect
#  \                               -------------------------------------------
#
# basically it's an endless sidescroller game with moving platforms
#
# use wasd to move around


# ___________________________________________________________________________________________

# todos:
# - --[] player collision top---
# - [x] add a score counter
# - [x] make velocity a counter and only move 1 xy per tick (smoothness)
# - [ ] add score based on pickups (jerrycan)
# - [ ] add a instalose pickup (bomb)
# - [x] add a text renderer in the top right to display scores
# - [x] make clouds take up 2 rows and have its top be a bit wavy
# - [ ] test collision logic


# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



######### color codes #############
                                  #
.eqv  PBODY         0xE2071C      #
.eqv  PHEAD         0xb000b5      #
.eqv  TIRE          0x1e2a2d      #
                                  #
.eqv  SKY           0x27C5ef      #
.eqv  ASTRO         0x130c98      #
.eqv  PLATFM        0x8CEEB5      #
.eqv  CLOUD         0xbeeeff      #
.eqv  TEXT          0xc0ffee      #
                                  #
.eqv  BOMB          0x000000      #
.eqv  JCAN          0xff0000      #
.eqv  FIRE          0xffff00      #
.eqv  NOZZLE        0x6C707f      #
                                  #
###################################


.eqv  BASE_ADDR     0x10008000  # base address for display

.eqv  TICK_RATE     100         # ms per tick

.eqv  NO_PLATS      8           # number of platforms at most


.data
# here we store the left most coordinate for each platform
# in the same list we reserve the next word for each platform's length
# odd indices = length, even indices = left most coordinate
# 64 bytes -> 2 words per platform+len (8 bytes) -> 8 platforms at most

# refer to init_plats to see the exact values these get set to
platforms:  .word 0,-1,  0,-1,  0,-1,  0,-1,  0,-1,  0,-1,  0,-1,  0,-1


input:      .word 0       # an enum for the different inputs
# {
#   0: no input (preserve velocity?)
#   1: left   - a
#   2: right  - d
#   3: jump   - w / space
#   4: reset  - r / p
# }

# {
player:     .word 0,0     # player's coordinates - x and y. default set in init
velocity:   .word 0,0     # velocity - vx and vy (negative means left/down)
# }

score:      .word 0       # score counter

# there's only ever 1 pickup active at a time
pickup:    .word -1,-1,-1   # type of pickup, pickup xy
# should be -1 if nothing
# pickup enum (type of pickup){
# -1: no pickup
#  0: jcan
#  1: bomb
# }


# ___________________________________________________________________________________________

# for ease of use these $s registers will be reserved
# $s1 = base address for display
# $s2 = reserved for coord_to_offset conversions
# $s3 = base address for player
# $s4 = base address for score
# $s5 = base address for pickup

.text   # GLOBAL REGISTERS

  li    $s1, BASE_ADDR	  # $s1 stores the base address for display
  la    $s3, player       # $s3 stores the address of the player[0]
  la    $s4, score        # $s4 stores the address of the score[0]
  la    $s5, pickup       # $s5 stores the address of the pickup[0]

# ___________________________________________________________________________________________


.globl main
main:


init:                     # initialize the game
  # set all the arrays back to their initial values
  # platforms will be done in init platforms

  jal   background        # initialize the background

  la    $t1, input        # $t1 stores the address of the input[0]
  sw    $zero, 0($t1)     # store the input in input[0]

  addi  $a0, $zero, 8     # starting x coord for the player
  sw    $a0, 0($s3)       # store the x coord in player[0]
  addi  $a1, $zero, 29    # starting y coord for the player
  sw    $a1, 4($s3)       # store the y coord in player[4]
  jal   coord_to_offset   # convert the player's coordinates to an offset
  jal   draw_player       # draw the player


  la    $t1, velocity     # $t1 stores the address of the velocity[0]
  sw    $zero, 0($t1)     # store the vx in velocity[0]
  sw    $zero, 4($t1)     # store the vy in velocity[4]

  la    $t1, score        # $t1 stores the address of the score[0]
  sw    $zero, 0($t1)     # store the score in score[0]
  jal   text_manager      # draw the score

  jal   init_platforms    # initialize the platforms

  addi  $a0, $zero, 33    # starting x coord for the pickup (will be decremented when drawn)
  addi  $a1, $zero, 27    # starting y coord for the pickup
  addi  $a2, $zero, 0     # starting type for the pickup (jcan)
  sw    $a0, 0($s5)       # store the x coord in pickup[0]
  sw    $a1, 4($s5)       # store the y coord in pickup[4]
  sw    $a2, 8($s5)       # store the type in pickup[8]
  jal   pickup_manager    # draw the pickup

  li    $v0, 32           # load the syscall number for sleep
  li    $a0, 2000         # load the argument of 2s for sleep
  syscall                 # call the sleep syscall to sleep for TICK_RATE ms

  j     tick              # jump to main game loop



# ___________________________________________________________________________________________

# coordinate system
# the most right you can go is 252 if we're word aligned
# ie any offset off is essentially 256*(off/256)=y + off%256=x

# register calling convention
coord_to_offset:          # converts a pair of coordinate to an offset
  # takes in $a0 as x and $a1 as y
  # returns the offset in $v0
  # normalize the offset to display address so you don't need to add base address later

  mul   $v0, $a1, 256     # $v0 <- ($a1=y)*256
  mflo	$v0               # load the mult from lo

  # multiply x coord by 4 since we're word aligned
  sll   $s2, $a0, 2       # $s2 <- ($a0=x)*4

  add   $v0, $v0, $s2     # $v0 <- y-off + x-off

  addi  $v0,$v0,BASE_ADDR # add base address to normalize it for the display

  j     return            # return

# register calling convention
offset_to_coord:          # converts an offset to a pair of coordinate
  # takes in $a0 as offset that's been added to the base address
  # returns the x coordinate in $v0 and y coordinate in $v1

  subi  $s2,$a0,BASE_ADDR # subtract the base address
  div   $v1, $s2, 256     # [rem,quot] <- $s2/256
  mflo	$v1               # $s2 div 256 = y

  mfhi	$v0               # $s2 mod 256 = 4x
  srl   $v0, $v0, 2       # $v0 <- 4x/4

  j     return            # return

# ___________________________________________________________________________________________

# input handling
# we use the syscall to read the input

input_manager:            # handles the input and sets the input enum
  # uses mmio keyboard
  # takes in no args
  # sets the input variable

  li    $t4, 0xffff0000   # $t4 stores the mask for the keyboard
  la    $t5, input        # $t5 stores the address of the input variable
  lw    $t6, 0($t4)       # $t6 reads if an input happened
  beq   $t6, 1, keypress  # if an input happened, jump to keypress

  sw    $zero, 0($t5)     # else set the input to 0
  j     return            # return

  keypress:
    lw    $t6, 4($t4)       # $t6 reads the actual ascii code of the key

    # in hexadecimal
    # a = 0x61
    # d = 0x64
    # w = 0x77
    # space = 0x20
    # r = 0x72
    # p = 0x70

    beq   $t6, 0x61,a_press # if the key is a, jump to a_press
    beq   $t6, 0x64,d_press # if the key is d, jump to d_press
    beq   $t6, 0x77,w_press # if the key is w, jump to w_press
    beq   $t6, 0x20,w_press # if the key is space, jump to w_press
    beq   $t6, 0x72,r_press # if the key is r, jump to r_press
    beq   $t6, 0x70,r_press # if the key is p, jump to r_press

  j     return            # return

  a_press:
    addi  $t9, $zero, 1     # $t9 stores the input enum for left
    sw		$t9, 0($t5)       # set the input to left
    j     return            # return

  d_press:
    addi  $t9, $zero, 2     # $t9 stores the input enum for right
    sw		$t9, 0($t5)       # set the input to right
    j     return            # return

  w_press:                  # if the key is w or a space gets redirected here as well
    addi  $t9, $zero, 3     # $t9 stores the input enum for jump
    sw		$t9, 0($t5)       # set the input to jump
    j     return            # return

  r_press:
    j     init              # restart the game
    # addi  $t9, $zero, 4     # $t9 stores the input enum for reset
    # sw		$t9, 0($t5)       # set the input to reset
    # j     return            # return


# ___________________________________________________________________________________________

tick:
  # main game loop
  # 1. check for input
  # 2. update game state
  # 3. erase old game state
  # 3. render new game state
  # 4. sleep
  # repeat

  jal   input_manager     # run the input handling code

  jal   text_manager      # run the score drawing code

  jal   player_manager    # run the player updating code

  jal   platform_manager  # run the platform updating code

  jal   pickup_manager    # run the pickup updating code


  li    $v0, 32           # load the syscall number for sleep
  li    $a0, TICK_RATE    # load the argument for sleep
  syscall                 # call the sleep syscall to sleep for TICK_RATE ms

  j		  tick				      # repeat the game loop ad infinitum...


lose:                     # if the player encounters a lose condition
  # check for input
  # if input is reset, restart the game
  # repeat
    jal   input_manager     # run the input handling code
    la    $t2, input        # $t2 stores the address of the input variable
    lw    $t2, 0($t2)       # $t2 store the input
    beq   $t2, 4, init      # if the input is reset, restart the game

    j     lose              # repeat the lose loop

# ___________________________________________________________________________________________

# text renderer
# currently only draws numbers at the top right for score
# note the score is updated in player at p_collide

# stack based calling convention
text_manager:            # draws score at the top right
  # platforms spawn in [10-52]
  # if we give ourselves 2 padding on the bottom then our range is [0-7]
  # the characters have width 5
  # we pass them around by maintaining a pointer to the top left of their box
  # if we give a space of 1 on top and right then our units pointer is at (63-1-5=57,1)
  # the tens pointer has a gap of 2 from that so its at (57-2-5=50,1)
  # the subprocs for start from wherever $v0 is at the time of the call

  addi  $sp, $sp, -4      # allocate space for the return address
  sw    $ra, 0($sp)       # save the return address

  lw    $t4, 0($s4)       # $t4 stores the score

  div   $5, $t4, 10       # [rem,quot] <- $t4/10
  mfhi	$t6               # $t6 <- $t4 mod 10 - the units digit

  units:                    # draw the units digit
    li    $a0, 57           # $a0 stores the x coord of the units digit
    li    $a1, 1            # $a1 stores the y coord of the units digit
    jal   coord_to_offset   # $v0 stores the offset of the units digit

    beq   $t6, 0, zero      # if the units digit is 0, jump to zero
    beq   $t6, 1, one       # if the units digit is 1, jump to one
    beq   $t6, 2, two       # if the units digit is 2, jump to two
    beq   $t6, 3, three     # if the units digit is 3, jump to three
    beq   $t6, 4, four      # if the units digit is 4, jump to four
    beq   $t6, 5, five      # if the units digit is 5, jump to five
    beq   $t6, 6, six       # if the units digit is 6, jump to six
    beq   $t6, 7, seven     # if the units digit is 7, jump to seven
    beq   $t6, 8, eight     # if the units digit is 8, jump to eight
    beq   $t6, 9, nine      # if the units digit is 9, jump to nine

  endunits:

  # the drawing functions DONT preserve $t6 and $t5 to avoid entering an infinite loop
  # that's why we reset it here
  div   $5, $t4, 10       # [rem,quot] <- $t4/10
  mfhi	$t6               # $t6 <- $t4 mod 10 - the units digit
  mflo	$t5               # $t5 <- $t4 div 10

  tens:                     # draw the tens digit
    li    $a0, 50           # $a0 stores the x coord of the tens digit
    li    $a1, 1            # $a1 stores the y coord of the tens digit
    jal   coord_to_offset   # $v0 stores the offset of the tens digit

    beq   $t5, 0, zero      # if the tens digit is 0, jump to zero
    beq   $t5, 1, one       # if the tens digit is 1, jump to one
    beq   $t5, 2, two       # if the tens digit is 2, jump to two
    beq   $t5, 3, three     # if the tens digit is 3, jump to three
    beq   $t5, 4, four      # if the tens digit is 4, jump to four
    beq   $t5, 5, five      # if the tens digit is 5, jump to five
    beq   $t5, 6, six       # if the tens digit is 6, jump to six
    beq   $t5, 7, seven     # if the tens digit is 7, jump to seven
    beq   $t5, 8, eight     # if the tens digit is 8, jump to eight
    beq   $t5, 9, nine      # if the tens digit is 9, jump to nine

  endtens:

  j     sreturn           # return to the caller

  # drawing functions draw at $v0
  # the functions draw their entire 5x7 box so we just overwrite numbers without clearing
  # they draw in a rowise fashion and increment $v0 after completing a row
  # the numbers were first tested on a pixel art editor
  zero:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky

    jr    $ra               # return


  one:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t8, 16($v0)      # draw text

    jr    $ra               # return


  two:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t8, 16($v0)      # draw text

    jr    $ra               # return


  three:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky

    jr    $ra               # return


  four:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t8, 16($v0)      # draw text
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text

    jr    $ra               # return to caller


  five:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t8, 0($v0)       # draw text
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t8, 16($v0)      # draw text
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky

    jr    $ra               # return to caller


  six:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky

    jr    $ra               # return to caller


  seven:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t8, 0($v0)       # draw text
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t8, 16($v0)      # draw text
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t8, 8($v0)       # draw text
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t9, 16($v0)      # draw sky

    jr    $ra               # return to caller


  eight:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color

    # row 0
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky

    jr    $ra               # return to caller


  nine:
    addi  $t6, $zero, -1    # $t6 stores -1 to prevent infinite loops
    addi  $t5, $zero, -1    # $t5 stores -1 to prevent infinite loops

    li    $t9, SKY          # $t9 stores the sky color
    li    $t8, TEXT         # $t8 stores the text color


    # row 0
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky
    # row 1
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 2
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 3
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t8, 16($v0)      # draw text
    # row 4
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 5
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t8, 0($v0)       # draw text
    sw    $t9, 4($v0)       # draw sky
    sw    $t9, 8($v0)       # draw sky
    sw    $t9, 12($v0)      # draw sky
    sw    $t8, 16($v0)      # draw text
    # row 6
    addi  $v0, $v0, 256     # increment $v0 to the next row
    sw    $t9, 0($v0)       # draw sky
    sw    $t8, 4($v0)       # draw text
    sw    $t8, 8($v0)       # draw text
    sw    $t8, 12($v0)      # draw text
    sw    $t9, 16($v0)      # draw sky

    jr    $ra               # return to caller

# ___________________________________________________________________________________________

# player character


# stack based calling convention
player_manager:           # moves, manages state & collisions, draws the player - no args
  # remember $s3 stores the player coords
  # offloads work to the corresponding helper functions
  # sets up the registers for them to use, so you can't willy-nilly call them

  addi  $sp, $sp, -4      # allocate space for the return address
  sw    $ra, 0($sp)       # save the return address

  # the data we'll work on
  # + player coords which is globally $s3
  lw    $a0, 0($s3)       # $a0 stores the x coord of the player
  lw    $a1, 4($s3)       # $a1 stores the y coord of the player
  jal   coord_to_offset   # $v0 stores the offset of the player

  la    $t4, velocity     # $t4 stores the address of the velocity[0]
  la    $t6, input        # $t6 stores the address of the input variable

  jal   erase_player      # erase the player
  jal   on_platform       # check if the player is on a platform
  jal   move_player       # move the player - this changes $s3

  lw    $a0, 0($s3)       # $a0 stores the x coord of the player
  lw    $a1, 4($s3)       # $a1 stores the y coord of the player
  jal   coord_to_offset   # $v0 recalculate the new offset of the player

  jal   p_collide         # check for collisions and handle loss conditions
  # if p_collide changes $s3 it'll also change $v0 directly since changes are minor

  jal   draw_player       # draw the player

  j     sreturn           # return


erase_player:             # erases the player - no args
  # removes the drawing of the player and replaces it by sky
  # pre: it's safe to replace the player with sky

  li		$t7, SKY          # $t7 stores the sky color
  sw		$t7, 0($v0)       # paint the origin pixel with sky
  sw    $t7, 4($v0)       # paint the right pixel
  sw    $t7, -4($v0)      # paint the left pixel
  sw    $t7, 256($v0)     # paint the pixel below
  sw    $t7, 252($v0)     # paint the pixel below and to the left
  sw    $t7, 260($v0)     # paint the pixel below and to the right
  sw    $t7, -256($v0)    # paint the pixel above
  sw    $t7, -260($v0)    # paint the pixel above and to the left
  sw    $t7, -252($v0)    # paint the pixel above and to the right

  j     return            # return



on_platform:              # checks if the player is on a platform. sets vx and vy accordingly
  # if the player is on a platform and no input, set vx = -1 and vy = 0
  # if not then the player is in the air
  # we then instead set inputs of 3 to 0 so that the player doesn't jump mid air

  lw    $t7, 512($v0)     # $t7 stores the value 2 under the origin
  beq   $t7,PLATFM,on     # if the value is a platform, jump to on

  lw    $t7, 508($v0)     # $t7 stores the value 2 under the origin and to the left
  beq   $t7,PLATFM,on     # if the value is a platform, jump to on

  lw    $t7, 516($v0)     # $t7 stores the value 2 under the origin and to the right
  beq   $t7,PLATFM,on     # if the value is a platform, jump to on

  # if you're not on a platform, then ignore jumps
  lw    $t7, 0($t6)       # $t7 stores the input
  bne   $t7, 3, gravity   # if the input is not jump, then lets continue as normal
  sw    $0, 0($t6)        # otherwise make the input 0

  gravity:                  # if the player is in the air and not rising, apply gravity
    # if your vy is not negative (up) then set it to 1 for gravity
    lw    $t7, 4($t4)       # $t7 stores the y velocity
    blt   $t7,$zero,return  # if the y velocity is negative, then continue as normal
    addi  $t7, $zero, 1     # otherwise set the y velocity to 1
    sw    $t7, 4($t4)       # set the y velocity to the new y velocity
    j		  return				    # and continue

  on:                       # if the player is on a platform
    sw    $0, 4($t4)        # set the y velocity to 0

    lw    $t7, 0($t6)       # $t7 stores the input
    bne		$t7, 0, return    # if the input is doing something, then continue as normal

    # otherwise we slide the character along with the platform
    addi  $t7, $zero, -1    # $t7 stores the x velocity as -1
    sw    $t7, 0($t4)       # set the x velocity to the new x velocity
    j     return				    # and continue



move_player:
  # moves the player based on the sign of the velocity
  # sets the velocity based on the input

  lw    $t7, 0($t6)       # $t7 stores the input
  beq   $t7, 1, leftp     # if the input is left, jump to left
  beq   $t7, 2, rightp    # if the input is right, jump to right
  beq   $t7, 3, jumpp     # if the input is jump, jump to jump

  j     end_move          # end_move

  leftp:                    # if the input press is left
    addi  $t7, $zero, -1    # $t7 stores the new x velocity
    sw    $t7, 0($t4)       # set the x velocity to the new x velocity
    j     end_move          # jump to end_move

  rightp:                   # if the input press is right
    addi  $t7, $zero, 1     # $t7 stores the new x velocity
    sw    $t7, 0($t4)       # set the x velocity to the new x velocity
    j     end_move          # jump to end_move

  jumpp:                    # if the input press is jump
    addi  $t7, $zero, -6    # $t7 stores the new y velocity - origin is top left so negative is up
    sw    $t7, 4($t4)       # set the y velocity to the new y velocity
    j     end_move          # jump to end_move

  end_move:                 # end_move moves the character at most 1 pixel in each direction
    # it changes pos xy based on the sign of the velocity
    # if vx pos then add px = px+1 and decrement vx

    lw    $t7, 0($t4)       # $t7 stores the x velocity
    lw    $t8, 0($s3)       # $t8 stores the x coord of the player
    bgt   $t7, $zero, px    # if the x velocity is positive, jump to px
    blt   $t7, $zero, mx    # if the x velocity is negative, jump to mx
    j		  skip_mx           # if 0 then skip changing the x coord of the player

    px:                       # right
      addi  $t8, $t8, 1       # $t8 stores the new x coord of the player
      addi  $t7, $t7, -1      # $t7 stores the new x velocity
      j     skip_mx           # jump to skip_mx

    mx:                       # left
      addi  $t8, $t8, -1      # $t8 stores the new x coord of the player
      addi  $t7, $t7, 1       # $t7 stores the new x velocity

    skip_mx:                # just a jump target

    sw    $t7, 0($t4)       # set the x velocity to the new x velocity
    sw    $t8, 0($s3)       # set the x coord of the player to the new x coord

    lw    $t7, 4($t4)       # $t7 stores the y velocity
    lw    $t8, 4($s3)       # $t8 stores the y coord of the player

    bgt   $t7, $zero, py    # if the y velocity is positive, jump to py
    blt   $t7, $zero, my    # if the y velocity is negative, jump to my
    j		  skip_my           # if 0 then skip changing the y coord of the player

    py:                       # down ( since 0,0 is top left )
      addi  $t8, $t8, 1       # $t8 stores the new y coord of the player
      # special case as nothing naturally stops you from falling
      # you need to hit a platform to stop falling
      # addi  $t7, $t7, -1      # $t7 stores the new y velocity
      j     skip_my           # jump to skip_my

    my:                       # up
      addi  $t8, $t8, -1      # $t8 stores the new y coord of the player
      addi  $t7, $t7, 1       # $t7 stores the new y velocity

    skip_my:                # just a jump target

    sw    $t7, 4($t4)       # set the y velocity to the new y velocity
    sw    $t8, 4($s3)       # set the y coord of the player to the new y coord

    j     return            # return



# stack based calling convention
p_collide:                # draws a bounding box around the player and handles collisions
  #  (-1, 1) ( 0, 1) ( 1, 1)
  #  (-1, 0) ( 0, 0) ( 1, 0)  consider the 3x3 grid around the player
  #  (-1,-1) ( 0,-1) ( 1,-1)

  # to be efficient we can't loop over every collidable object and check for collisions
  # instead we look at the around the player in every direction (incl. diags)
  # we check if the value in the display is the background color
  # if it is there's no collision
  # obv for this to work it has to be before the player paints over what was there
  # if there is a different color we resolve it in order of down - left - top - right
  # we resolve collisions by setting the position to be touching the wall but not inside it
  # we set the velocity and acceleration to 0
  # if there's a collision at (0, 1) - player hits platform side on - we just push left 1
  # if there's a collision at (-1,-1) then we push the player up since down applies first

  addi    $sp, $sp, -4    # decrement the stack pointer
  sw      $ra, 0($sp)     # store the return address

  down:
    addi  $t8, $v0, 256     # gets the offset for a point 1 row below the origin

    lw    $t7, 0($t8)       # $t7 stores the value at (0, -1)
    beq   $t7,PLATFM,dcol   # if the value is a platform, jump to down_col
    beq   $t7,CLOUD, lose   # if the value is a cloud, jump to lose
    beq   $t7,JCAN,get_dpup # if the value is a jerry can, jump to get_dpup
    beq   $t7,BOMB,get_dpup # if the value is a bomb, jump to get_dpup

    lw    $t7, 4($t8)       # $t7 stores the value at (1, -1)
    beq   $t7,PLATFM,dcol   # if the value is a platform, jump to down_col
    beq   $t7,CLOUD, lose   # if the value is cloud, jump to lose
    beq   $t7,JCAN,get_dpup # if the value is a jerry can, jump to get_dpup
    beq   $t7,BOMB,get_dpup # if the value is a bomb, jump to get_dpup

    lw    $t7, -4($t8)      # $t7 stores the value at (-1, -1)
    beq   $t7,PLATFM,dcol   # if the value is a platform, jump to down_col
    beq   $t7,CLOUD, lose   # if the value is cloud, jump to lose
    beq   $t7,JCAN,get_dpup # if the value is a jerry can, jump to get_dpup
    beq   $t7,BOMB,get_dpup # if the value is a bomb, jump to get_dpup

    j     left              # if there's no collision, check left

    get_dpup:
      jal   collect           # collect the pickup and come back here
      j     left              # check left

    dcol:
      lw    $t8, 4($s3)       # $t8 stores the y coord of the player
      addi  $t8, $t8, 1       # increment height
      sw    $t8, 4($s3)       # set the y coord of the player to the new y coord
      addi  $v0, $v0, 256     # correct the offset


  left:
    addi  $t8, $v0, -4      # gets the offset for a point 1 col left of the origin

    lw    $t7, 0($t8)       # $t7 stores the value at (-1, 0)
    beq   $t7,PLATFM,lcol   # if the value is a platform, jump to left_col
    beq   $t7,ASTRO, lose   # if the value is ASTRO, jump to lose
    beq   $t7,JCAN,get_lpup # if the value is a jerry can, jump to get_lpup
    beq   $t7,BOMB,get_lpup # if the value is a bomb, jump to get_lpup

    lw    $t7, 256($t8)     # $t7 stores the value at (-1, -1)
    beq   $t7,PLATFM,lcol   # if the value is a platform, jump to left_col
    beq   $t7,ASTRO, lose   # if the value is ASTRO, jump to lose
    beq   $t7,JCAN,get_lpup # if the value is a jerry can, jump to get_lpup
    beq   $t7,BOMB,get_lpup # if the value is a bomb, jump to get_lpup

    lw    $t7, -256($t8)    # $t7 stores the value at (-1, 1)
    beq   $t7,PLATFM,lcol   # if the value is a platform, jump to left_col
    beq   $t7,ASTRO, lose   # if the value is ASTRO, jump to lose
    beq   $t7,JCAN,get_lpup # if the value is a jerry can, jump to get_lpup
    beq   $t7,BOMB,get_lpup # if the value is a bomb, jump to get_lpup

    j     top               # if there's no collision, check top

    get_lpup:
      jal   collect           # collect the pickup and come back here
      j     top               # check top


    lcol:
      lw    $t8, 0($s3)       # $t8 stores the x coord of the player
      addi  $t8, $t8, 1       # increment x
      sw    $t8, 0($s3)       # set the x coord of the player to the new x coord
      addi  $v0, $v0, 4       # correct the offset


  top:
    # being able to jump onto a platform from under it is a mechanic
    addi  $t8, $v0, -256    # gets the offset for a point 1 row above the origin

    lw    $t7, 0($t8)       # $t7 stores the value at (0, 1)
    beq   $t7,JCAN,get_tpup # if the value is a jerry can, jump to get_tpup
    beq   $t7,BOMB,get_tpup # if the value is a bomb, jump to get_tpup

    lw    $t7, 4($t8)       # $t7 stores the value at (1, 1)
    beq   $t7,JCAN,get_tpup # if the value is a jerry can, jump to get_tpup
    beq   $t7,BOMB,get_tpup # if the value is a bomb, jump to get_tpup

    lw    $t7, -4($t8)      # $t7 stores the value at (-1, 1)
    beq   $t7,JCAN,get_tpup # if the value is a jerry can, jump to get_tpup
    beq   $t7,BOMB,get_tpup # if the value is a bomb, jump to get_tpup

    j     right             # if there's no collision, check right

    get_tpup:
      jal   collect           # collect the pickup and come back here
      j     right             # check right


  right:
    addi  $t8, $v0, 4       # gets the offset for a point 1 col right of the origin

    lw    $t7, 0($t8)       # $t7 stores the value at (1, 0)
    beq   $t7,PLATFM,rcol   # if the value is a platform, jump to right_col
    beq   $t7,JCAN,get_rpup # if the value is a jerry can, jump to get_rpup
    beq   $t7,BOMB,get_rpup # if the value is a bomb, jump to get_rpup

    lw    $t7, 256($t8)     # $t7 stores the value at (1, -1)
    beq   $t7,PLATFM,rcol   # if the value is a platform, jump to right_col
    beq   $t7,JCAN,get_rpup # if the value is a jerry can, jump to get_rpup
    beq   $t7,BOMB,get_rpup # if the value is a bomb, jump to get_rpup

    lw    $t7, -256($t8)    # $t7 stores the value at (1, 1)
    beq   $t7,PLATFM,rcol   # if the value is a platform, jump to right_col
    beq   $t7,JCAN,get_rpup # if the value is a jerry can, jump to get_rpup
    beq   $t7,BOMB,get_rpup # if the value is a bomb, jump to get_rpup

    lw    $t7, 0($s3)       # $t7 stores the x coord of the player
    bgt		$t7, 62, rcol			# if the player is at the right edge don't let them go offscreen

    j     sreturn           # return

    get_rpup:
      jal   collect           # collect the pickup and come back here
      j     sreturn           # return

    rcol:
      lw    $t8, 0($s3)       # $t8 stores the x coord of the player
      addi  $t8, $t8, -1      # decrement x
      sw    $t8, 0($s3)       # set the x coord of the player to the new x coord
      addi  $v0, $v0, -4      # correct the offset



draw_player:              # draws the player - no args
  # pre: origin is in the range 1-62 x 1-62
  # uses the player coords to draw the player
  # the player is a 3x3 construct and the coords are the origin
  # remember $v0 is the offset of the origin

  # middle row
  li    $t9, PBODY        # $t9 stores the color of the player chassis
  sw    $t9, -4($v0)      # paint the player chassis
  sw    $t9, 0($v0)       # paint the player chassis
  sw    $t9, 4($v0)       # paint the player chassis

  # top row
  sw    $t9, -260($v0)    # paint the player chassis at the top left
  li    $t9, PHEAD        # $t9 stores the color of the player head
  sw    $t9, -256($v0)    # paint the player head
  # (1,1) is left as an exercise to the reader

  # bottom row
  li    $t9, TIRE         # $t9 stores the color of the tires
  sw    $t9, 252($v0)     # paint the bottom left
  sw    $t9, 260($v0)     # paint the bottom right

  j     return            # return

# ___________________________________________________________________________________________

# pickups
# collisions are handled in p_collide as usual
# this is just for drawing/moving

# the pickups hover above a platform and move with it
# pickups have dimensions 3x3
# the pickup coordinates measure its origin i.e. (1, 1)
# the pickup's left is always drawn 1 col right of the platform head

# stack based calling convention
pickup_manager:           # moves pickups every turn - no args
  # if pickup is -1 do nothing
  # check if the pickup px is < 4
  # if it is, delete the pickup by setting it to -1
  # if it isn't the draw the pickup and at its new px to 1 left

  # early return if there are no pickups and skip the stack stuff
  lw    $s6, 8($s5)       # $s6 stores the pickup type
  beq   $s6, -1, return   # if the pickup is -1, do nothing

  addi  $sp, $sp, -4      # make space
  sw    $ra, 0($sp)       # save the return address

  lw    $a0, 0($s5)       # $a0 stores the pickup x coord
  lw    $a1, 4($s5)       # $a1 stores the pickup y coord

  blt   $a0, 4, delpick   # if the pickup is close to the left edge, delete it

  addi  $a0, $a0, -1      # decrement the pickup x coord
  sw    $a0, 0($s5)       # set the pickup x coord to the new x coord

  bgt   $a0, 60, sreturn  # if its at the right edge don't render to avoid overflow

  # otherwise we delete the last col of the pickup and draw the new one
  # since we decremented px this would be 2 cols to the right
  li    $t9, SKY          # $t9 stores the color of the sky to overwrite the last col
  jal   coord_to_offset   # $a0 stores the offset of the pickup
  sw    $t9, 8($v0)       # overwrite the last col mid row
  sw    $t9, -248($v0)    # overwrite the last col top row 8 - 256 = -248
  sw    $t9, 264($v0)     # overwrite the last col bottom row 8 + 256 = 264

  beq   $s6, 0, jcan      # if the pickup is a can, draw jerry can

  beq   $s6, 1, bomb      # if the pickup is a bomb, draw bomb

  enddraw:

  j		  sreturn           # return



  delpick:                  # deletes the pickup by overwriting it with the sky in all dirs
    li    $t9, SKY          # $t9 stores the color of the sky to overwrite the last col
    jal   coord_to_offset   # $a0 stores the offset of the pickup

    sw    $t9, 4($v0)       # overwrite the last col mid row
    sw    $t9, -252($v0)    # overwrite the last col top row 4 - 256 = -252
    sw    $t9, 260($v0)     # overwrite the last col bottom row 4 + 256 = 260
    sw    $t9, 0($v0)       # overwrite the mid col mid row
    sw    $t9, -256($v0)    # overwrite the mid col top row 0 - 256 = -256
    sw    $t9, 256($v0)     # overwrite the mid col bottom row 0 + 256 = 256
    sw    $t9, -4($v0)      # overwrite the first col mid row
    sw    $t9, -260($v0)    # overwrite the first col top row -4 - 256 = -260
    sw    $t9, 252($v0)     # overwrite the first col bottom row -4 + 256 = 252

    addi  $s6, $zero, -1    # $s6 stores -1
    sw    $s6, 8($s5)       # set the type of the pickup to -1
    j		  sreturn           # return

  jcan:
    addi  $s6, $zero, 0     # $s6 stores 0 to avoid infinite loop
    li    $t7, NOZZLE       # $t7 stores the color of the nozzle
    li    $t8, JCAN         # $t8 stores the color of the jerry can
    li    $t9, SKY          # $t9 stores the color of the sky

    # row 0
    sw    $t8, -260($v0)    # draw can
    sw    $t9, -256($v0)    # draw sky
    sw    $t7, -252($v0)    # draw nozzle
    # row 1
    sw    $t8, -4($v0)      # draw can
    sw    $t8, 0($v0)       # draw can
    sw    $t8, 4($v0)       # draw can
    # row 2
    sw    $t8, 252($v0)     # draw can
    sw    $t8, 256($v0)     # draw can
    sw    $t8, 260($v0)     # draw can

    j     enddraw           # return

  bomb:
    addi  $s6, $zero, 0     # $t4 stores 0 to avoid infinite loop
    li    $t7, FIRE         # $t7 stores the color of the fire
    li    $t8, BOMB         # $t8 stores the color of the bomb
    li    $t9, SKY          # $t9 stores the color of the sky

    # row 0
    sw    $t9, -260($v0)    # draw sky
    sw    $t7, -256($v0)    # draw fire
    sw    $t9, -252($v0)    # draw sky
    # row 1
    sw    $t8, -4($v0)      # draw bomb
    sw    $t8, 0($v0)       # draw bomb
    sw    $t8, 4($v0)       # draw bomb
    # row 2
    sw    $t8, 252($v0)     # draw bomb
    sw    $t8, 256($v0)     # draw bomb
    sw    $t8, 260($v0)     # draw bomb

    j     enddraw           # return

# will be called when spawning a new platform in platform_manager
# stack based calling convention
# this function doesn't mangle any registers since it uses the stack
spawn_pickup:             # spawns a random pickup at the given xy coords
  # pre: xy coords are valid
  # if theres an existing platform do nothing
  # $a0 is the x coord
  # $a1 is the y coord
  # spawns a pickup at the given pos with type randomly chosen

  # early return is pre stack $ra allocation
  lw    $s7, 8($s5)       # load the pickup type - nobody must rely on $s7
  bne   $s7, -1, return   # if the pickup exists, return

  addi  $sp, $sp, -4      # make space
  sw    $ra, 0($sp)       # store the return address

  addi  $sp, $sp, -4      # make space
  sw    $a0, 0($sp)       # store the old value of the reg we're using
  addi  $sp, $sp, -4      # make space
  sw    $a1, 0($sp)       # store the old value of the reg we're using
  addi  $sp, $sp, -4      # make space
  sw    $v0, 0($sp)       # store the old value of the reg we're using

  # since we want to draw it if it is valid we add 1 to the x coord and call pickup_manager
  # which resets it to the correct value and draws it
  addi  $a0, $a0, 1       # increment the pickup x coord
  sw    $a0, 0($s5)       # store the pickup x coord
  sw    $a1, 4($s5)       # store the pickup y coord

  li    $v0, 42           # load the syscall number for rng with max range
  li    $a0, 0            # load the id of the rng
  li    $a1, 2            # load the 2
  syscall                 # call the rng syscall the result is in $a0 - range: [0, 1]

  sw    $a0, 8($s5)       # store the pickup type
  jal   pickup_manager    # draw the pickup if possible

  lw    $v0, 0($sp)       # restore the old value of the reg we're using
  lw    $a1, 4($sp)       # restore the old value of the reg we're using
  lw    $a0, 8($sp)       # restore the old value of the reg we're using
  addi  $sp, $sp, 12      # free space

  j     sreturn           # return


# stack based calling convention
collect:                  # collect the pickup bookeeping - no args
  # the player isn't drawn yet so we can safely wipe out the pickup
  addi  $sp, $sp, -4      # make space
  sw    $ra, 0($sp)       # store the return address

  lw    $t7, 8($s5)       # load the pickup type

  addi  $t8, $zero, -1    # $t8 stores -1
  sw    $t8, 8($s5)       # store -1 in the pickup type

  addi  $sp, $sp, -4      # make space
  sw    $a0, 0($sp)       # store the old value of the reg we're using
  addi  $sp, $sp, -4      # make space
  sw    $a1, 0($sp)       # store the old value of the reg we're using

  lw    $a0, 0($s5)       # load the pickup x coord
  lw    $a1, 4($s5)       # load the pickup y coord
  jal   coord_to_offset   # convert the coords to an offset

  li    $t9, SKY          # $t9 stores the color of the sky

  sw    $t9, -260($v0)    # draw sky (0, 0)
  sw    $t9, -256($v0)    # draw sky (1, 0)
  sw    $t9, -252($v0)    # draw sky (2, 0)

  sw    $t9, -4($v0)      # draw sky (0, 1)
  sw    $t9, 0($v0)       # draw sky (1, 1)
  sw    $t9, 4($v0)       # draw sky (2, 1)

  sw    $t9, 252($v0)     # draw sky (0, 2)
  sw    $t9, 256($v0)     # draw sky (1, 2)
  sw    $t9, 260($v0)     # draw sky (2, 2)


  beq   $t7, 0, inc_score # if the pickup is a can, increase score

  # otherwise you hit a bomb
  addi  $sp, $sp, 8       # free space
  # we reclaim space because players can press p to restart
  # obviously the values themselves are useless at this point
  j		  lose              # lose

  inc_score:
    lw    $s7, 0($s4)     # load the score
    addi  $s7, $s7, 1     # increment the score
    sw    $s7, 0($s4)     # store the score
    lw    $a0, 0($sp)     # restore the old value of the reg we're using
    lw    $a1, 4($sp)     # restore the old value of the reg we're using
    addi  $sp, $sp, 8     # free space
    j     sreturn         # return

# ___________________________________________________________________________________________

# platforms

# |     <--    = = = = =   platform with len 5
# |            ^
# |      head of the platform
# | <- left screen border

# stack based calling convention
init_platforms:           # sets up the platforms for resets by setting them back to their initial state

  addi  $sp, $sp, -4      # allocate space for the return address
  sw    $ra, 0($sp)       # save the return address

  la    $t4, platforms    # $t4 stores the head address of the platforms[0]
  li    $t5, NO_PLATS     # $t5 stores the number of platforms

  # the platforms initials states are: ((x,y), len)
  # [((7, 32), 6), ((19, 32), 7), ((29, 29), 8), ((39, 40), 7), ((51, 30), 10), ...]
  # we do this manually

  addi  $t6, $zero, 6     # $t6 stores the length of the platform
  # platform 0
  addi  $a0, $zero, 7     # $a0 stores the x coord of the platform
  addi  $a1, $zero, 32    # $a1 stores the y coord of the platform
  jal   coord_to_offset   # $v0 stores the offset of the platform

  sw    $v0, 0($t4)       # store the offset in the platform list
  sw    $t6, 4($t4)       # store the length in the platform list

  addi  $t4, $t4, 8       # increment the pointer by 8 bytes
  subi  $t5, $t5, 1       # decrement the counter

  move  $a0, $v0          # setup print_platform offset
  move  $a1, $t6          # setup print_platform length
  jal   print_platform    # print the platform

  addi  $t6, $zero, 7     # $t6 stores the length of the platform
  # platform 1
  addi  $a0, $zero, 19    # $a0 stores the x coord of the platform
  addi  $a1, $zero, 32    # $a1 stores the y coord of the platform
  jal   coord_to_offset   # $v0 stores the offset of the platform

  sw    $v0, 0($t4)       # store the offset in the platform list
  sw    $t6, 4($t4)       # store the length in the platform list

  addi  $t4, $t4, 8       # increment the pointer by 8 bytes
  subi  $t5, $t5, 1       # decrement the counter

  move  $a0, $v0          # setup print_platform offset
  move  $a1, $t6          # setup print_platform length
  jal   print_platform    # print the platform


  addi  $t6, $zero, 8     # $t6 stores the length of the platform
  # platform 2
  addi  $a0, $zero, 29    # $a0 stores the x coord of the platform
  addi  $a1, $zero, 29    # $a1 stores the y coord of the platform
  jal   coord_to_offset   # $v0 stores the offset of the platform

  sw    $v0, 0($t4)       # store the offset in the platform list
  sw    $t6, 4($t4)       # store the length in the platform list

  addi  $t4, $t4, 8       # increment the pointer by 8 bytes
  subi  $t5, $t5, 1       # decrement the counter

  move  $a0, $v0          # setup print_platform offset
  move  $a1, $t6          # setup print_platform length
  jal   print_platform    # print the platform


  addi  $t6, $zero, 7     # $t6 stores the length of the platform
  # platform 3
  addi  $a0, $zero, 39    # $a0 stores the x coord of the platform
  addi  $a1, $zero, 40    # $a1 stores the y coord of the platform
  jal   coord_to_offset   # $v0 stores the offset of the platform

  sw    $v0, 0($t4)       # store the offset in the platform list
  sw    $t6, 4($t4)       # store the length in the platform list

  addi  $t4, $t4, 8       # increment the pointer by 8 bytes
  subi  $t5, $t5, 1       # decrement the counter

  move  $a0, $v0          # setup print_platform offset
  move  $a1, $t6          # setup print_platform length
  jal   print_platform    # print the platform


  addi  $t6, $zero, 10    # $t6 stores the length of the platform
  # platform 4
  addi  $a0, $zero, 51    # $a0 stores the x coord of the platform
  addi  $a1, $zero, 30    # $a1 stores the y coord of the platform
  jal   coord_to_offset   # $v0 stores the offset of the platform

  sw    $v0, 0($t4)       # store the offset in the platform list
  sw    $t6, 4($t4)       # store the length in the platform list

  addi  $t4, $t4, 8       # increment the pointer by 8 bytes
  subi  $t5, $t5, 1       # decrement the counter

  move  $a0, $v0          # setup print_platform offset
  move  $a1, $t6          # setup print_platform length
  jal   print_platform    # print the platform



  # set the rests' len to -1
  addi  $t7, $zero, -1    # $t7 stores the -1

  p_init:
    sw    $t7, 4($t4)       # store the -1 in the length
    addi  $t4, $t4, 8       # increment the pointer by 8 bytes
    addi  $t5, $t5, -1      # decrement the counter
    beq   $t5, $0, sreturn  # if counter is 0 then return

    j     p_init            # repeat


# stack based calling convention
platform_manager:         # deletes, makes, moves, draws new platforms - no args
  # load the platform list
  # iterate through the list reading the left most coordinate and length
  # convert to coord and let subroutines use the $v0 and $v1 registers to operate on
  # if left is on the left most col then delete the platform
  # if len = -1 then spawn a new platform with p 0.05 <- instant return here

  addi  $sp, $sp, -4      # allocate space for the return address
  sw    $ra, 0($sp)       # save the return address

  la    $t4, platforms    # $t4 stores the head address of the platforms[0]
  li    $t5, NO_PLATS     # $t5 stores the number of platforms

  plat_loop:

    lw    $a0, 0($t4)       # $a0 stores the offset of the left most coordinate
    jal   offset_to_coord   # convert the offset to coordinates. we do this once and let exists refer to it for performance
    lw    $t6, 4($t4)       # $t6 stores the length of the platform

    bne   $t6,-1,exists     # if the length is not -1 then we do the normal operations

    new:                      # decides whether to spawn a new platform
    # generate a 1/33 probability

      li    $v0, 42           # load the syscall number for rng with max range
      li    $a0, 0            # load the id of the rng
      li    $a1, 33           # load the upper bound
      syscall                 # call the rng syscall the result is in $a0

      # if the random number is 0 then we spawn a new platform
      bne   $a0,$zero,end     # if the random number is nonzero then we spawn a new platform

      spawn:                    # actually spawns a new platform and draws its head
      # we spawn a new platform
      # use a rng to determine its y.

        # generate a length with range [6-15]
        li    $v0, 42           # load the syscall number for rng with max range
        li    $a0, 0            # load the id of the rng
        li    $a1, 10           # load the upper bound (excl). we'll shift right
        syscall                 # call the rng syscall. $a0 stores y coord
        addi  $t6,$a0,6         # $t6 has the length of the platform = $a0 + 4 so $t6 is in [6,15]

        # generate a y coord with range [12-50]
        li    $v0, 42           # load the syscall number for rng with max range
        li    $a0, 0            # load the id of the rng
        li    $a1, 39           # load the upper bound. not 50 since we shift
        syscall                 # call the rng syscall. $a0 stores y coord
        addi  $a0,$a0,12        # $a0 has the y coord of the platform = $a0 + 12 so $a0 is in [12,50]

        move  $a1, $a0          # $a1 stores the y coord
        addi  $a0,$zero,63      # prepare x coord
        jal   coord_to_offset   # convert the coordinates to an offset

        li    $t9, PLATFM       # $t9 stores the platfm color code
        sw    $t9, 0($v0)       # paint the square
        sw    $v0, 0($t4)       # store the offset of the head of platform in the platforms list

        addi  $a1, $a1, -2      # $a1 stores the y coord of origin of potential pickup
        div   $t8, $t6, 2       # $t8 = $t6 div 2 - about halfway
        mflo  $t8               # $t8 stores the result of the division
        add   $a0, $a0, $t8     # $a0 stores the x coord of origin of potential pickup
        jal   spawn_pickup      # spawn a pickup if there's none on screen

        j     end               # continue

      unreachable:

    exists:                 # the regular lifecycle of a platform
      move:                   # moves a platform to the left by one square
      # pre: none of the x-coords should be 0. delete takes care of that
      # we move the platform to the left by one coordinate
      # remember: $t4 is the current offset pointer, $t6 is the length, and $v0, $v1 are the coordinates

        lw    $t8, 0($t4)     # $t8 stores the offset of the left most coordinate
        addi  $t8, $t8,-4     # $t8 stores the offset of the square to the left of the head

        li    $t9, PLATFM     # $t9 stores the platfm color code
        sw    $t9, 0($t8)     # paint the square to the left of the head

        sw    $t8, 0($t4)     # store the offset of the left most coordinate in the platforms list
        subi  $v0, $v0, 1     # decrement the x coord

        # wipe out the old last el
        # iff the platform is not at the right most column (since that would loop around) and wipe ASTRO
        #  0  1  2  3 (len:4)
        #  ^      + 3 to get to the end

        add  $t9, $t6, $v0    # $t9 <- length + x coord
        subi $t9, $t9, 64     # $t9 <- length + x coord - 63 (this should be negative if the delete is needed)
        bgez $t9, skip        # if the delete is not needed then skip

        sll   $t9, $t6, 2     # $t9 stores the length in bytes = length * 4
        add   $t8, $t8, $t9   # $t8 stores the offset of the last el = (old head - 4) + length * 4

        li    $t9, SKY        # $t9 stores the sky color code
        sw    $t9, 0($t8)     # paint the square to the right of the tail sky

        skip:

      delete:                 # deletes the platform if it is at the left most column
      # we delete the platform if it is at the left border
      # decrement the length of the platform
      # when the length is decrememented to 0 we set the length to -1
      # remember: $t4 is the current offset pointer, $t6 is the length, and $v0, $v1 are the coordinates
        bne   $v0,$zero,end   # if the x coordinate is not 1 then we continue

        subi  $t6, $t6, 1     # decrement the length of the platform by 1
        lw    $t8, 0($t4)     # $t8 stores the offset of the left most coordinate

        li    $t9, ASTRO      # $t9 stores the astro color code
        sw    $t9, 0($t8)     # paint the square on the head as astro

        addi  $t8, $t8, 4     # $t8 stores the offset of the square to the right of the old head
        sw    $t8, 0($t4)     # set that as the new head into the platforms list

        # if the length is 0 then we set the length to -1
        bne   $t6,$zero,end   # if the length is not 0 then end normally
        li    $t6, -1         # otherwise set the length to -1 then end
        sw    $t9, 0($t8)     # plug last square ($t8 was incr by 4) as astro instead of sky

    end:                    # sets the length of the platform to $t6 from any changes made
      sw    $t6, 4($t4)     # store the length of the platform from delete/spawn
      subi  $t5, $t5, 1     # decrement the number of platforms to loop through
      addi  $t4, $t4, 8     # increment the address of the platform to the newest platform
      beq   $t5, $0,sreturn # if we've iterated through all the platforms then we return
      j     plat_loop       # continue the loop



# uses register calling convention
print_platform:           # takes in offset and length as arguments
  # use $a0 - has to be normalized to display pointer: 10008000+ - and $a1 for len

  la    $t9, ($a0)        # $t9 stores the address of the offset
  li    $t8, PLATFM       # $t8 stores the platfm color code

  pp_loop:
    sw    $t8, 0($t9)       # paint the square
    addi  $t9, $t9, 4       # increment the address of the offset
    addi  $a1, $a1, -1      # decrement the length by 1
    bgtz  $a1, pp_loop      # if length > 0 then goto loop

  j				return          # return


# ___________________________________________________________________________________________

# screen drawing


clear_screen:             # clears the screen - no args
  move  $t0, $s1          # $t0 stores the base address for display
  li    $t1, SKY          # $t1 stores the sky color code
  addi  $t2, $t0,16384    # $t2 stores the number of pixels in the screen

  loop:                     # paint an entire row at a time by unrolling the inner loop
    sw    $t1, 0($t0)		    # paint it
    sw    $t1, 4($t0)		    # paint it
    sw    $t1, 8($t0)		    # paint it
    sw    $t1, 12($t0)		  # paint it
    sw    $t1, 16($t0)		  # paint it
    sw    $t1, 20($t0)		  # paint it
    sw    $t1, 24($t0)		  # paint it
    sw    $t1, 28($t0)		  # paint it
    sw    $t1, 32($t0)		  # paint it
    sw    $t1, 36($t0)		  # paint it
    sw    $t1, 40($t0)		  # paint it
    sw    $t1, 44($t0)		  # paint it
    sw    $t1, 48($t0)		  # paint it
    sw    $t1, 52($t0)		  # paint it
    sw    $t1, 56($t0)		  # paint it
    sw    $t1, 60($t0)		  # paint it
    sw    $t1, 64($t0)		  # paint it
    sw    $t1, 68($t0)		  # paint it
    sw    $t1, 72($t0)		  # paint it
    sw    $t1, 76($t0)		  # paint it
    sw    $t1, 80($t0)		  # paint it
    sw    $t1, 84($t0)		  # paint it
    sw    $t1, 88($t0)		  # paint it
    sw    $t1, 92($t0)		  # paint it
    sw    $t1, 96($t0)		  # paint it
    sw    $t1, 100($t0)		  # paint it
    sw    $t1, 104($t0)		  # paint it
    sw    $t1, 108($t0)		  # paint it
    sw    $t1, 112($t0)		  # paint it
    sw    $t1, 116($t0)		  # paint it
    sw    $t1, 120($t0)		  # paint it
    sw    $t1, 124($t0)		  # paint it
    sw    $t1, 128($t0)		  # paint it
    sw    $t1, 132($t0)		  # paint it
    sw    $t1, 136($t0)		  # paint it
    sw    $t1, 140($t0)		  # paint it
    sw    $t1, 144($t0)		  # paint it
    sw    $t1, 148($t0)		  # paint it
    sw    $t1, 152($t0)		  # paint it
    sw    $t1, 156($t0)		  # paint it
    sw    $t1, 160($t0)		  # paint it
    sw    $t1, 164($t0)		  # paint it
    sw    $t1, 168($t0)		  # paint it
    sw    $t1, 172($t0)		  # paint it
    sw    $t1, 176($t0)		  # paint it
    sw    $t1, 180($t0)		  # paint it
    sw    $t1, 184($t0)		  # paint it
    sw    $t1, 188($t0)		  # paint it
    sw    $t1, 192($t0)		  # paint it
    sw    $t1, 196($t0)		  # paint it
    sw    $t1, 200($t0)		  # paint it
    sw    $t1, 204($t0)		  # paint it
    sw    $t1, 208($t0)		  # paint it
    sw    $t1, 212($t0)		  # paint it
    sw    $t1, 216($t0)		  # paint it
    sw    $t1, 220($t0)		  # paint it
    sw    $t1, 224($t0)		  # paint it
    sw    $t1, 228($t0)		  # paint it
    sw    $t1, 232($t0)		  # paint it
    sw    $t1, 236($t0)		  # paint it
    sw    $t1, 240($t0)		  # paint it
    sw    $t1, 244($t0)		  # paint it
    sw    $t1, 248($t0)		  # paint it
    sw    $t1, 252($t0)		  # paint it
    addi  $t0, $t0, 256     # increment the address by 256 - 1 row
    bge   $t0, $t2, return	# if painted >= max pixels then goto return

  j     loop        		  # else paint the next row



# stack based calling convention
background:               # draws the background - no args
  # first col is all astro
  # second col is astro centered at y=32 with height 28 on both sides. ie the top and bottom 3 are sky
  # bottom row is all clouds
  # row above bottom is cloud and sky interspersed
  # rest is all sky

  addi  $sp, $sp, -4      # decrement the stack pointer by 4
  sw    $ra, 0($sp)       # store the return address

  jal   clear_screen      # paints everything SKY

  clouds:                   # draw the cloud cover at the bottom

    li    $t7, CLOUD        # $t7 stores the cloud color code

    addi  $a0, $zero, 0     # $a0 stores the x coord - first col
    addi  $a1, $zero, 63    # $a1 stores the y coord - last row
    jal   coord_to_offset   # convert the coordinates to an offset

    li    $t3, 64           # $t2 stores the max x coord (excl)
    cfill:                    # fill the bottom row and the row above it with clouds
      # the above row only fills in an alternating fashion with n clouds per period
      # n is determined randomly
      # generate n with range [2-5]
      move  $t6, $v0          # temp register
      li    $v0, 42           # load the syscall number for rng with max range
      li    $a0, 0            # load the id of the rng
      li    $a1, 3            # load the upper bound
      syscall                 # call the rng syscall. $a0 stores n
      addi  $a0, $a0, 2       # increment n by 1 so the range is [2-5]
      move  $v0, $t6          # restore the offset

      addi  $t6, $v0, -252    # $t6 stores the offset of the square above and right

      sw    $t7, 0($v0)       # paint the square
      sw    $t7, 4($v0)       # paint the next square
      sw    $t7, 8($v0)       # paint the next square
      sw    $t7, 12($v0)      # paint the next square
      sw    $t7, 16($v0)      # paint the next square
      sw    $t7, 20($v0)      # paint the next square
      sw    $t7, 24($v0)      # paint the next square
      sw    $t7, 28($v0)      # paint the next square

      upper:
        sw    $t7, 0($t6)       # paint the above square
        addi  $t6, $t6, 4       # increment the offset by 4
        addi  $a0, $a0, -1      # decrement n
        bgt   $a0, $zero,upper  # if n > 0 then goto upper


      subi  $t3, $t3, 8       # decrement the x coord by 8
      addi  $v0, $v0, 32      # increment the offset by 32

      # its fine if we overshoot and fill some extra stuff that's not in display
      # that data area is never used anyways

      bgtz  $t3, cfill        # if x coord > 0 then goto fill

  endclouds:                # end clouds

  bhole:                    # draws the black hole on the left

    li    $t7, ASTRO        # $t7 stores the astro color code

    addi  $a0, $zero, 0     # $a0 stores the x coord - first col
    addi  $a1, $zero, 0     # $a1 stores the y coord - first row
    addi	$v0,$0,BASE_ADDR  # skip the coord_to_offset step since we know this already

    sw    $t7, 0($v0)       # paint the square
    sw    $t7, 256($v0)     # paint the square below
    sw    $t7, 512($v0)     # paint the square below

    addi  $a1, $0, 61       # set the y coord to 61
    jal   coord_to_offset   # convert the coordinates to an offset

    sw    $t7, 0($v0)       # paint the square
    sw    $t7, 256($v0)     # paint the square below
    sw    $t7, 512($v0)     # paint the square below


    li    $t5, 60           # $t5 stores the max y coord (incl.) for the second col
    addi  $a1, $zero, 3     # set the y coord to 3
    bhfill:                   # now do the second and first col at the same time
      jal   coord_to_offset   # convert the coordinates to an offset

      sw    $t7, 0($v0)       # paint the square
      sw    $t7, 4($v0)       # paint the square 2nd col

      addi  $a1, $a1, 1       # increment the y coord

      ble   $a1, $t5, bhfill  # if y coord <= max y coord then goto fill

  endbhole:                 # end of the black hole

  j     sreturn            # return


# ___________________________________________________________________________________________

# utils


sreturn:                  # stack based return
  lw    $ra, 0($sp)       # load the return address from the stack
  addi  $sp, $sp, 4       # reclaim the stack space
  jr		$ra               # jump to $ra

return:                   # register based return
  jr		$ra               # jump to $ra




# ___________________________________________________________________________________________
# -------------------------------------------------------------------------------------------
