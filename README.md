# mass dig
> dig the masses for fun and profit

## what
`mass-dig.sh` takes a list of possible domains and searches for [A records](https://support.dnsimple.com/articles/a-record/) quickly (by leveraging parallelism) using the `dig` command

## why
Presence of an A record can be used for TLD enumeration

## how
`./mass-dig.sh [TLD LIST] [THREADS (OPTIONAL)]`
Do not try to run with 'sh mass-dig.sh' there will likely be a syntax issue

The TLD list should be newline separated, I.E
```
website.com
website.co.uk
website.io
```

### results
The results are both
1. Found hosts are appended to a `known_hosts.dug` file
2. Each host's specific dig results are saved to a `[HOST].dug` file for further inspection
