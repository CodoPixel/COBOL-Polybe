identification division.
program-id. Polybe.
data division.
working-storage section.
01 PolybeLength pic 9 value 5.
01 Alpha pic A(25) value "ABCDEFGHIJKLMNOPQRSTUVXYZ".
01 Square pic A(25).
01 PlainMessage pic A(256).
01 FormattedPlainMessage pic A(256).
01 Letter pic A.
01 JumpSpace pic 9 value 0.
01 foundLetter pic 9 value 0.
01 i pic 9 value 0.
01 y pic 9 value 0.
01 indexInAlpha pic 999 value 0.
01 indexInMessage pic 999 value 0.
01 letterX pic 9 value 0.
01 letterY pic 9 value 0.

procedure division.
display "Bienvenue dans le jeu de Polybe".
display "-------------------------------".
string Alpha delimited by size into Square.
perform ShowSquare.
display "Message à encrypter : " with no advancing.
accept PlainMessage.
move function upper-case(PlainMessage) to PlainMessage.
inspect PlainMessage replacing all 'W' by 'V'.
perform EncryptMessage.
stop run.

ShowSquare.
    display " |" with no advancing.
    perform varying i from 0 by 1 until i equals PolybeLength
        display i " " with no advancing
    end-perform.
    display " ".
    display "--" with no advancing.
    perform varying i from 0 by 1 until i equals PolybeLength
        display "--" with no advancing
    end-perform.
    display " ".
    perform varying i from 0 by 1 until i equals PolybeLength
        display i "|" with no advancing
        perform varying y from i by 1 until y equals PolybeLength + i
            display Square(1+y+i*4:1) " " with no advancing
        end-perform
        display " "
    end-perform.
    display " ".
    move 0 to y.
    move 0 to i.

EncryptLetter.
    move 0 to foundLetter.
    move 0 to indexInAlpha.
    perform until foundLetter equals 1
        evaluate Letter
            when Square(1+indexInAlpha:1)
                divide indexInAlpha by 5 giving letterX remainder letterY
                display letterX letterY space with no advancing
                move 1 to foundLetter
            when other
                add 1 to indexInAlpha
    end-perform.

EncryptMessage.
    perform varying indexInMessage from 1 by 1 until indexInMessage equals function length(PlainMessage)
        move PlainMessage(indexInMessage:1) to Letter
        evaluate true
            when Letter is not equal to space
                perform EncryptLetter
        end-evaluate
    end-perform.
    display " ".
