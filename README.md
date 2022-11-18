# hmw
Machine readable version of Mammal Species of the World volumes as transcribed by Plazi

:warning: experimental - please use at own risk.

[`methods`](#methods) / [`results`](#results) / [`summary statistics`](#summary-statistics) / [`example record`](#example-record) / [`R example`](#r-example) / [`funding`](#funding) / [`references`](#references)

Physical copies of Mammal Species of the World are a valuable taxonomic resource for mammals. This repository uses Plazi digitized taxonomic treatment versions of these physical copies to generate [msw1.json](msw1.json),  and [msw2.json](hmw.json). For your convenience, the first 10 records can be found [msw1-sample.json](msw1-sample.json), [msw2-sample.json](msw2-sample.json). The json and files are derived from a Preston tracked version of Plazi's treatment bank available via https://github.com/plazi/treatments-xml.

This work originates from the Biodiversity Data Hub working group of the CETAF Covid19 . For more information see https://globalbioticinteractions.org/covid19 .


# Methods

The json files are roughly generated via:

```
# get the recent version of Plazi's treatments in xml format

# transform only MSW treatments into json using preston

```
preston track https://github.com/plazi/treatments-xml/archive/master.zip\
 | preston plazi-stream\
 | grep "Mammal Species of the World"\
 > msw.json
```

Separate the msw related treatment into msw1 and msw2. At time of writing Plazi had not yet transcribed MSW3 yet. 

```
cat msw.json\
 | jq --compact-output 'select(.["docOrigin"] == "Mammal Species of the World (1 st Edition), Lawrence, Kansas, USA: Alien Press, Inc. & The Association of Systematics Collections")'\
 > msw1.json 
```


```
cat msw.json\ 
 | jq --compact-output 'select(.["docOrigin"] == "Mammal Species of the World (2 nd Edition), Washington and London: Smithsonian Institution Press")'\
 > msw2.json
```

Work in process. Please open an issue if you have questions / comments.
