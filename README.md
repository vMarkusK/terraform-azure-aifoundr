# terraform-azure-aifoundr

This repository contains an inlined, local copy of the AVM AI Foundry
module which was previously referenced as an external module
(`Azure/avm-ptn-aiml-ai-foundry/azurerm`). The local implementation is
found under `modules/ai_foundry/` and provides the subset of resources
and outputs required by the root configuration. This change makes the
repository self-contained for easier testing and modification.

Files of interest:
- `modules/ai_foundry/` - inlined module implementation (cognitive
	account, storage, key vault, cosmosdb placeholders and outputs)
- `aifoudry.tf` - root module usage of `module.ai_foundry` updated to
	reference the local module

Note: The inlined module is a compact implementation intended for
local development and testing. For production or feature parity with
the upstream AVM module, review and merge additional resources from
the original module as needed.