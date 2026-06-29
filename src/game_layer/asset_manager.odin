package GameLayer 

import rl "vendor:raylib"

RESOURCES_PATH :: "resources/"

AssetManager :: struct {
    // Player sprites
    player           : rl.Texture2D,
    playerSprites    : rl.Texture2D,
    items            : rl.Texture2D,
    hearts           : rl.Texture2D,
    copperArmorBack  : rl.Texture2D,
    copperArmorFeet  : rl.Texture2D,
    copperArmorFront : rl.Texture2D,
    copperArmorHead  : rl.Texture2D,
    goldArmorBack    : rl.Texture2D,
    goldArmorFeet    : rl.Texture2D,
    goldArmorFront   : rl.Texture2D,
    goldArmorHead    : rl.Texture2D,
    iceArmorBack     : rl.Texture2D,
    iceArmorFeet     : rl.Texture2D,
    iceArmorFront    : rl.Texture2D,
    iceArmorHead     : rl.Texture2D,
    ironArmorBack    : rl.Texture2D,
    ironArmorFeet    : rl.Texture2D,
    ironArmorFront   : rl.Texture2D,
    ironArmorHead    : rl.Texture2D,
    partyHat         : rl.Texture2D,
    playerBack       : rl.Texture2D,
    playerFeet       : rl.Texture2D,
    playerFront      : rl.Texture2D,
    playerHead       : rl.Texture2D,
    sunglasses       : rl.Texture2D,
    thumbs           : rl.Texture2D,
    
    frame : rl.Texture2D,
    
    // Environment sprites
    dirt               : rl.Texture2D,
    textures           : rl.Texture2D,
    backgroundTextures : rl.Texture2D,
    treeTextures       : rl.Texture2D,
    caveBG             : rl.Texture2D,
    desertBG           : rl.Texture2D,
    forestBG           : rl.Texture2D,
    snowBG             : rl.Texture2D,
    
    // Enemy sprites
    blueSlime      : rl.Texture2D,
    evilEye        : rl.Texture2D,
    iceSlime       : rl.Texture2D,
    mummy          : rl.Texture2D,
    slime          : rl.Texture2D,
    smallBlueSlime : rl.Texture2D,
    zombieEskimo   : rl.Texture2D,
    zombie         : rl.Texture2D,
    
    // Music
    bonus   : rl.Music,
    cave    : rl.Music,
    credits : rl.Music,
    desert  : rl.Music,
    forest  : rl.Music,
    snow    : rl.Music,
    
    // Sounds
    breakSound  : rl.Sound,
    place       : rl.Sound,
    backButton  : rl.Sound,
    buttonPress : rl.Sound,
    checkBoxOff : rl.Sound,
    checkBoxOn  : rl.Sound,
    finalHit1   : rl.Sound,
    finalHit2   : rl.Sound,
    finalHit3   : rl.Sound,
    hImpact1    : rl.Sound,
    hImpact2    : rl.Sound,
    hImpact3    : rl.Sound,
    hit1        : rl.Sound,
    hit2        : rl.Sound,
    hit3        : rl.Sound,
    slider      : rl.Sound,
    stone1      : rl.Sound,
    stone2      : rl.Sound,
    stone3      : rl.Sound,
    stone4      : rl.Sound,
    stone5      : rl.Sound,
    stone6      : rl.Sound,
    stone7      : rl.Sound,
    wood1       : rl.Sound,
    wood2       : rl.Sound,
    wood3       : rl.Sound,
    wood4       : rl.Sound,
    wood5       : rl.Sound,
    wood6       : rl.Sound,
    wood7       : rl.Sound,
}



load_all_assets :: proc(am : ^AssetManager) {
// Player Sprites
    am.player               = rl.LoadTexture(RESOURCES_PATH + "player.png")
    am.playerSprites        = rl.LoadTexture(RESOURCES_PATH + "playerSprites.png")
    am.items                = rl.LoadTexture(RESOURCES_PATH + "items.png")
    am.hearts               = rl.LoadTexture(RESOURCES_PATH + "hearts.png")
    am.copperArmorBack      = rl.LoadTexture(RESOURCES_PATH + "body/copper_armour_back.png")
    am.copperArmorFeet      = rl.LoadTexture(RESOURCES_PATH + "body/copper_armour_feet.png")
    am.copperArmorFront     = rl.LoadTexture(RESOURCES_PATH + "body/copper_armour_front.png")
    am.copperArmorHead      = rl.LoadTexture(RESOURCES_PATH + "body/copper_armour_head.png")
    am.goldArmorBack        = rl.LoadTexture(RESOURCES_PATH + "body/gold_armour_back.png")
    am.goldArmorFeet        = rl.LoadTexture(RESOURCES_PATH + "body/gold_armour_feet.png")
    am.goldArmorFront       = rl.LoadTexture(RESOURCES_PATH + "body/gold_armour_front.png")
    am.goldArmorHead        = rl.LoadTexture(RESOURCES_PATH + "body/gold_armour_head.png")
    am.iceArmorBack         = rl.LoadTexture(RESOURCES_PATH + "body/ice_armour_back.png")
    am.iceArmorFeet         = rl.LoadTexture(RESOURCES_PATH + "body/ice_armour_feet.png")
    am.iceArmorFront        = rl.LoadTexture(RESOURCES_PATH + "body/ice_armour_front.png")
    am.iceArmorHead         = rl.LoadTexture(RESOURCES_PATH + "body/ice_armour_head.png")
    am.ironArmorBack        = rl.LoadTexture(RESOURCES_PATH + "body/iron_armour_back.png")
    am.ironArmorFeet        = rl.LoadTexture(RESOURCES_PATH + "body/iron_armour_feet.png")
    am.ironArmorFront       = rl.LoadTexture(RESOURCES_PATH + "body/iron_armour_front.png")
    am.ironArmorHead        = rl.LoadTexture(RESOURCES_PATH + "body/iron_armour_head.png")
    am.partyHat             = rl.LoadTexture(RESOURCES_PATH + "body/party_hat")
    am.playerBack           = rl.LoadTexture(RESOURCES_PATH + "body/player_back.png")
    am.playerFeet           = rl.LoadTexture(RESOURCES_PATH + "body/player_feet.png")
    am.playerFront          = rl.LoadTexture(RESOURCES_PATH + "body/player_front.png")
    am.playerHead           = rl.LoadTexture(RESOURCES_PATH + "body/player_head.png")
    am.sunglasses           = rl.LoadTexture(RESOURCES_PATH + "body/sunglasses.png")
    am.thumbs               = rl.LoadTexture(RESOURCES_PATH + "body/Thumbs.png")
    am.frame                = rl.LoadTexture(RESOURCES_PATH + "frame.png")
    
    // Environment sprites
    am.dirt                 = rl.LoadTexture(RESOURCES_PATH + "dirt.png")
    am.textures             = rl.LoadTexture(RESOURCES_PATH + "textures.png")
    am.backgroundTextures   = rl.LoadTexture(RESOURCES_PATH + "texturesWithBackgroundVersion.png")
    am.treeTextures         = rl.LoadTexture(RESOURCES_PATH + "treetextures.png")
    am.caveBG               = rl.LoadTexture(RESOURCES_PATH + "caveBG.png")
    am.desertBG             = rl.LoadTexture(RESOURCES_PATH + "desertBG.png")
    am.forestBG             = rl.LoadTexture(RESOURCES_PATH + "forestBG.png")
    am.snowBG               = rl.LoadTexture(RESOURCES_PATH + "snowBG.png")
    
    // Enemy sprites
    am.blueSlime            = rl.LoadTexture(RESOURCES_PATH + "blueslime.png")
    am.evilEye              = rl.LoadTexture(RESOURCES_PATH + "evilEye.png")
    am.iceSlime             = rl.LoadTexture(RESOURCES_PATH + "iceslime.png")
    am.mummy                = rl.LoadTexture(RESOURCES_PATH + "mummy.png")
    am.slime                = rl.LoadTexture(RESOURCES_PATH + "slime.png")
    am.smallBlueSlime       = rl.LoadTexture(RESOURCES_PATH + "smallblueslime.png")
    am.zombieEskimo         = rl.LoadTexture(RESOURCES_PATH + "zombie_eskimo.png")
    am.zombie               = rl.LoadTexture(RESOURCES_PATH + "zombie.png")
    
    // Music
    am.bonus                = rl.LoadMusicStream(RESOURCES_PATH + "/music/bonus.ogg")
    am.cave                 = rl.LoadMusicStream(RESOURCES_PATH + "/music/cave.ogg")
    am.credits              = rl.LoadMusicStream(RESOURCES_PATH + "/music/Credits.ogg")
    am.desert               = rl.LoadMusicStream(RESOURCES_PATH + "/music/desert.ogg")
    am.forest               = rl.LoadMusicStream(RESOURCES_PATH + "/music/forest.ogg")
    am.snow                 = rl.LoadMusicStream(RESOURCES_PATH + "/music/snow.ogg")
    
    // Sound
    am.breakSound           = rl.LoadSound(RESOURCES_PATH + "sounds/break.ogg")
    am.place                = rl.LoadSound(RESOURCES_PATH + "sounds/place.ogg")
    am.backButton           = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/BackButton.ogg")
    am.buttonPress          = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/ButtonPress.ogg")
    am.checkBoxOff          = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/CheckBoxOff.ogg")
    am.checkBoxOn           = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/CheckBoxOn.ogg")
    am.finalHit1            = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/FinalHit1.ogg")
    am.finalHit2            = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/FinalHit2.ogg")
    am.finalHit3            = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/FinalHit3.ogg")
    am.hImpact1             = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/HImpact1.ogg")
    am.hImpact2             = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/HImpact2.ogg")
    am.hImpact3             = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/HImpact3.ogg")
    am.hit1                 = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Hit1.ogg")
    am.hit2                 = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Hit2.ogg")
    am.hit3                 = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Hit3.ogg")
    am.slider               = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Slider.ogg")
    am.stone1               = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Stone1.ogg")
    am.stone2               = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Stone2.ogg")
    am.stone3               = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Stone3.ogg")
    am.stone4               = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Stone4.ogg")
    am.stone5               = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Stone5.ogg")
    am.stone6               = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Stone6.ogg")
    am.stone7               = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Stone7.ogg")
    am.wood1                = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Wood1.ogg")
    am.wood2                = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Wood2.ogg")
    am.wood3                = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Wood3.ogg")
    am.wood4                = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Wood4.ogg")
    am.wood5                = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Wood5.ogg")
    am.wood6                = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Wood6.ogg")
    am.wood7                = rl.LoadSound(RESOURCES_PATH + "sounds/bonus/Wood7.ogg")
}

unload_all_assets :: proc(am : ^AssetManager) {
// Player Sprites
    rl.UnloadTexture(am.player)
    rl.UnloadTexture(am.playerSprites)
    rl.UnloadTexture(am.items)
    rl.UnloadTexture(am.hearts)
    rl.UnloadTexture(am.copperArmorBack)
    rl.UnloadTexture(am.copperArmorFeet)
    rl.UnloadTexture(am.copperArmorFront)
    rl.UnloadTexture(am.copperArmorHead)
    rl.UnloadTexture(am.goldArmorBack)
    rl.UnloadTexture(am.goldArmorFeet)
    rl.UnloadTexture(am.goldArmorFront)
    rl.UnloadTexture(am.goldArmorHead)
    rl.UnloadTexture(am.iceArmorBack)
    rl.UnloadTexture(am.iceArmorFeet)
    rl.UnloadTexture(am.iceArmorFront)
    rl.UnloadTexture(am.iceArmorHead)
    rl.UnloadTexture(am.ironArmorBack)
    rl.UnloadTexture(am.ironArmorFeet)
    rl.UnloadTexture(am.ironArmorFront)
    rl.UnloadTexture(am.ironArmorHead)
    rl.UnloadTexture(am.partyHat)
    rl.UnloadTexture(am.playerBack)
    rl.UnloadTexture(am.playerFeet)
    rl.UnloadTexture(am.playerFront)
    rl.UnloadTexture(am.playerHead)
    rl.UnloadTexture(am.sunglasses)
    rl.UnloadTexture(am.thumbs)
    rl.UnloadTexture(am.frame)

    // Environment sprites
    rl.UnloadTexture(am.dirt)
    rl.UnloadTexture(am.textures)
    rl.UnloadTexture(am.backgroundTextures)
    rl.UnloadTexture(am.treeTextures)
    rl.UnloadTexture(am.caveBG)
    rl.UnloadTexture(am.desertBG)
    rl.UnloadTexture(am.forestBG)
    rl.UnloadTexture(am.snowBG)

    // Enemy sprites
    rl.UnloadTexture(am.blueSlime)
    rl.UnloadTexture(am.evilEye)
    rl.UnloadTexture(am.iceSlime)
    rl.UnloadTexture(am.mummy)
    rl.UnloadTexture(am.slime)
    rl.UnloadTexture(am.smallBlueSlime)
    rl.UnloadTexture(am.zombieEskimo)
    rl.UnloadTexture(am.zombie)

    // Music
    rl.UnloadMusicStream(am.bonus)
    rl.UnloadMusicStream(am.cave)
    rl.UnloadMusicStream(am.credits)
    rl.UnloadMusicStream(am.desert)
    rl.UnloadMusicStream(am.forest)
    rl.UnloadMusicStream(am.snow)

    // Sound
    rl.UnloadSound(am.breakSound)
    rl.UnloadSound(am.place)
    rl.UnloadSound(am.backButton)
    rl.UnloadSound(am.buttonPress)
    rl.UnloadSound(am.checkBoxOff)
    rl.UnloadSound(am.checkBoxOn)
    rl.UnloadSound(am.finalHit1)
    rl.UnloadSound(am.finalHit2)
    rl.UnloadSound(am.finalHit3)
    rl.UnloadSound(am.hImpact1)
    rl.UnloadSound(am.hImpact2)
    rl.UnloadSound(am.hImpact3)
    rl.UnloadSound(am.hit1)
    rl.UnloadSound(am.hit2)
    rl.UnloadSound(am.hit3)
    rl.UnloadSound(am.slider)
    rl.UnloadSound(am.stone1)
    rl.UnloadSound(am.stone2)
    rl.UnloadSound(am.stone3)
    rl.UnloadSound(am.stone4)
    rl.UnloadSound(am.stone5)
    rl.UnloadSound(am.stone6)
    rl.UnloadSound(am.stone7)
    rl.UnloadSound(am.wood1)
    rl.UnloadSound(am.wood2)
    rl.UnloadSound(am.wood3)
    rl.UnloadSound(am.wood4)
    rl.UnloadSound(am.wood5)
    rl.UnloadSound(am.wood6)
    rl.UnloadSound(am.wood7)
}