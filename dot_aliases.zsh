alias ls="exa"
alias sl="exa"
alias l="exa -alh"
alias tree="exa --tree"
alias tl="exa --tree --long"
alias lt=tl
alias vim=nvim
alias vi=nvim
alias python=/usr/bin/python3
alias pip=pip3

alias rm=trash 
alias s='source ~/.zshrc' && echo "sourced ~/.zshrc"

alias cat=bat
alias cd=z
alias zz=z -
alias ssh='TERM=xterm-256color ssh'

LEDGER_DIR="/Users/mateusz/Google\ Drive/My\ Drive/woik/ledger_test"

alias led="ledger -f ${LEDGER_DIR}/budget_journal.ldg"
alias bal="ledger -f ${LEDGER_DIR}/budget_journal.ldg balance"
alias reg="ledger -f ${LEDGER_DIR}/budget_journal.ldg reg"
alias net_worth="ledger -f ${LEDGER_DIR}/budget_journal.ldg balance Assets Liabilities"
alias cash_flow="ledger -f ${LEDGER_DIR}/budget_journal.ldg balance Income Expenses"
alias equity="ledger -f ${LEDGER_DIR}/budget_journal.ldg equity"
alias accounts="ledger -f ${LEDGER_DIR}/budget_journal.ldg accounts"
alias finance="vim ~/ledger_test/budget_journal.ldg"
# alias balance=$(ledger -f ${LEDGER_DIR}/budget_journal.ldg balance)
