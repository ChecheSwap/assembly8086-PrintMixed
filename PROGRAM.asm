   
    
GETVALUES MACRO
       
    MOV AH, 0AH
    INT 21H 
    
ENDM    

SETBACKGROUNDCOLOR MACRO X  
    
    MOV AH, 06H    
    XOR AL, AL     
    XOR CX, CX     
    MOV DX, 4F4FH  
    MOV BH, X    
    INT 10H  
                
                
    MOV AH, 02H
    MOV DH, 0H
    MOV DL, 0H
    MOV BH, 00H 
    INT 10H  

ENDM   

ENDL MACRO

    MOV AH,09H
    LEA DX, NLINE
    INT 21H

ENDM   

SETANDPRINT MACRO MSG,BYROW, BYCOL

    MOV AH, 02H  
    MOV DH, BYROW
    MOV DL, BYCOL
    MOV BH, 00H 
    INT 10H  
    
    PUSH CX  
    
    MOV AH, 09H
    MOV AL, MSG
    MOV BH, 00H 
    MOV BL, INITCOLOR
    MOV CX, 1H
    INT 10H
    
    POP CX    
    
ENDM 

ONLYPRINT MACRO MSG
    
    MOV AH, 09H
    LEA DX, MSG
    INT 21H    
    
ENDM   

DELAY MACRO

MOV AH, 86H 
MOV CX, 001eH
MOV DX, 8480H 
INT 15H   
    
ENDM  

MYNAME MACRO
    MOV AH, 02H
    MOV BH, 00H
    MOV DH, 23D
    MOV DL, 44D
    INT 10H
    
    MOV AH, 09H
    LEA DX, ANAME
    INT 21H
ENDM


ORG 100H  

JMP START
    
    VEC1 DB 13,0,13 DUP(0)     
    VEC2 DB 13,0,13 DUP(0) 
    VECR DB 24 DUP(0)
    
    INITCOLOR DB 10011111B  
     
    
    F1 DB 00001111B
    F2 DB 11101100B
    F3 DB 11111001B
    
    CONT DB 0 
    NLINE DB 0AH,0DH,"$"  
    
    COL DB 0
     
    OP0 DB "-Configuracion de Colores...$" 
    OP1 DB "1.- FONDO NEGRO, LETRAS BLANCAS$"
    OP2 DB "2.- FONDO AMARILLO, LETRAS ROJAS$"
    OP3 DB "3.- FONDO BLANCO, LETRAS AZULES$"
    OP4 DB "4.- MANTENER ESTILO$"
    OP5 DB ">>INGRESE OPCION:$"     
    
    STRING1 DB "Ingrese String #1: $"
    STRING2 DB "Ingrese String #2: $"
    ALERT DB "->OPCION INVALIDA$"   
    
    ANAME DB "(Code By:Jesus Jose Navarrete Baca)$"
    
    FLAG DB 0

    
    START:  
    
    CALL INITIALCOMMIT
    
    
    ONLYPRINT STRING1         
    LEA DX, VEC1
    GETVALUES 
    
    ENDL
        
    ONLYPRINT STRING2
    LEA DX, VEC2
    GETVALUES
    
        
        LEA DI,VECR

        
        LEA BP,VEC1
        
        INC BP 
        
        XOR CX,CX  
        
        MOV CL, [BP]  
        
        INC BP
 
        
            CHARGE_FIRST:  
            
            MOV AX, [BP]
            
            MOV [DI], AX
            
            INC DI 
            
            INC BP  
            
            INC CONT
           
            
            LOOP CHARGE_FIRST  
            
            
                XOR BX,BX
                
                LEA BX, VEC2  
                
                XOR CX,CX   
                
                INC BX
                
                MOV CL, [BX]
                                
                INC BX
                
                
                CHARGE_SECOND:
                
                MOV AX, [BX]
                
                MOV [DI], AX
                
                INC BX
                
                INC DI 
                
                INC CONT 
                
                LOOP CHARGE_SECOND 
                    
                
                XOR CX,CX
                
                MOV CL, CONT
                
                XOR SI,SI  
                
                LEA BP, VECR  
   
                
                    PUTTHEM:    
                        MOV SI, CX
                    
                        PUSH [BP+SI-1]
                        
                    LOOP PUTTHEM 
                    
                    
                SETBACKGROUNDCOLOR INITCOLOR 
                
                XOR CX,CX  
                
                XOR AX, AX
                                                                
                MOV CL, CONT 
                                
                
                GET:
                
                POP AX  
                
                SETANDPRINT AL, COL, COL
                INC COL 
                
                LOOP GET  
                
                MYNAME
                
                HLT 
                    RET 
                                                             
                       
                       PROC INITIALCOMMIT 

                        READY:
                        
                          SETBACKGROUNDCOLOR INITCOLOR 
                        
                          ONLYPRINT OP0
                          ENDL
                          ONLYPRINT OP1
                          ENDL
                          ONLYPRINT OP2
                          ENDL
                          ONLYPRINT OP3
                          ENDL
                          ONLYPRINT OP4
                          ENDL
                          ONLYPRINT OP5
                          
                          MOV AH, 01H
                          INT 21H
                          
                          CMP AL,31H
                          JE O1
                          CMP AL, 32H
                          JE O2
                          CMP AL,33H
                          JE O3
                          CMP AL, 34H
                          JE O4 
                          CMP FLAG, 00H
                          JE O5 
                          
                          RET
                          
                        INITIALCOMMIT ENDP                           
                                              
                       
                        PROC O1
                        
                            SETBACKGROUNDCOLOR F1
                            LEA SI,INITCOLOR 
                            MOV AL, F1
                            MOV [SI],AL
                            INC FLAG
                            
                            RET    
                        ENDP
                       
                        PROC O2 
                            
                            SETBACKGROUNDCOLOR F2 
                            LEA SI,INITCOLOR 
                            MOV AL, F2
                            MOV [SI],AL 
                            INC FLAG   
                            
                            RET    
                        ENDP
                        
                         PROC O3
                            
                            SETBACKGROUNDCOLOR F3 
                            LEA SI,INITCOLOR 
                            MOV AL, F3
                            MOV [SI],AL                            
                            INC FLAG 
                            
                            RET    
                         ENDP 
                         PROC O4
                            
                            SETBACKGROUNDCOLOR INITCOLOR 
                            INC FLAG
                            
                            RET    
                         ENDP 
                         PROC O5
                             
                            ENDL 
                            ENDL                          
                            
                            ONLYPRINT ALERT    
                            
                            DELAY
                            
                            MOV FLAG, 0H 
                            
                            JMP READY                            
                            
                               
                         ENDP                         
                                                   
                          
                        
