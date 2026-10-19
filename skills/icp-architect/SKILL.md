---
name: icp-architect
slug: icp-architect
description: "Build an evidence-aware ideal customer profile from product knowledge and target market constraints."
version: 1.0.0
tool_dependencies: []
---

# ICP Architect

## Contract

Input: product/SKU, product use cases, target countries, company types, buyer titles and active Knowledge facts.

Output: a structured ICP with industry, company types, geography, buyer titles, use cases, positive/negative signals, fit rules and evidence requirements.

Every important fit decision must reference evidence or be marked as unknown. This skill does not send messages or change customer, inquiry or quote state.

## Runtime

A host runtime may implement this contract deterministically. Do not call or import a private application module; if no host tool exists, produce the ICP in the reply.
