
# 1 Introduction

The Representative UK Train Set has now in essence existed for 6 years in total. With a grand roster of locomotives and multiple units alike, it has sure become a very successful set, achieving its goal of representing a majority of the UKs operational and near-historic railway vehicles in OpenTTD.

However, due to the implement-as-required basis of introducing new vehicles via necessity of wanting to operate certain trains in our personal games, the often forgotten but very real source code has become a hodge-podge of one off ideas, repeated code, and convoluted carriages with confusing capacities.

In this document I will outline my outlying issues with the set, internal to the developer and external to the player, and propose plausible solutions where applicable.
Let us begin by breaking down my initial irritations into the two afformentioned categories.

## 1.1 Document Layout

Internal development issues:
> * 2.1 The split between Multiple Unit and Non-Multiple Unit allignments, along with their respective sprite sheets.
> * 2.2 Length 7 allignments of Multiple Units are incoherent with other vehicles in the set.
> * 2.3 The use of outdated alignment templates in several earlier vehicles, as well as certain later ones.
> * 2.4 Outdated code using redundant random_switch statements in an early attempt to get vehicles to only change their livery when visiting a depot.
> * 2.5 On the Automatic Livery mode vehicles will change their livery while outside a depot. New code has been implemented that correctly changes a vehicle's livery only when it visits a depot.
> * 2.6 Mark 3 Buffet and Sleeper coaches are specific behaviours of a base Mark 3 vehicle, whereas the Mark 1 & 2 coaches have been split into separate variants.
> * 2.7 The mere existence of the addon GRF.
 
External player issues:
> * 3.1 Capacities of wagons are incoherent.
> * 3.2 Power of multiple units vary drastically.
> * 3.3 A severe lack of steam era locomotives, multiple units, and wagons.
> * 3.4 Peculiar behaviour of DVT and DBSO vehicles when used in multiple.
> * 3.5 It is not immediately clear, or sometimes intuitive, as to which carriage will attach to a certain multiple unit.
> * 3.6 Some multiple units are allowed to leave the depot with no intermediate carraiges, when said carraiges provide the pantograph required for the multiple unit to function.
> * 3.7 Discussing the original and current identity of the set, comparing its current roster and playstyle with that which we set out to achieve in the original planning stages.
 
Detailed outcomes:
> * 4.1 Complete overhaul of the statistics.
> * 4.2 Codebase standardisation.
> * 4.3 Achievable plan of steam era vehicles.
> * 4.4 Future of the extension set.
> * 4.x Miscellaneous future plans.
> * 4.x+1 Conclusions.


# 2 Internal development issues.

## 2.1 Multiple unit alignments vs Locomotive & wagon alignments

A prevelent issue with alignments is that there are technically two sets of sprite "types" we have conceived between myself (StarRaid) and Gwyd. This is a result of dividing our focuses two different areas of the GRF, myself with locomotives and wagson, and Gwyd with multiple units. There are exceptions to this standard, of which outlyers will be discussed appropriately. This division has caused two sets of sprite templates, and therefor their alignments, to come into practice. One set of alignments based on the Mark 2 sprite of 33 pixels in length on the horizontal view, with one pixel overlapping on the on purpose for carraige gangways and buffers, and the other set based on the original Network sprites of 32 pixels in length on the horizontal view, where no pixels overlap, creating a thicker looking carriage gangway.

![Examples of the mark 2 and networker based sprites.](/essay evidence/alignments.png "The difference in the two types of sprite found in the set")

Exceptions to these rules include the Class 33, a locomotive drawn by Gwyd, and the Sprinter families of vehicles, multiple units that are a mix of my own work and of pikkabird's original set. Of note are also the First Generation DMUs that use the Networker alignments yet they feature the thinner gangways like in the Mark 2 based sprites. [These sprites](/gfx/DMU/dmmu.png "First Generation DMU sprite sheets.") don't overlap their gangways, but instead opt to ommit them at the east end of the sprite.

![Examples of multiple units that break the afformentioned rules.](/essay evidence/alignments 2.png "Multiple units that are exceptions to the rules")

This disparity makes it confusing for outsiders looking at the source code, not knowing which sprites use which alignments, making these sprites harder to use in other potential GPLv2 sets.

## 2.2 Issues with the pacer

The pacer is missaligned. This is evident when pairing the vehicle with other DMUs, the class 150s for example, as the pacer with either overlap with the other vehicle, or a large gap will be visible. This is most prevelent on the horizontal views.

![Examples of the pacer sprites overlapping with other vehicles.](/essay evidence/pacer alignments.png "The pacers are missaligned in some sprites")



## 2.3



## 2.4



## 2.5



## 2.6



## 2.7 RUKTS Extension

The extension GRF exists to fulfil a multitude of roles and limitations set by our original idea for the main GRF. However, due to an evolving identity and looser development restrictions, its role has dwindled over the years. I simply propose to announce its total depracation entirely.

The functions it served were as follows:
* Implement extra sounds for the base set to use.
* Introduce additional vehicles that did not fit roster of the base set.
* Allow for the transportation of the niche cargo type Nuclear Waste, allowing the base set vehicles based around the transportation of this cargo in real life to be of use in the game.

The function to implement additional sounds has been superseeded by the fact that when I have seemingly gone over the sound limit in the base set, the compiler still allows the GRF to compile, and I have not seen issues with the playback of the additional sounds. This means the extension set should not be required to provide sound files any further, and that the existing sounds should be provided in the base set instead. This will require further testing to achive.

A majority of the extra vehicles provided by the extension set have since been implemented fully in the main GRF, with the last remaining vehicle to recieve this treatment being the class 456. If this vehicle is introduced to the main GRF, this will further render the exension set useless.
Due to the codebase of the industry features provided by this set being severely outdated and made with little experience prior, the two industries and two cargoes provided by the extension set have had extensive compatibility clashes with most industry focused GRFs. My proposal is to convert the existing sprites for the power station into objects in a new set I will outline later. This will render the extension set entirely useless for the future, justifying its take down from the online content downloader for new games only. The GRF shall still be provided for save files that have been created prior to the takedown, in order to not break their functionality.

# 3 External player issues

## 3.1



## 3.2



## 3.3



## 3.4



## 3.5 Multiple unit carriages

It is not immediately clear for all multiple units as to which carriage is allowed to be attached in order to lengthen the unit. In the case of the Class 455, a Mark 3 based unit in real life, the Mark 2 carraige is used to lengthen the unit in the GRF.

My proposal is to make all multiple units use one type of carraige to lengthen themselves. We can utilise the existing "Modern MU Car", known by MU_90 in the code, by replacing its sprite with a blank carriage with no attached identity, changing its introduction date to the year 0, and by changing its capacity to 0. By removing its capability to carry cargo the carriage is automatically useless outside of any multiple unit, as the multiple units can change its capacity with the `livery_override` function.

## 3.6 Impossible mutliple units

Classes 317, 370, and 373 have special behaviour that display different sprites when not intermediate vehicles are present for the vehicle to properly function. This is due to the fact that units utilising overhead line equipment must contain a pantograph, and a majority of vehicles place their pantograph on intermediate carriages instead of the driving coaches. For a better player experience I propose this feature be applied to all vehicles that suffer from middle pantograph syndrome. The use of ugly sprites that the 370 and 373 utilise will also discourage impossible unit combinations that the code might also allow by accident.

![An example of an impossible multiple unit containing two units. The first unit has two intermediate coaches, and the second unit has none. This is allowed by the code but is still an impossible vehicle.](/essay evidence/alignments 2.png "A multiple unit in violation of mother nature.")

## 3.7



# 4 Detailed outcomes

## 4.1



## 4.2



## 4.3



## 4.4 The future of the Extension Set

To summarise, it should die.
But its functions should be implemented in other sets, with more detail to each feature to fully flesh out the original half-baked ideas.

## 4.x



## 4.x+1



