
# 1 Introduction

The Representative UK Train Set has now in essence existed for 6 years in total. With a grand roster of locomotives and multiple units alike, it has sure become a very successful set, achieving its goal of representing a majority of the UKs operational and near-historic railway vehicles in OpenTTD.

However, due to the implement-as-required basis of introducing new vehicles via necessity of wanting to operate certain trains in our personal games, the often forgotten but very real source code has become a hodge-podge of one off ideas, repeated code, and convoluted carriages with confusing capacities.

In this document I will outline my outlying issues with the set, internal to the developer and external to the player, and propose plausible solutions where applicable.
Let us begin by breaking down my initial irritations into the two afformentioned categories.

## 1.1 Document Layout

Internal development issues:
- [2.1 The split between Multiple Unit and Non-Multiple Unit allignments, along with their respective sprite sheets.](#2.1-multiple-unit-alignments-vs-locomotive-&-wagon-alignments)
- [2.2 Length 7 allignments of Multiple Units are incoherent with other vehicles in the set.](#2.2-issues-with-the-pacer)
- [2.3 The use of outdated alignment templates in several earlier vehicles, as well as certain later ones.](#2.3-outdated-alignments)
- [2.4 On the Automatic Livery mode vehicles will change their livery while outside a depot. New code has been implemented that correctly changes a vehicle's livery only when it visits a depot.](#2.4-automatic-liveries)
- [2.5 Mark 3 Buffet and Sleeper coaches are specific behaviours of a base Mark 3 vehicle, whereas the Mark 1 & 2 coaches have been split into separate variants.](#2.5-mark-3-specific-features)
- [2.6 The mere existence of the addon GRF.](#2.6-rukts-extension)
 
External player issues:
- [3.1 Capacities of wagons are incoherent.](#3.1-balance-part-1:-capacity)
- [3.2 Power of multiple units vary drastically.](#3.2-balance-part-2:-vehicle-power)
- [3.3 A severe lack of steam era locomotives, multiple units, and wagons.](#3.3-kettle-shortage)
- [3.4 Peculiar behaviour of DVT and DBSO vehicles when used in multiple.](#3.4-dvt-&-dbso-disadvantages)
- [3.5 It is not immediately clear, or sometimes intuitive, as to which carriage will attach to a certain multiple unit.](#3.5-multiple-unit-carriages)
- [3.6 Some multiple units are allowed to leave the depot with no intermediate carraiges, when said carraiges provide the pantograph required for the multiple unit to function.](#3.6-impossible-multiple-units)
- [3.7 Discussing the original and current identity of the set, comparing its current roster and playstyle with that which we set out to achieve in the original planning stages.](#3.7-transforming-identity)
 
Detailed outcomes:
- [4.1 Complete overhaul of the statistics.](#4.1-statistical-overhaul)
- [4.2 Codebase standardisation.](#4.2-codebase-standardisation)
- [4.3 Achievable plan of steam era vehicles.](#4.3-kettles-for-the-near-future)
- [4.4 Future of the extension set.](#4.4-the-future-of-the-extension-set)
- [4.5 Stations.](#4.5-stations)
- [4.6 Objects.](#4.6-objects)
- [4.7 Miscellaneous future plans.](#4.7-other-plans)
- [4.8 Conclusions.](#4.8-conclusion)


# 2 Internal Development Issues.

## 2.1 Multiple Unit Alignments vs Locomotive & Wagon Alignments

A prevelent issue with alignments is that there are technically two sets of sprite "types" we have conceived between myself (StarRaid) and Gwyd. This is a result of dividing our focuses two different areas of the GRF, myself with locomotives and wagson, and Gwyd with multiple units. There are exceptions to this standard, of which outlyers will be discussed appropriately. This division has caused two sets of sprite templates, and therefor their alignments, to come into practice. One set of alignments based on the Mark 2 sprite of 33 pixels in length on the horizontal view, with one pixel overlapping on the on purpose for carraige gangways and buffers, and the other set based on the original Network sprites of 32 pixels in length on the horizontal view, where no pixels overlap, creating a thicker looking carriage gangway.

![Examples of the mark 2 and networker based sprites.](/essay/alignments.png "The difference in the two types of sprite found in the set")

Exceptions to these rules include the Class 33, a locomotive drawn by Gwyd, and the Sprinter families of vehicles, multiple units that are a mix of my own work and of pikkabird's original set. Of note are also the First Generation DMUs that use the Networker alignments yet they feature the thinner gangways like in the Mark 2 based sprites. [These sprites](/gfx/DMU/dmmu.png "First Generation DMU sprite sheets.") don't overlap their gangways, but instead opt to ommit them at the east end of the sprite.

![Examples of multiple units that break the afformentioned rules.](/essay/alignments2.png "Multiple units that are exceptions to the rules")

This disparity makes it confusing for outsiders looking at the source code, not knowing which sprites use which alignments, making these sprites harder to use in other potential GPLv2 sets.

## 2.2 Issues With The Pacer

The pacer is missaligned. This is evident when pairing the vehicle with other DMUs, the class 150s for example, as the pacer with either overlap with the other vehicle, or a large gap will be visible. This is most prevelent on the horizontal views.

![Examples of the pacer sprites overlapping with other vehicles.](/essay/pacer_alignments.png "The pacers are missaligned in some sprites")



## 2.3 Outdated alignments

Some older vehicles are still using the outdated and unclear `template_Mk2_single` and associated templates. This has been superseed by the standard `template_8_4_2` and associated templates. This a simple find and replace task, as the two templates are identical in sprite sizes and alignments.

## 2.4 Automatic Liveries

The parameter for automatic liveries has had some history to itself. It originally intended to mimic the behaviour of Pikkabird's UKRS2 paramater, where trains would update their livery every time they serviced at a depot. My original knowledge with NML was lacking at the formation of this set though, so I settled for every vehicle to automatically change its livery immediately at the new year. However, this has left some of the failed code in some older code, but has been copied over to newer code as well.

For example, in [dmmu.pnml](/src/DMU/dmmu.pnml "First Generation DMU code.") exists a number of redundant `random_switch` blocks, one for each set of colours.

```python
random_switch(FEAT_TRAINS, SELF, sw_dmmu_green_colour_mapping, TRIGGER_VEHICLE_SERVICE){
	1: palette_2cc(COLOUR_DARK_GREEN, COLOUR_YELLOW);
 }
 
random_switch(FEAT_TRAINS, SELF, sw_dmmu_blue_colour_mapping, TRIGGER_VEHICLE_SERVICE){ 
	1 : palette_2cc(COLOUR_DARK_BLUE, COLOUR_DARK_BLUE);
}
 
random_switch(FEAT_TRAINS, SELF, sw_dmmu_mail_colour_mapping, TRIGGER_VEHICLE_SERVICE){ 
	1 : palette_2cc(COLOUR_RED, COLOUR_RED);
}

random_switch(FEAT_TRAINS, SELF, sw_dmmu_bg_colour_mapping, TRIGGER_VEHICLE_SERVICE){  
	1 : palette_2cc(COLOUR_DARK_BLUE, COLOUR_WHITE);
}

random_switch(FEAT_TRAINS, SELF, sw_dmmu_rr_colour_mapping, TRIGGER_VEHICLE_SERVICE){  
	1 : palette_2cc(COLOUR_DARK_BLUE, COLOUR_LIGHT_BLUE);
}

random_switch(FEAT_TRAINS, SELF, sw_dmmu_nse_colour_mapping, TRIGGER_VEHICLE_SERVICE){  
	1 : palette_2cc(COLOUR_DARK_BLUE, COLOUR_RED);
}

random_switch(FEAT_TRAINS, SELF, sw_dmmu_silverlink_colour_mapping, TRIGGER_VEHICLE_SERVICE){  
	1 : palette_2cc(COLOUR_DARK_BLUE, COLOUR_DARK_GREEN);
}

random_switch(FEAT_TRAINS, SELF, sw_dmmu_atw_colour_mapping, TRIGGER_VEHICLE_SERVICE){  
	1 : palette_2cc(COLOUR_LIGHT_BLUE, COLOUR_WHITE);
}

random_switch(FEAT_TRAINS, SELF, sw_dmmu_cr_colour_mapping, TRIGGER_VEHICLE_SERVICE){  
	1 : palette_2cc(COLOUR_LIGHT_BLUE, COLOUR_LIGHT_BLUE);
}
```

The solution has already been tested and is currently being implemented. In [class_419.pnml](/src/EMU/class_419.pnml Class 419 EMU code.") I have utilised `date_of_last_service` to test when the last time the vehicle was serviced, changing the livery and colours only when the vehicle services at a depot. 

```python
switch(FEAT_TRAINS, SELF, sw_419_colours_auto, date_of_last_service){
	DATE_BRBLUE	:palette_2cc(COLOUR_DARK_BLUE, COLOUR_WHITE);
	DATE_BRTOPS	:palette_2cc(COLOUR_DARK_BLUE, COLOUR_WHITE);
	DATE_SECTORISATION	:palette_2cc(COLOUR_DARK_BLUE, COLOUR_RED);
	palette_2cc(COLOUR_DARK_GREEN, COLOUR_DARK_GREEN);
}
```

By utilising standardised date ranges for certain eras, it ensures that liveries will also be changed en-masse by vehicles to update coherently in era "blocks."

One issue is where a vehicle's code utilises the same automatic colour switch for the purchase sprite, it will incorrectly display the wrong colours as purchase sprites don't get serviced. This will require the separation of the purchase sprite colour mapping to a different switch using the `current_year` value, a standardisation in code that should be implemented for a more coherent code base.

## 2.5 Mark 3 Specific Features

The Mark 3 coaches have some unique behaviours to them that I am proud of, but ultimately have lead to their downfall with the implementation of the variants feature. A nice little detail that I originally added was the ability for the 3rd coach in any rake to automatically be a buffet coach, so that the HST would still be realistically detailed without having to create a separate wagon (at the time.) This feature also had the advantage that if the vehicle reversed the buffet coach would remain in the same place.  
In todays climate however we are graced with the variants feature, meaning I have the ability to split the normal, buffet, and sleeper coaches into separate vehicles, potentially even adding the guard and bycicle variants too for extra detailing options. These come with the major drawback that these would not be reversible like the previous Mark 3 features. I believe I will have to bite the bullet and just accept this reversibility drawback, as the extra Mark 3 variants will allow to declutter the current livery list of the current Mark 3, of which it contains duplicate liveries to allow access to the sleeper variant.

Most of this can also be applied to the Mark 4 coach, but since this coach has seen little use outside of the Class 91 rakes or without a DVT, I believe it is justified leaving it with its current behaviour, without splitting it into variants.

Another choice could be to split the Mark 2 coach into its subclasses of A, C, and F, including brake variants and DBSO.

## 2.6 RUKTS Extension

The extension GRF exists to fulfil a multitude of roles and limitations set by our original idea for the main GRF. However, due to an evolving identity and looser development restrictions, its role has dwindled over the years. I simply propose to announce its total depracation entirely.

The functions it served were as follows:
> * Implement extra sounds for the base set to use.
> * Introduce additional vehicles that did not fit roster of the base set.
> * Allow for the transportation of the niche cargo type Nuclear Waste, allowing the base set vehicles based around the transportation of this cargo in real life to be of use in the game.

The function to implement additional sounds has been superseeded by the fact that when I have seemingly gone over the sound limit in the base set, the compiler still allows the GRF to compile, and I have not seen issues with the playback of the additional sounds. This means the extension set should not be required to provide sound files any further, and that the existing sounds should be provided in the base set instead. This will require further testing to achive.

A majority of the extra vehicles provided by the extension set have since been implemented fully in the main GRF, with the last remaining vehicle to recieve this treatment being the class 456. If this vehicle is introduced to the main GRF, this will further render the exension set useless.
Due to the codebase of the industry features provided by this set being severely outdated and made with little experience prior, the two industries and two cargoes provided by the extension set have had extensive compatibility clashes with most industry focused GRFs. My proposal is to convert the existing sprites for the power station into objects in a new set I will outline later. This will render the extension set entirely useless for the future, justifying its take down from the online content downloader for new games only. The GRF shall still be provided for save files that have been created prior to the takedown, in order to not break their functionality.

# 3 External player issues

## 3.1 Balance Part 1: Capacity

Balance with this set is difficult and, surprisingly enough, incoherent. High speed multiple units have extroadinarily low capacities in comparison to their locomotive hauled counterparts. Most of these capacities do not nearly resemble their real life capacities, let alone the provision for a balanced set.
> * An 8 coach Class 700 carries 970 passengers, compared to its real life capacity of 1146. 
> * An 8 coach Class 395 carries 476 passengers.
> * A Class 91 with 7 Mark 4 coaches carries 616 passengers.

![The statistics of the set are wildly out of balance.](/essay/statistics.png "How did this happen??")

Also of note are the running costs after 2 years of running these three vehicles on an empty line. The locomotive hauled train has considerably higher running costs than the multiple units, over ten fold of the equally speedy Class 395. Though a "Meta Train" is inevitable in any circumstances, balancing the set so that there are not such obviously over powered choices is a must.

## 3.2 Balance Part 2: Vehicle Power

Referring to the screenshot in the previous section, the imbalance of pulling power and force is also disparrant. Though tractive effort is typically harder to source for multiples units, the same cannot be said of power, of which there are mixed outcomes thereof, depending on the vehicle. I will examine some individual example cases

#### Case 1 - Class 158

The Class 158 for example (generally) has one 350 hp engine per coach, with each coach weighing 38.5 tonnes. In game these values are represented correctly as a two coach unit (no extra vehicles), but when an extra coach is added the power value increases by an arbitrary 261 hp instead of the nominal 350 hp.  
Provided by Eversholt Group is an acceleration value of 0.8 m/s², meaning that if we times this by the vehicles mass of 77 tonnes in a two coach unit, 77 times 0.8 equals 61.6 kN of tractive effort, a useful value to be provided with. However, the Class 158 has been arbitrarily set a value of 134 kN, over double that of its actual value. Interestingly, additional carriages are not adding extra tractive effort to the vehicle in-game, a feature that other vehicles have.

#### Case 2 - Class 101

This is a particularly odd case. Firstly, Class 101 units did not have engines under their intermediate carriages (in the case of 3 and 4 coach units), meaning this vehicle does **not** need to provide a `power` value in the `livery_override` section. Most (but not all) 101 driving coaches had two 150 hp engines underneath them, meaning each unit should have 600 hp total. Instead, the vehicle only has 224 hp in total, heavily underpowering the vehicle, and in some cases this disallows it to reach its 70 mph top speed with even 1 intermediate coach.

#### Case 3 - Class 115

Similar to the class 101, the class 115 does not have engines under its intermediate carraiges, but had two 230 hp engines below each driving coach, totalling 920 hp. In RUKTS this vehicle only has 460 hp, exactly half of its real value.

#### Case 4 - Class 165

Class 165s have very similar engines to class 158s, providing the same 350 hp. The same issue happens in game though, where a two coach unit has the correct power but extra carriages only add 261 hp. What differs here though is that the extra carriages *do* provide more tractive effort for the vehicle to use. This must be investigated in order to provide a fix to the class 158 and other similarly affected vehicles.

#### Case 5 - Class 195

The last diesel case I will focus on. These vehicles correctly represent their 500 hp per carriage power output, including intermediate carriages, with the intermediate carriages successfuly providing tractive effort too, albiet a proportionally lower value than their leading driving coaches (20kN instead of 135 kn.)

#### Case 6 - Class 319

Interestingly this vehicle has 1438 hp in game compared to its real life value of 1330 hp. Intermediate carriages correctly provide no extra tractive effort.

#### Case 7 - Class 700

In real life this train has different power depending on the formation. An eight coach unit has 4400 hp, 550 hp per carriage. A twelve coach unit has 6700 hp, 558.3 hp per carriage. In game the two coach already has 4425 hp, with each extra carriage providing 200 hp. This makes an eight coach unit have 5624 hp and a twelve coach unit have 6424 hp, both of which are off their real values by some margin.  
The unit has a base value of 133 kN of tractive effort, with each extra carriage adding 23 kN for whatever arbitrary reason.

#### Case 8 - Class 442

A real unit has 1610 hp in total, provided by three motor coaches. The formation of one of these units is Motor Coach - Trailer - Motor Coach - Trailer - Motor Coach, meaning two thirds of the power can be provided by driving coaches, and the last third can be dividedly equally between the three intermediate coaches. 
In game the the driving coaches currently provide 1608 hp, with the intermediate carriages providing no power. This is another solution, but would render the vehicle underpowered if the player builds 6 coach units or longer. One of the purposes of not having fixed-length units is so that the player can customise their trains how they like, but if a unit is underpowered at certain lengths it removes some creative liberty for the end user.

#### Case 9 - Class 395

A six coach class 395 consists of 2 driving trailers and 4 intermediate motor coaches, providing 4510 hp. In game the class 395 provides 1120 hp, with each extra intermediate carriage adding 560 hp, totalling to 3360 hp for a 6 coach unit, leaving the unit underpowered. Coupled with its abysmal passenger capacity, this unit is left as a fatally poor choice compared to other units, like the class 700.  
The driving coaches are providing 414 kN of tractive effort, with each extra coach providing an additional 31 kN to the consist. Another example of intermediary coaches providing little tractive effort relative to the leading coaches. In reality, a 285 tonne unit accelerations at 0.7m/s², giving a tractive effort of 185.5 kN.

#### Case 10 - Class 802

The IET gets complicated, with its varying classes and subclasses differing slightly in their power outputs. According to the class 802 page on angeltrains website, each motor producing 226 kW (303 hp). Assuming that's 4 x 303 hp per motor coach, with 5 coaches being powered in a 9 coach set, giving 6060 hp per 9 coach unit. In game, the driving coaches are providing 1876 hp, with each intermediate carriage adding 700 hp each, giving a 9 coach unit 6776 hp. If the train is on diesel, then only 4700 hp should be provided (5 x 940 hp), but this power change is not currently present in the GRF. When the vehicle recieves its new statistics I believe that code should be put in place to properly represent its power mode change, as well as implementing the speed limit change to 110 mph on diesel.  
Citeless sources on wikipedia claim that these units either have a 1 m/s² or 0.7 m/s² acceleration. Assuming the 0.7 value is correct, with a weight of 438 tonnes these units should have a total of 306.6 kN of tractive effort.

Locomotives are essentially exempt from the conundrum of power and tractive effort, as these figures are nearly always readily available due to the nature of their work.

## 3.3 Kettle Shortage

The largest downside of RUKTS continues to be the roster of steam locomotives present in the set. Our sister sets of UKFS and UKRS2 both boast immense choice when it comes to the first stages of railway history, whereas our current selection is limited to 5 tank engines and 8 tender engines (4 of which are of immediately similar designs.) In practice this removes RUKTS as an option for a majority of players whose start date predates 1950.

My simple solution is to just do them. It's hard to force motivation for a vehicle, but once the ball starts rolling I'm sure we can get a good workflow of kettles being produced. The most important thing to do for now is set our expectations low and achievable for the immediate future, so that if we control our ambitions then our rewards will be easier to achieve, therefor more movitating to continue with more. I will outline a detailed plan on how to do this later.

## 3.4 DVT & DBSO Disadvantages

The DVT & DBSO have very unique behaviour when paired with a compatible locomotive, this much is known. It is also known that if placed anywhere other than at the very rear of a consist then undesirable behaviour will take place. This also includes when multiple are used in the same consist. The last thing of note is that the livery of the DVT or DBSO is entirely dependant on the livery of the parent locomotive, disallowing the player to choose the livery of the DVT or DBSO.

The first proposal will limit when the reversal behaviour will take place. When the vehicle is reversed, instead of simply checking for the presence of a compatible cab vehicle (like the current code), instead a serious of checks will all take simultaneously using the && logic statements.  
In order, both the front locomotive and rear carriage will check for these things:
> * That the front locomotive is compatible.
> * That the rear carriage is compatible.
> * That the total number of compatible locomotives is exactly one.
> * That there is exactly one DBSO or DVT in the consist, but not one of both.

If these conditions are not met, then the sprites will behave like normal vehicles when the trains reverse.  
But the inclusion of more vigorous testing will allow more consists to be possible without breaking the sprites of multiple vehicles at once. These checks will be done by adding up the counts of each individual compatible vehicle per list and checking if the total equals exactly 1.

The second proposal is to repurpose Gwyd's code from the SEv2 set into the DBSO & DVT code. By utilising `[STORE_TEMP(position_in_consist_from_end-position_in_consist, 0x10F), var[0x61, 0, 0x0000FFFF, 0xF2]]` and changing the position check to `num_vehs_in_consist-1` the front locomotive will be able to check what the value of `cargo_subtype` (i.e. livery) is of the rear most vehicle, allowing the DBSO & DVT liveries to be changed manually.

## 3.5 Multiple Unit Carriages

It is not immediately clear for all multiple units as to which carriage is allowed to be attached in order to lengthen the unit. In the case of the Class 455, a Mark 3 based unit in real life, the Mark 2 carraige is used to lengthen the unit in the GRF.

My proposal is to make all multiple units use one type of carraige to lengthen themselves. We can utilise the existing "Modern MU Car", known by MU_90 in the code, by replacing its sprite with a blank carriage with no attached identity, changing its introduction date to the year 0, and by changing its capacity to 0. By removing its capability to carry cargo the carriage is automatically useless outside of any multiple unit, as the multiple units can change its capacity with the `livery_override` function.

## 3.6 Impossible Mutliple Units

Classes 317, 370, and 373 have special behaviour that display different sprites when not intermediate vehicles are present for the vehicle to properly function. This is due to the fact that units utilising overhead line equipment must contain a pantograph, and a majority of vehicles place their pantograph on intermediate carriages instead of the driving coaches. For a better player experience I propose this feature be applied to all vehicles that suffer from middle pantograph syndrome. The use of ugly sprites that the 370 and 373 utilise will also discourage impossible unit combinations that the code might also allow by accident.

![An example of an impossible multiple unit containing two units. The first unit has two intermediate coaches, and the second unit has none. This is allowed by the code but is still an impossible vehicle.](/essay/impossible.png "A multiple unit in violation of mother nature.")

## 3.7 Transforming Identity



# 4 Detailed Outcomes

## 4.1 Statistical Overhaul

What needs to be created is a CSV specifically for the statistics of every vehicle in the set. What we can do is manually write in every value currently in the set into the CSV, then take steps to balance the set.

Step 1 would be to research real life values where available and overwrite existing values in the CSV with the realistic values.  
Some values that can be taken literally are power, tractive effort, passenger capacity, and weight.

Step 2 is to interpret real life reports on reliability and model life into the game by looking at reports on how vehicles performed throughout their life time. We can balance these accordingly against other vehicles as we go along.  
Values like loading speed can be taken into account by examining door width and placement on a carriage, and by examining loading and unloading methods for wagons. For example, some open stone wagons are loaded manually with a excavator like vehicle, a method much slower compared to the HAA's unloading and loading which takes place in motion, without the train stopping.  
Cargo decay can be calculated by taking into account reports of comfort for passenger vehicles, but this feature can be skipped for freight wagons.

Step 3 is to examine what values we aren't able to interpret from reality and balance accordingly with vehicles that have their real life values listed. We can do this by breaking down vehicles into categories by function, and examining a system for progression within each respective category. One of the current failings of the set is that higher speed vehicles are punished by having comparitively miniscule capacities for cargo. Instead I believe this should be balanced out with noticably higher running and build costs, as a unit like the pacer should be cheap with a medium capacity, but should be easily outclassed in capacity and speed by the HST, justifying a much higher running and build cost.

## 4.2 Codebase Standardisation

Due to the nature of simply how *many* changes are needed to each individual vehicle, all in different ways, I propose a soft rewrite of the set.  
By writing a complete template for a wagon, locomotive and multiple unit, these can essentially be copy-pasted for each vehicle, with minor adjustments to specific behaviours unique to certain vehicles. These unique features will however be accounted for in the template, leaving commented-out sections of code ready to be used where necessary.

### Templates

A default template should be created for wagons, locomotives, and multiple units respectively. Locomotives would need checks to see if they need to display a reversed graphic (special behaviour applied for locomitives with a single cab), multiple units would need to check for pantograph coach placement (which will result in a standardised behaviour, useful for when players lengthen vehicles beyond their realistic lengths), and wagons will require a unique sprite stack for when they are either loading and unloading, or for when their cargo is visible in transit.

The statistics for each vehicle can be loaded from a CSV, as well as feature defining flags like tilting. A python script will read this CSV and write all the values as custom definitions in a pnml file. These definitions will be referenced easily inside the `item` definitions of the vehicle.  
Because we're using a script to read a CSV we can even use it to write the strings for each vehicles name and alternative name.

Example code:

```python
// Statistics generated by the python script, read from the CSV
#define STAT_0037_POWER 1650 hp
#define STAT_0037_WEIGHT 105 tonnes

//Item from class_37.pnml
item(FEAT_TRAINS, ITEM_0037, 37){
	property{
		power:		STAT_0037_POWER;
		weight:		STAT_0037_WEIGHT;
	}
}

```

Statistic that could be loaded from the CSV include:

- Weight
- Tractive Effort (automatically calculate the coefficient by using this value and the vehicle's weight)
- Maximum speed
- Running cost
- Purchse cost
- Reliability decay
- Introduction year
- Vehicle length
- Railtype
- Cargo classes
- Model life
- Vehicle life

Other things that we could track in the CSV but not necessarily need to automatically extract via script could include:

- Reversal compatibility (a value used to flag if a locomotive is compatible with a DBSO, DVT, or GLV)
- List of liveries

### Colours

One of my first proposals is to standardise the colours used for each company. A new pnml file can be created to define these custom definitions that return `palette_2cc` combinations. We can simplify this process by assigning each livery a three letter code.  
For example:

```python
#define PALETTE_NSE	palette_2cc(COLOUR_RED,			COLOUR_DARK_BLUE)
#define PALETTE_BRB	palette_2cc(COLOUR_DARK_BLUE,	COLOUR_WHITE)
#define PALETTE_VIR	palette_2cc(COLOUR_RED,			COLOUR_WHITE)
```

### Refit text

A new feature we could also borrow from SEv2 is locking new liveries behind introduction years.  
For example:

```python
switch	(FEAT_TRAINS, SELF, SW_LIVERY_BRB, current_year > 1964){1: return string(STR_BRB);	return CB_RESULT_NO_TEXT;}
switch	(FEAT_TRAINS, SELF, SW_LIVERY_NSE, current_year > 1985){1: return string(STR_NSE);	return CB_RESULT_NO_TEXT;}
switch	(FEAT_TRAINS, SELF, SW_LIVERY_VIR, current_year > 1997){1: return string(STR_VIR);	return CB_RESULT_NO_TEXT;}
```

The creation of the strings, palette definitions, and year switches could be all automated by a python script exctracting these values from a CSV to easily add new liveries and names. Then we can use the same three letter codes to set which liveries will be available in the vehicles CSV, automating the creation for the switches of these features.

## 4.3 Kettles



## 4.4 The Future Of The Extension Set

To summarise, it should die.  
But its functions should be implemented in other sets, with more detail to each feature to fully flesh out the original half-baked ideas.

## 4.5 Station

https://www.google.co.uk/maps/@55.8701934,-4.2299993,196a,35y,327.38h,44.41t/data=!3m1!1e3?entry=ttu

## 4.6 Objects



## 4.7 Other plans



## 4.8 Conclusion



