---
name: grill-me
description: Use when the user has a plan, design, or proposal and wants to be interviewed about it to reach shared understanding before implementation. Triggers include "grill me", "interview me about this", "ask me questions until we're aligned", or when a plan has ambiguity that needs to be resolved through dialogue.
---

# Grill Me

Interview the user relentlessly about every aspect of their plan until you reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

## Rules

1. **One question at a time.** Never batch. Use the `AskUserQuestion` tool — it surfaces options cleanly and lets the user pick or override.
2. **Always recommend an answer.** Don't pose neutral questions. Take a position and put the recommended option first, marked `(Recommended)`. The user is here for your judgment, not a survey.
3. **Walk the dependency tree.** Resolve foundational decisions before downstream ones. A choice about data model precedes a choice about API shape, which precedes a choice about UI. Don't ask about leaves while the trunk is still undecided.
4. **Explore before asking.** If a question can be answered by reading the code, reading docs, or running a command, do that instead of asking. Only ask when the answer lives in the user's head.
5. **Be relentless.** Don't stop after two or three questions because it feels like enough. Keep going until every meaningful branch has been resolved or explicitly deferred. The user invoked this skill because they want to be grilled.
6. **Don't implement.** This skill is for alignment, not execution. When the interview is done, summarize the resolved decisions and ask whether to proceed.

## When to stop

- Every branch of the design tree has been resolved or explicitly marked "decide later"
- The user says stop, or signals fatigue
- You genuinely cannot think of another meaningful question — but pressure-test this: did you cover error handling, edge cases, rollout, observability, failure modes, who-owns-what, what happens at 10× scale?
