MODULE Module1
    CONST robtarget Target_10_2_2_6_2:=[[-29.454,16.952,60.588],[0.5,-0.5,0.5,-0.5],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_10_2_8_2:=[[30.546,16.952,60.588],[0.5,-0.5,0.5,-0.5],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_10_2_3_6_3:=[[30.546,16.952,120.588],[0.5,-0.5,0.5,-0.5],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_10_3_5_2_2:=[[290.546,68.777,176.825],[0.707106781,-0.707106781,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_10_3_2_4_2_2:=[[290.546,98.77699997,228.786524244],[0.422618262,-0.906307787,0,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: aksha
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC main()
        Path_10; 
    ENDPROC
    PROC Path_10()
        MoveJ Target_10_2_2_6_2,v1000,z100,GS25_Gripper_TCP\WObj:=Workobject_2;
        MoveL Target_10_2_8_2,v1000,z100,GS25_Gripper_TCP\WObj:=Workobject_2;
        MoveL Target_10_2_3_6_3,v1000,z100,GS25_Gripper_TCP\WObj:=Workobject_2;
        MoveL Target_10_3_5_2_2,v1000,z100,GS25_Gripper_TCP\WObj:=Workobject_2;
        MoveL Target_10_3_2_4_2_2,v1000,z100,GS25_Gripper_TCP\WObj:=Workobject_2;
        MoveL Target_10_2_3_6_3,v1000,z100,GS25_Gripper_TCP\WObj:=Workobject_2;
        MoveL Target_10_2_8_2,v1000,z100,GS25_Gripper_TCP\WObj:=Workobject_2;
        MoveL Target_10_2_2_6_2,v1000,z100,GS25_Gripper_TCP\WObj:=Workobject_2;
    ENDPROC
ENDMODULE