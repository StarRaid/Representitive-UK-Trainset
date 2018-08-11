grfinit(GRF_GWYDPONE,
	grfname(ALL,"GWEEEEEEEEEEEEED")
	grfdescription(ALL, "HNnnrrrrrrrrrrrr" 0D
	"HNnnrrrrrrrrrrrr")
	grfpalette(DOS)
	grfversion(1)
	grfminversion(1)
)

definestation(GWYDPONE,"Generic platform 1",
	class(GUKM,"Gwyd's UK Modern Platforms")
	callbacks(CB_LAYOUT)                        
	exclude_widths(8)
	exclude_lengths(8)
	pylons(TTD_ALLTILES)
)

spriteblock(
    set(
// 1 and 2 / direction
	sprite(gwst1.png 0 0 01 64 122 -31 -91)
	sprite(gwst1.png 80 0 09 64 122 -31 -91)
// 3 and 4 \ direction
	sprite(gwst1.png 160 0 01 64 122 -31 -91)
	sprite(gwst1.png 240 0 09 64 122 -31 -91)
// 5 blank
	sprite(gwst1.png 123 09 64 122 -31 -91)
   )
)

def(0) spriteset(little(0),lots(0))

layout(GWYDPONE,
  tile(_ukp1
    ground(1012) // track x
    regular(1, xyz(0,0,0),dxdydz(16,5,8)) 
    regular(2, xyz(0,11,0),dxdydz(16,5,8))
  )
  tile(
    ground(1011) // track y
    regular(3, xyz(0,0,0),dxdydz(5,16,8))
    regular(4, xyz(11,0,0),dxdydz(5,16,8))
  )
 )
 

def(1) callback(
	reftile(_ukp1) if(CB_LAYOUT) // tile layout
	ref(0) else		     // graphics chain
)

makestation(ENGINESHED,
	default(ref(1))
)