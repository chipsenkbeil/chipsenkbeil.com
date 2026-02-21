# WRITING.md

This file provides guidance to Claude Code when writing blog posts, notes, and other content for chipsenkbeil.com. Read alongside `CLAUDE.md` for project-level context.

## Voice & Tone

- First-person, conversational but authoritative — sounds like talking to a colleague, not writing documentation
- Honest vulnerability without self-deprecation: "I'll admit...", "I didn't know...", "I won't pretend I'm an expert"
- Non-prescriptive: "this is how I approached it" not "this is how you should do it"
- Assume reader agency — link out rather than over-explain
- Show genuine enthusiasm for the subject without hype

> "I won't pretend that I am an expert on either GPG or Yubikey. Instead, I'll be focusing on how I have been using GPG and a variety of Yubikey devices to enhance my computer experience."

## Openings

- Lead with a concrete moment, problem, or personal anecdote — never definitions or background
- Establish context and stakes within the first 2-3 paragraphs
- The reader should know *why this matters* before learning *what it is*
- Strong hooks: a specific event, a frustration, a question that wouldn't go away

> "One of my biggest challenges to accomplishing something is the barrier to entry. Starting a project, exercising, and even writing this blog post take genuine effort for me to do."

## Structure & Flow

- 3-5 main sections per post; prefer fewer headers with longer flowing sections over many small fragments
- Narrative arc for project/journey posts: spark → deep learning → attempt → feedback → refinement → reflection
- Problem → solution → retrospective for how-to posts
- Transitions via rhetorical questions, forward references, or brief bridging sentences — not just headers
- Vary paragraph length: 3-7 sentences typical, shorter for impact, longer for reflection
- Target 2000-3000 words for long-form posts

## Technical Explanations

- Always ground technical content in narrative context — *why* before *how*
- One clean, annotated code example is better than three mediocre ones
- Introduce code blocks with purpose before showing them; follow with interpretation
- Assume some technical background but explain new or unfamiliar concepts
- Use inline code formatting (`=code=` in org-mode) for commands, file names, config values
- Ratio: ~60% explanation / 40% code in how-to posts; more explanation in narrative posts

## Sentence Craft

- Vary sentence length deliberately: short declarative sentences for impact, medium for explanation, long (with punctuation breaks) sparingly
- Use em dashes for inline clarification and flow
- Use parenthetical asides for secondary context
- Use italics for emphasis on key concepts, bold for important terms or calls to attention
- Rhetorical questions as bridges between ideas — use strategically, not habitually
- "Rather than..." constructions to contrast approaches

## Links & References

- Inline only — no footnotes or reference lists
- Always explain what the reader will find before or around the link
- Sparse but purposeful: ~1-3 per 500 words
- Link to genuinely relevant resources, never decoratively

## Closings

- End with personal reflection or forward-looking energy, not a summary of what was covered
- Invite engagement: link to follow, try, or contribute — without being pushy
- Acknowledge that the work continues; don't wrap everything in a neat bow
- The final paragraph should leave the reader with a feeling, not a recap

> "But this feels like a good place to pause the story. The API is clean, the community is engaged, and the feature is closer to landing than it's ever been."

## Honesty & Iteration

- Show the work, not just polished results — include failed attempts, false starts, community feedback
- Frame revision as positive: "the second attempt is cleaner because the first one existed"
- Admit uncertainty freely
- Treat past approaches as learning, never as failures to apologize for
- Acknowledge community, collaborators, and feedback gracefully

## What to Avoid

- Wall-of-text technical explanations without narrative grounding
- Prescriptive "you should" tone — show what works, let readers decide
- Over-explaining concepts the audience already knows
- Excessive code blocks — one good example beats three redundant ones
- Starting with definitions or background ("What is X?")
- Sales language, hype, or sensationalism
- Generic advice not grounded in personal experience
- Clickbait titles — titles should accurately describe content
- Excessive self-deprecation or apology
- Over-structuring with too many headers (prefer fewer, longer sections)
- Adding emojis or decorative formatting

## Content Types

- **Blog posts (long-form):** Full narrative arc, personal voice, 2000-3000 words
- **Series posts:** Each stands alone while contributing to whole; include links to previous/next; consistent voice across series
- **Quick reference notes:** No unnecessary introduction; title + brief context + code/commands; heavy code ratio; purpose is quick lookup
- **Documentation:** Clearer, more direct; less narrative; still first-person where appropriate
