// GLOBAL VARIABLES
VAR dayCount = 0
VAR strength = 0
VAR intelligence = 0
VAR hasTrinket = false
VAR hasPager = false

// Passage visit flags
VAR visitedStart = false
VAR cityExploration = false
VAR visitedHome = false
VAR visitedUpgrade = false


-> dayStart
=== dayStart ===
~ dayCount = dayCount + 1
-> start

=== start ===
{ visitedStart:
    // Shorter repeat text after first visit
    It is day {dayCount}. This is oddly familiar...
- else:
    // First-time visit detailed description
    You wake up in your room as the sunlight illuminates your room. You feel like something big is going to happen today.
    ~ visitedStart = true
}
-> firstChoice

=== firstChoice ===
You feel productive today. Of the two choices you can only choose one
+   [Explore the city] -> exploreCity
+   [Stay home and clean up around the house] -> stayHome

=== exploreCity ===
{ cityExploration:
    You step back onto the familiar streets. As similar as it looks from last time, you keep your head on a swivel looking for clues.
- else:
    You step out into the city, it's all the same as always. Yet something feels different...
    ~ cityExploration = true
}
{hasTrinket == false: As you walk around the city, you find an odd trinket on the ground.}
*   [Pick up the trinket] 
    ~ hasTrinket = true
    You take the trinket. It doesn't seem like much but it does look interesting.
    -> midDay
+   [Continue exploring] 
    You move on with your day.
    -> midDay

=== stayHome ===
{ visitedHome:
    The room is as you left it last time, yet you are determined to find new clues.
- else:
    As you clean around the house, you see an old journal that mentions the "Z3R0 Pager".
    ~ visitedHome = true
}
+   [Search for the Z3R0 Pager] 
    -> pager
+   [Study the journal more] 
    -> studyJournal

=== pager ===
You climb into the attic and find a pager with webs all over it.
*   [Take the Z3R0 Pager] 
    ~ hasPager = true
    You now posses the pager. You're not sure what it does but it seems valuable
    -> midDay
+   [Leave it] 
    You don't think much of it and leave it.
    -> midDay

=== studyJournal ===
You continue reading the journal. As you continue reading, you gain more and more knowledge.
+  [Keep reading] 
    -> statUpgrade
+   [Put the journal down and prepare for the day] 
    -> midDay

=== statUpgrade ===
{ visitedUpgrade:
    You read the journal again and go further in depth than last time.
- else:
    This is your chance to improve.
    ~ visitedUpgrade = true
}
+   [Increase strength (current: {strength})] 
    ~ strength = strength + 1
    The journal floats as you feel a surge of power.
    -> midDay
+   [Increase intelligence (current: {intelligence})] 
    ~ intelligence = intelligence + 1
    The journal floats as your mind sharpens
    -> midDay

=== midDay ===
The day progresses. There is a stranger who gives off a mysterious aura.
+  [Approach the mysterious stranger] 
    -> stranger
+   [Search for more clues on your own] 
    -> clueSearch

=== stranger ===
A hooded stranger greets you:
"I see you {hasTrinket: picked up the trinket} {hasTrinket == false: ignored the trinket} and {hasPager: secured Z3R0 Pager} {hasPager == false: passed on the pager}  
They pause, then add, "Your choices shape your fate..."
+   [Ask for more details] 
    -> strangerMeeting
+   [Dismiss the stranger and move on] 
    -> midDay2

=== clueSearch ===
While searching the busy streets, you find a note hinting at secret locations and abilities.  
{ hasTrinket:
    The note reminds you of the trinket you possess.
- else:
    The note mentions, "Only those who collect can see the hidden path."
}
+   [Follow the note's directions] 
    -> doorRoll
+   [Ignore the note] 
    -> midDay2

=== midDay2 ===
The day grows longer and you yourself have grown tired. 
+   [Rest and reflect on your decisions so far] 
    -> reflection
+   [Proceed to your next challenge] 
    -> strengthRoll

=== strangerMeeting ===
The stranger leads you to an open area with a singular door. "Your journey is affected by your possessions and abilities," they whisper.
{ hasPager:
    "The Z3R0 Pager will grant you an opportunity at opening the door."
- else:
    "Without a tool, the door will remain closed."
}
+   [Attempt to open the door] 
    -> doorRoll
+   [Thank the stranger and leave] 
    -> midDay2

=== doorRoll ===
You stand before a mysterious door.
{ strength >= 1 && hasPager:
    You use use your sheer strength to brute force the door open.
    -> endScene
- else:
    { intelligence >= 1 && hasPager:
        You look closely at the door. An astute observation reveals a hidden mechanism. With almost no effort, you unlock the door.
        -> endScene
    - else:
        The door resists your attempts. You realize you may need to upgrade your abilities or find a special item.
        -> midDay2
    }
}

=== strengthRoll ===
A massive mutant blocks your path.  
{ strength >= 2:
    With your enhanced strength, you overpower the figure.
    -> endScene
- else:
    The mutant is much too powerful. You go back to the drawing board.
    -> midDay2
}

=== reflection ===
You take a quiet moment to reflect on the day:
- {hasTrinket: You look at the trinket's mysterious glow.}
- {hasPager: You brainstorm the use of the pager.}
- You notice that your abilities (Strength: {strength}, Intelligence: {intelligence}) have grown from your choices.
Your reflections give you insight.
-> dayReset

=== endScene ===
As you step through the door, a cascade of memories and futures floods your mind. 
{ hasTrinket:
    The trinket you picked up shines brightly as you begin to remember ancient memories.
}
{ hasPager:
    The Z3R0 Pager at your side beeps as you begin to remember memories of the future.
}
Your journey is far from over...
+ [Reset the day]
-> dayReset

=== dayReset ===
Night falls as the day reaches its end. The world shimmers and resets.
+ [Reset the day]
-> dayStart
