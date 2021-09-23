
1.0.0 / 2021-09-23

  * (BREAKING) chore: pins `pre-commit-hooks` to `v4.0.1`.
  * (BREAKING) chore: pins `kubernetes` provider to `2.x+`.
  * (BREAKING) chore: pins `random` provider to `3.x+`.
  * (BREAKING) chore: pins `azurerm` provider to `2.x+`.
  * refactor: use kind for running example.
  * fix: build failure, for some reasons the namespace deletion timeout.
         this is a known issue (e.g. stack overflow, GitHub, ...) and this is something happening randomly.
         as a workaround, I temporarily got rid of that namespace, and will troubleshoot this + fix later.
  * feat: add `pre-commit-afcmf` (`v0.1.2`).
  * chore: pins `pre-commit-terraform` to `v1.50.0`.

0.2.0 / 2020-02-17
==================

  * feat: Add toleration

0.1.0 / 2020-02-14
==================

  * feat: Initial version of the module
  * Initial commit
