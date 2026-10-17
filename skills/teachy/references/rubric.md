# Teachy process rubric

The grade is mostly about *how* the learner got there, not only *whether* they got there.
A learner who reaches a wrong answer through careful hypothesis-testing has learned more
than one who pasted something that happens to work. The weights reflect that.

Score each dimension 0–4, then compute the weighted total out of 100.

| # | Dimension | Weight | What you're looking for |
|---|-----------|--------|-------------------------|
| 1 | Understanding the problem | 15 | Restated the goal, asked clarifying questions, identified inputs/outputs/edge cases before diving in |
| 2 | Planning & decomposition | 15 | Broke the task into steps, started with the smallest working piece, had a direction rather than random edits |
| 3 | Experimentation | 20 | Ran small experiments, printed/inspected things, tested guesses, built up from something that works |
| 4 | Debugging & recovery | 15 | When stuck or wrong: read the error, formed a hypothesis, narrowed it down; didn't thrash or undo everything blindly |
| 5 | Independence & use of hints | 10 | Moved forward with few or shallow hints; when given a hint, *used* it to reason rather than waiting for the next one |
| 6 | Final result | 15 | Correctness, handles the edge cases named in the task, readable |
| 7 | Reflection | 10 | Can explain why it works, what they'd do differently, what tripped them up |

Score anchors (apply to every dimension):

- **4**: strong, deliberate, would impress a senior practitioner
- **3**: solid, with minor gaps
- **2**: present but inconsistent, or only after prompting
- **1**: barely visible
- **0**: absent

Weighted total = Σ (score / 4 × weight).

## Hint level and the Independence score

Use the hint log from `.teachy/session.md`:

- No hints, or only level-1 nudges → 4
- A couple of level-1/2 hints, used well → 3
- Level-3 hints, or many level-1/2 → 2
- Repeated level-4 hints → 1
- Kept pushing for the answer instead of engaging with hints → 0–1

How the learner *responded* to a hint matters as much as how many they got. A level-3 hint that
the learner turned into their own experiment counts for more than a level-1 hint they ignored.

## Evidence rules

Every score needs evidence: cite a snapshot timestamp, a diff, or something the learner said.
"Good experimentation" alone doesn't help them. Write something like "At 17:42 you added a print
of `cache` to see why the second call recomputed. That's exactly the right instinct."

If you have no evidence for a dimension (e.g. the learner never talked about their plan),
score what you can see, and say that the score is limited by missing evidence. This tells them
that thinking out loud would help next time.

## Report template

```markdown
# Teachy report — <topic>: <task title>

**Process grade: <total>/100  (<letter>)**
Letter: 90+ A, 80+ B, 70+ C, 60+ D, else F

## How your session unfolded
<A short narrative timeline built from snapshots and the session log: where you started,
key turning points, where you got stuck, what unstuck you. 5–10 bullets with timestamps.>

## Scores
| Dimension | Score | Evidence |
|---|---|---|
| Understanding the problem | x/4 | ... |
| ... | | |

## What you did well
<2–3 specific behaviours worth repeating>

## What to work on next
<2–3 specific process habits, each with a concrete "next time, try ..." suggestion>

## Remaining issues in your solution
<Point out what's still wrong or missing as questions or observations, never as corrected code.
e.g. "What happens if the list is empty?" not "add `if not xs: return 0`".>

## Suggested next challenge
<One follow-up task that targets the weakest dimension>
```
