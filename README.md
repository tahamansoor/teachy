<p align="center">
  <img src="teachy.png" alt="teachy" width="100">
</p>

# Teachy 

**Teachy** is an automated, hands-on tutor mode designed for AI agents. Rather than providing quick answers or writing code for the user, Teachy creates real-world learning tasks, continuously monitors the learner's workspace in the background, provides graduated hints when they get stuck, and evaluates their complete problem-solving methodology (planning, debugging, use of hints, and reflection).

---

##  Core Philosophy

> **You are a tutor, not a solver.**

A finished solution takes away the exact value the learner came for—the productive struggle. Teachy adheres to **one hard rule: No solutions.** 

It will never write code, provide copy-pasteable answers, or edit working files for the learner. Even when pushed, Teachy offers concept explanations, Socratic questions, documentation pointers, or analogies instead of direct code fixes.

---

## Features

- **Hands-On Task Design**: Generates a dedicated `TASK.md` featuring directed experiments and clear "Done when" criteria.
- **Background File Watching**: Continuously monitors working files (`idle_seconds`, `max_seconds`) and triggers interventions based on progress diffs.
- **Graduated Hint Ladder**: Delivers progressive support only as needed:
  1. **Nudge**: Directs attention (*"What do you expect `x` to be on line 12?"*)
  2. **Locate**: Pinpoints the area (*"The issue is in how `total` is updated."*)
  3. **Concept**: Explains the underlying tool or pattern (*"This is a job for a cache dictionary..."*)
  4. **Analogy**: Provides a minimal example on an unrelated problem.
- **Process-Based Evaluation**: Assesses independence, experimental habits, and reflection, generating detailed markdown reports at the end of each session.

---

## Session Flow

1. **Intake**: A brief 1-message exchange to establish topic, skill level, available time, and preferred workspace environment.
2. **Task Creation**: Generates `TASK.md` with explicit objectives, 3–5 exploration experiments, and checkable success criteria.
3. **Session Monitoring**:
   - Initializes `.teachy/session.md` log.
   - Captures a baseline snapshot (`START`).
   - Launches a background file watcher (`watch.sh`).
4. **Interventions**: Responds dynamically based on watcher status (`IDLE`, `CHECKIN`, `STOPPED`):
   - *Steady Progress*: Minimal acknowledgment or quiet observation.
   - *Going in Circles*: Socratic questioning on intent.
   - *Broken Code / Stalled*: Graduated level-1 hint offer.
5. **Grading & Reflection**: Concludes with 2–3 reflection questions and generates an evidence-backed score report (`.teachy/report-<date>.md`).

---

## 🛠 Learner Commands

Learners can use these commands at any point during a active session:

| Command | Action |
| :--- | :--- |
| `hint` | Request the next level on the hint ladder. |
| `check` | Trigger an immediate snapshot (`MANUAL`) and get conceptual feedback. |
| `pause` | Temporarily halt background file monitoring (`touch .teachy/STOP`). |
| `resume` | Relaunch the background file watcher. |
| `done` | Stop monitoring and proceed directly to post-task reflection and grading. |

---

## 🗂 File Structure

When a Teachy session begins, the following directory structure is maintained in the user's workspace:

```text
.
├── TASK.md                      # Primary task description, experiments, and rules
├── <working-file>               # User's active workspace (e.g., solution.py)
└── .teachy/                     # Teachy internal tracking directory
    ├── session.md               # Continuous session observations and hints log
    ├── report-YYYYMMDD-HHMM.md  # Final evaluation report
    └── snapshots/               # Diff history and state logs
        └── INDEX.log
```

---

## Tone & Coaching Style

- **Warm, Curious, and Concise**: Keeps interventions brief to preserve learner focus.
- **Data-Driven Feedback**: Treats mistakes as data points; praises specific actions (*"You isolated the bug with an empty list first"*) rather than general ability.
- **Firm Boundaries**: Acknowledges user frustration empathetically while holding the no-solution line firm.
