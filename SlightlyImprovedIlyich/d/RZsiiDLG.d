ADD_TRANS_ACTION ILYICH
BEGIN 1 2 3 END
BEGIN END
~SetGlobal("RZ_See_Enemy","LOCALS",1)SetGlobal("RZ_Under_Attack","MYAREA",1)~

ADD_TRANS_ACTION AATAQAH
BEGIN 3 16 END
BEGIN END
~SetGlobal("RZ_Start_Patrol","MYAREA",1)~

ADD_TRANS_ACTION IRETHF01
BEGIN 0 END
BEGIN END
~SetGlobal("RZ_SII_Golem_Wait","MYAREA",1)~

REPLACE_ACTION_TEXT SHAPE ~Polymorph(DOPPLEGANGER)~ ~Polymorph(DOPPLEGANGER_GREATER)~

REPLACE ~AATAQAH~
IF ~~ THEN BEGIN 12 // from: 14.0 11.0
  SAY #11528 /* ~Interesting.  No action can be performed without consequences. Especially that which follows the noble path. Deal with this, noble one!~ */
  IF ~~ THEN DO ~AddExperienceParty(3500)
ReallyForceSpell([PC],GENIE_LIMITED_WISH_HEAL_ALL)
PlaySound("EFF_M23C")
CreateVisualEffect("SPROTECT",[1899.2627])
SmallWait(10)
CreateVisualEffect("SPDISPMA",[1899.2627])
CreateCreature("RZSIIOGM",[1899.2627],0)
SetGlobal("AataqahFight","AR0602",1)
CreateVisualEffectObject("SPCLOUD2",Myself)
CreateVisualEffectObject("SPFLESHS",Myself)
PlaySound("EFF_M38")
SmallWait(10)
DestroySelf()
~ EXIT
END
END

REPLACE ~IMOENJ~
IF ~Global("RZ_SII_Jon_Room","AR0602",1)~ THEN BEGIN 60 // from:
  SAY #47215 /* ~Something strange up here. Be careful, this place has all manner of dangerous devices in it. I don't know what they do, but I know we would be safer if we shut them off.~ */
  IF ~~ THEN DO ~SetGlobal("RZ_SII_Jon_Room","AR0602",2)~ EXIT
END

IF ~Global("RZ_SII_Lightning","AR0602",1)~ THEN BEGIN 61
  SAY #47220 /* ~Do you smell that?  Smells like lightning, but indoors?  That can't be right.  I think I remember. Look to the right... the machine making the storm...~ */
  IF ~~ THEN DO ~SetGlobal("RZ_SII_Lightning","AR0602",2)~ EXIT
END
END

REPLACE ~JAHEIRAJ~
IF ~~ THEN BEGIN 9 // from: 11.0 8.0
  SAY #1144 /* ~Enough. I would leave this place.~ */
  IF ~~ THEN DO ~SetGlobal("SawKhalid","AR0603",1)SetGlobalTimer("RZ_SII_Saw_Khalid_Timer","AR0603",120)~ EXIT
END
END

BEGIN ~IRETHF03~

IF ~~ THEN BEGIN 0 // from:
  SAY #52381 /* ~Where is your master, fiend? We seek Irenicus. Give us the upstart and you shall survive!~ */
  IF ~~ THEN EXTERN ~VAMPIRE1~ 7
END

IF ~~ THEN BEGIN 1 // from:
  SAY #52389 /* ~Enough! Kill this creature and raze the guild. Irenicus shall learn of what it is to betray the Shadow Thieves!~ */
  IF ~~ THEN EXTERN ~VAMPIRE1~ 1
END

BEGIN ~VAMPIRE1~

IF ~Global("StartingDialogue","LOCALS",0)~ THEN BEGIN 0 // from:
  SAY #11903 /* ~Ah, excellent.  I see I am to be provided fresh blood, for once.~ */
  IF ~~ THEN DO ~SetGlobal("StartingDialogue","LOCALS",1)~ EXTERN ~IRETHF03~ 0
END

IF ~~ THEN BEGIN 1 // from:
  SAY #11906 /* ~We shall see, shall we not?  Come, my captor has fed me nothing but the lifeless and I hunger.~ */
  IF ~~ THEN DO ~ActionOverride("RZSHTH02",DialogueInterrupt(FALSE))ActionOverride("RZSHTH02",SetGlobal("RZDoNothing","LOCALS",1))
  ActionOverride("RZSHTH03",SetGlobal("RZDoNothing","LOCALS",1))
ActionOverride("RZSHTH03",DialogueInterrupt(FALSE))
ActionOverride("RZSHTH01",SetGlobal("RZDoNothing","LOCALS",1))
ActionOverride("RZSHTH01",DialogueInterrupt(FALSE))
~ EXIT
END

IF ~Global("StartingDialogue","LOCALS",1)~ THEN BEGIN 2 // from:
  SAY #11908 /* ~I am given little choice, my succulent mortal.  I am imprisoned here to serve the task of guardian.   You shall proceed no further.~ */
  IF ~~ THEN REPLY #11909 /* ~You are a prisoner here?  Why not help me and we can escape together!~ */ DO ~SetGlobal("StartingDialogue","LOCALS",2)~ GOTO 3
  IF ~~ THEN REPLY #12615 /* ~You are a slave?  Ha ha ha!  Obviously I have nothing to worry about!~ */ DO ~SetGlobal("StartingDialogue","LOCALS",2)~ GOTO 5
  IF ~~ THEN REPLY #12617 /* ~How is it that you came to be imprisoned here, vampire?~ */ DO ~SetGlobal("StartingDialogue","LOCALS",2)~ GOTO 6
END

IF ~~ THEN BEGIN 3 // from: 2.0
  SAY #12132 /* ~There is no escape, foolish one.  And I am afraid you are far too tasty a meal for me to pass up.~ */
  IF ~~ THEN DO ~Enemy()~ EXIT
END

IF ~~ THEN BEGIN 4 // from:
  SAY #12134 /* ~Really?  Well, I am impressed.  Fortunately, all your work has left you a physique which has stirred my hunger.~ */
  IF ~~ THEN DO ~Enemy()~ EXIT
END

IF ~~ THEN BEGIN 5 // from: 2.1
  SAY #12616 /* ~Better a slave than a slave's dinner, as you shall find out quickly enough!~ */
  IF ~~ THEN DO ~Enemy()~ EXIT
END

IF ~~ THEN BEGIN 6 // from: 2.2
  SAY #12618 /* ~Indeed, Irenicus is powerful.  I would kill him if I could, for he feeds me nothing but scraps and corpses.  Come, mortal, and let me feast upon the fresh blood of the living!~ */
  IF ~~ THEN DO ~Enemy()~ EXIT
END

IF ~~ THEN BEGIN 7 // from:
  SAY #52387 /* ~Already am I dead, thief. Join me in darkness...~ */
  IF ~~ THEN EXTERN ~IRETHF03~ 1
END
