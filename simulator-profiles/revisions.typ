#import "/common.typ": *
#let config = toml("revisions.toml")
#show: page-template
#set par(leading: 0.5em)
#set page(flipped: false)
#page-header(config.metadata.group + " — Record of Revisions", config.metadata.page)
#render-revisions(config)
#signature-field()
