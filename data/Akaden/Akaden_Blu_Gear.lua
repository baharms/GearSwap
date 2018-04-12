
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','FullAcc','None')
	state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','HighAcc','FullAcc','Fodder')
    state.CastingMode:options('Normal','Resistant','Fodder')
    state.IdleMode:options('Normal', 'DTKite','PDT', 'MDT','DT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Default','SavageBlade','MagicWeapons', 'None')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'MP','SuppaBrutal', 'DWEarrings','DWMax'}

	gear.da_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.stp_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.crit_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.wsd_jse_back = {name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.mab_jse_back = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

	gear.obi_cure_waist = "Luminary Sash"
	gear.obi_nuke_waist = "Yamabuki-no-Obi"

	-- Additional local binds
	--send_command('bind ^` input /ja "Chain Affinity" <me>')
	--send_command('bind @` input /ja "Efflux" <me>')
	--send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	--send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	--send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
    send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	--send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	update_combat_form()
	select_default_macro_book()
end

function init_gear_sets()

    include('augmented_gear.lua')
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {feet="Mavi Basmak +1"}
	sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2", feet="Assimilator's Charuqs +1"}
	--sets.buff.Convergence = {head="Luh. Keffiyeh +1"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
	sets.buff.Enchainment = {body="Luhlaza Jubbah"}
	sets.buff.Efflux = {back="Rosmerta's cape",legs="Hashishin Tayt +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {}

    sets.dt = {
    	head="Ayanmo Zucchetto +2",
    	neck="Twilight Torque",
    	ear1="Ethereal Earring",
    	body="Ayanmo corazza +2",
    	hands="Ayanmo manopolas +1",
    	ring1="Ayanmo ring",
    	back="Moonbeam cape",
    	waist="Flume belt",		
    	legs="ayanmo cosciales +2",
    	feet="Ayanmo gambieras +1"
	}

	sets.weapons = {}
	sets.weapons.Default = {main="Tizona",sub="Colada"}
	sets.weapons.SavageBlade = {main="Sequence",sub="Colada"}
	sets.weapons.MagicWeapons = {main="Nibiru Cudgel", sub="Vampirism"}
	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +1"}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells

	sets.precast.FC = set_combine(sets.engaged, {
        head="Carmine mask",
        neck="Baetyl pendant", 
        ear1="Halasz earring", -- mp
        ear2="Gifted earring", -- mp
        body="Samnuha coat",
        hands="Leyline gloves",
        ring1="Kishar ring",
        back={ name="Rosmerta's Cape", augments={'"Fast Cast"+10',}},
        legs="Psycloth lappas",
        feet="Amalric nails"
    })

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga beads"})

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +2"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        ammo="Jukukik feather",
    	head=augmented_gear.Herculean.WSD.STR.head,
        neck="Rancor collar",
        body="Assimilator's Jubbah +3",
        hands="jhakri cuffs +2",
        ear2="Ishvara Earring",
        ear1="Moonshade earring",
        ring2="Karieyh ring",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10',}},
        waist="Fotia Belt",
        legs=augmented_gear.Herculean.WSD.STR.legs,
    	feet=augmented_gear.Herculean.WSD.STR.feet,
    }

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})

	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
            head="Jhakri coronal +2",
            hands="jhakri cuffs +2",
            body="Assim. Jubbah +3",
            legs="Hashishin tayt +1",
            feet="Jhakri pigaches +2",
            ring1="Stikini Ring",
            ring2="Karieyh ring",
            ammo="Hasty pinion +1"
	})
	sets.precast.WS['Requiescat'].SomeAcc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].HighAcc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {})

	--sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {head="Jhakri Coronal +2",ear1="Regal Earring",body="Jhakri Robe +2",ring2="Rufescent Ring",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	--sets.precast.WS['Realmrazer'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Jhakri Coronal +2",ear1="Regal Earring",ear2="Telos Earring",body="Jhakri Robe +2",ring2="Rufescent Ring",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	--sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {head="Jhakri Coronal +2",ear1="Regal Earring",ear2="Telos Earring",ring1="Rufescent Ring",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"})
	--sets.precast.WS['Realmrazer'].HighAcc = set_combine(sets.precast.WS.HighAcc, {ring1="Rufescent Ring",feet="Jhakri Pigaches +2"})
	--sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	--sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Jukukik feather",
        head="Adhemar Bonnet",
        body="Assimilator's Jubbah +3",
        neck="Fotia Gorget",
        ear2="Brutal Earring",
        hands="jhakri cuffs +2",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20', 'DEX+10','Crit.hit rate+10',}},
        waist="Fotia Belt",
        ring1="Ilabrat Ring",
        ring2="Karieyh ring",
        legs=augmented_gear.Herculean.CritDMG.DEX.legs,
        feet="Thereoid Greaves"
    })
	sets.precast.WS['Chant du Cygne'].SomeAcc = set_combine(sets.precast.WS['Chant du Cygne'], {})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'].SomeAcc, {
		ammo="Hasty Pinion +1",
		ear1="Dignitary's earring",
		ear2="Cessance Earring",
	})
	sets.precast.WS['Chant du Cygne'].HighAcc = set_combine(sets.precast.WS['Chant du Cygne'].Acc, {})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS['Chant du Cygne'].HighAcc, {})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Floestone",
    	head=augmented_gear.Herculean.WSD.STR.head,
        neck="Caro Necklace",
        ear2="Ishvara Earring",
        body="Assimilator's Jubbah +3",
        hands="jhakri cuffs +2",
        ring2="Karieyh ring",
    	ring1="Ifrit ring +1",
        waist="Prosilio belt",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10',}},
        legs=augmented_gear.Herculean.WSD.STR.legs,
    	feet=augmented_gear.Herculean.WSD.STR.feet,
    })
	sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS['Savage Blade'], {}) 
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'], {})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})

	--sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet +1",ear1="Cessance Earring", ear2="Brutal Earring",ring2="Begrudging Ring",back=gear.crit_jse_back,feet="Thereoid Greaves"})
	--sets.precast.WS['Vorpal Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet +1",ring2="Begrudging Ring",back=gear.crit_jse_back})
	--sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {back=gear.crit_jse_back})
	--sets.precast.WS['Vorpal Blade'].HighAcc = set_combine(sets.precast.WS.HighAcc, {})
	--sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	--sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})

	--sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ifrit Ring +1",ring2="Rufescent Ring",back=gear.wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet})
	--sets.precast.WS['Expiacion'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ear1="Moonshade Earring",ear2="Ishvara Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",ring1="Ifrit Ring +1",ring2="Rufescent Ring",back=gear.wsd_jse_back,waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet})
	--sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",back=gear.wsd_jse_back,legs="Carmine Cuisses +1",feet=gear.herculean_wsd_feet})
	--sets.precast.WS['Expiacion'].HighAcc = set_combine(sets.precast.WS.HighAcc, {ear2="Moonshade Earring",body="Assim. Jubbah +3",hands="Jhakri Cuffs +2",back=gear.wsd_jse_back,legs="Carmine Cuisses +1",feet=gear.herculean_wsd_feet})
	--sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS.FullAcc, {body="Assim. Jubbah +3",hands="Jhakri Cuffs +2"})
	--sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {
        ammo="Floestone",
    	head=augmented_gear.Herculean.WSD.STR.head,
        neck="Caro Necklace",
        ear2="Ishvara Earring",
        body="Assimilator's Jubbah +3",
        hands="jhakri cuffs +2",
        ring2="Karieyh ring",
        ring1="Ifrit ring +1",
        waist="Prosilio belt",
        back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20', 'STR+10', 'Weapon skill damage +10',}},
        legs=augmented_gear.Herculean.WSD.STR.legs,
    	feet=augmented_gear.Herculean.WSD.STR.feet,
    })
	sets.precast.WS['Expiacion'].SomeAcc = set_combine(sets.precast.WS['Expiacion'], {}) 
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Expiacion'], {})
	sets.precast.WS['Expiacion'].HighAcc = set_combine(sets.precast.WS['Expiacion'], {})
	sets.precast.WS['Expiacion'].FullAcc = set_combine(sets.precast.WS['Expiacion'], {})
	sets.precast.WS['Expiacion'].Fodder = set_combine(sets.precast.WS['Expiacion'], {})

	--sets.precast.WS['Sanguine Blade'] = set_combine(sets.midcast['Blue Magic'].Magical, {})

	--sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
	--		         head="Jhakri Coronal +2",neck="Baetyl Pendant",ear1="Regal Earring",ear2="Friomisi Earring",
	--	             body="Jhakri Robe +2",hands="Jhakri Cuffs +2",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
	--		         back=gear.mab_jse_back,waist="Yamabuki-no-Obi",legs="Jhakri Slops +2",feet="Jhakri Pigaches +2"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.AccMaxTP = {ear1="Cessance Earring",ear2="Dignitary's Earring"}

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast['Blue Magic'] = {}

	-- Physical Spells --

	sets.midcast['Blue Magic'].Physical = {
        head=augmented_gear.Herculean.WSD.STR.head,
        neck="Caro necklace",
        ear1="Assuage earring",
        ear2="Moonshade earring",
        body="Adhemar Jacket",
    	hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
        ring2="Ifrit ring +1",
        back="Buquwik Cape",
        waist="Prosilio belt",
        legs=augmented_gear.Herculean.WSD.STR.legs,
        feet="Rawhide boots"
    }

	sets.midcast['Blue Magic'].Physical.Resistant = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].Physical.Fodder = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {})

	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = set_combine(sets.midcast['Blue Magic'].Fodder, {})

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
    	hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
        waist="Chiner's belt +1",
        legs="Hashishin Tayt",
        back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
    })
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})

	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})


	-- Magical Spells --

	sets.midcast['Blue Magic'].Magical = {
		ammo="Pemphredo Tathlum",
        head="Jhakri coronal +2",
        neck="Baetyl pendant",
        body="Shamash Robe",
        ear1="Friomisi earring",
        ear2="Hecate's earring",
        hands="Jhakri cuffs +2",
        ring1="Acumen ring",
        ring2="Shiva Ring +1",
        waist="Salire belt",
        legs="Amalric Slops",
        feet="Jhakri pigaches +2",
    	back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','System: 1 ID: 1155 Val: 4',}},
    }

	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].Magical.Fodder = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Pemphredo Tathlum",
        head="Assimilator's Keffiyeh +3",
        body="Ayanmo corazza +2",
        neck="Erra pendant",
        hands="jhakri cuffs +2",
        ear2="Hermetic earring",
        ear1="Dignitary's earring",
        ring1="Stikini ring",
        ring2="Etana ring",
        legs="ayanmo cosciales +2",
        feet="Jhakri pigaches +2"
    })

	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.midcast['Enhancing Magic'] = {}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast['Divine Magic'] = {}

	sets.midcast['Elemental Magic'] = {}

	sets.midcast['Elemental Magic'].Resistant = {}

	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {})
	sets.midcast.Helix.Resistant = set_combine(sets.midcast['Elemental Magic'].Fodder, {})

	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Earth = {neck="Quanpur Necklace"}
	sets.element.Light = {} --ring2="Weatherspoon Ring"

	sets.midcast.Cure = {
        head="Rabid Visor",
        neck="Phalaina locket",
        body="Rawhide Vest",
        hands="Telchine Gloves",
        legs="Psycloth Lappas",
        feet="Medium's sabots",
        ear1="Mendi. Earring",
        back="Solemnity cape",
        legs="Gyve trousers"
    }

	-- Breath Spells --

	sets.midcast['Blue Magic'].Breath = {}

	-- Physical Added Effect Spells most notably "Stun" spells --

	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Blue Magic'].Stun.Resistant = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

	sets.midcast['Blue Magic'].Stun.Fodder = set_combine(sets.midcast['Blue Magic'].Stun, {})

	-- Other Specific Spells --

	sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast.Cure, {
		ammo="Falcon eye",
		head="Assimilator's Keffiyeh +3",
		body="Assimilator's Jubbah +3",
		ear2="Ethereal earring",
		ring1="Ilabrat ring",
		ring2="Etana ring",
		back="moonbeam cape"
		})
					
	sets.midcast['Blue Magic']['Healing Breeze'] = set_combine(sets.midcast.Cure, {})

	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast.Cure, {})

	sets.midcast['Blue Magic']['Tenebral Crush'] = set_combine(sets.midcast['Blue Magic'].Magical, sets.element.dark)

	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = set_combine(sets.midcast.Cure,{})

	sets.midcast['Blue Magic'].SkillBasedBuff = {}

	sets.midcast['Blue Magic'].Buff = {}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})

	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {body="Assimilator's Jubbah +3",hands="Assim. Bazu. +1",legs="Hashishin tayt +1", feet="Luhlaza charuqs"}

	-- Engaged sets

	sets.engaged = {
        ammo="Ginsen",
        head="Adhemar Bonnet",
        neck="Lissome Necklace",
        ear1='Suppanomimi',
        ear2="Brutal Earring",
        body="Adhemar Jacket",
    	hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
        ring1="Hetairoi ring",
        ring2="Epona's ring",
    	back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
        waist="Windbuffet belt +1",
        legs="Samnuha tights",
    	feet=augmented_gear.Herculean.TA.feet,
    }

	sets.engaged.AM = set_combine(sets.engaged, {neck="Asperity Necklace", ear2="Dedition earring", ring1="Ilabrat Ring"})

	sets.engaged.MinAcc = set_combine(sets.engaged, {})

	--sets.engaged.MinAcc.AM = set_combine(sets.engaged, {})

	sets.engaged.SomeAcc = set_combine(sets.engaged, {})

	--sets.engaged.SomeAcc.AM = set_combine(sets.engaged, {})

	sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Falcon Eye",
        head="Ayanmo Zucchetto +2",
        neck='Ej necklace',
        ear1="Dignitary's earring",
        ear2="Telos earring",
        ring1="Ilabrat ring",
        waist="Kentarch belt +1",
        legs="Ayanmo cosciales +2",
    })

	sets.engaged.Acc.AM = set_combine(sets.engaged.Acc, {ring1="Ilabrat Ring", ear2="Telos earring"})

	sets.engaged.HighAcc = set_combine(sets.engaged.Acc, {})

	--sets.engaged.HighAcc.AM = set_combine(sets.engaged, {})

	sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {})

	--sets.engaged.FullAcc.AM = set_combine(sets.engaged, {})

	sets.engaged.Fodder = set_combine(sets.engaged, {})

	--sets.engaged.Fodder.AM = set_combine(sets.engaged, {})

	sets.engaged.DTLite = set_combine(sets.engaged, {
    	head="Ayanmo Zucchetto +2",
    	neck="Twilight Torque",
    	body="Ayanmo corazza +2",
    	ring1="Ayanmo ring",
	})

	--sets.engaged.DTLite.AM = set_combine(sets.engaged, {})

	sets.engaged.PDT = set_combine(sets.dt, {
		neck="wiglen gorget",
		body="Shamash robe",
		waist="Flume belt",
		ring2="Warden's ring"
		})

	sets.engaged.MinAcc.DTLite = set_combine(sets.engaged.DTLite, {})

	sets.engaged.MinAcc.PDT = set_combine(sets.engaged.PDT, {})

	sets.engaged.SomeAcc.DTLite = set_combine(sets.engaged.PDT, {})

	sets.engaged.SomeAcc.PDT = set_combine(sets.engaged.PDT, {})

	sets.engaged.Acc.DTLite = set_combine(sets.engaged.DTLite, {})

	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {})

	sets.engaged.HighAcc.DTLite = set_combine(sets.engaged.DTLite, {})

	sets.engaged.HighAcc.PDT = set_combine(sets.engaged.PDT, {})

	sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.DTLite, {})

	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.PDT, {})

	sets.engaged.Fodder.DTLite = set_combine(sets.engaged.DTLite, {})

	--sets.engaged.Fodder.DTLite.AM = set_combine(sets.engaged, {})

	sets.engaged.Fodder.PDT = set_combine(sets.engaged.PDT, {})

	sets.engaged.MDT = set_combine(sets.dt, {
		ring2="Yacuruna ring",
	})

	sets.engaged.MinAcc.MDT = set_combine(sets.engaged.MDT, {})

	sets.engaged.SomeAcc.MDT = set_combine(sets.engaged.MDT, {})

	sets.engaged.Acc.MDT = set_combine(sets.engaged.MDT, {})

	sets.engaged.HighAcc.MDT = set_combine(sets.engaged.MDT, {})

	sets.engaged.FullAcc.MDT = set_combine(sets.engaged.MDT, {})

	sets.engaged.Fodder.MDT = set_combine(sets.engaged.MDT, {})

	-- Idle sets
	sets.idle = set_combine(sets.engaged, {
            head="Rawhide mask",
            neck="wiglen gorget",
            body="Shamash robe",
        	hands=augmented_gear.Herculean.Refresh.hands,
            hands="Herculean gloves",
            ring1="Karieyh ring",
            ring2="Paguroidea ring",
            back="moonbeam cape",
            legs="Carmine Cuisses +1",
            feet="Serpentes Sabots"
        })
	sets.idle.Town = set_combine(sets.idle, {})

	-- Resting sets
	sets.resting = set_combine(sets.idle, {})

	sets.idle.Sphere = set_combine(sets.idle, {})

	sets.idle.PDT = set_combine(sets.engaged.PDT, {})

	sets.idle.MDT = set_combine(sets.engaged.MDT, {})

	sets.idle.DT = set_combine(sets.dt, {})

	sets.idle.DTKite = set_combine(sets.dt, {
		legs="Carmine Cuisses +1"
		})

	-- Defense sets
	sets.defense.PDT = set_combine(sets.dt, {
		neck="wiglen gorget",
		body="Shamash robe",
		ring2="Warden's ring",
		})

	sets.defense.MDT = set_combine(sets.dt, {
		ring2="Yacuruna ring",
	})

    sets.defense.MEVA = set_combine(sets.dt, {
		body="Shamash robe",
    	legs="Hashishin tayt +1",
    	feet="Amalric nails"
	})

	sets.defense.NukeLock = set_combine(sets.midcast['Blue Magic'].Magical, {})

	sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt",ear1="Suppanomimi", ear2="Ethereal Earring"}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket +1",waist="Reiki Yotai",legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt"})
	sets.Assault = {ring1="Balrahn's Ring"}
	sets.Capacity={back="Aptitude Mantle"}

	sets.Self_Healing = {neck="Phalaina locket"}
	sets.Self_Healing_Club = {}
	sets.Self_Healing_DWClub = {}
	sets.Healing_Club = {}
	sets.Healing_DWClub = {}
	sets.Cure_Received = {neck="Phalaina locket"}
	sets.Self_Refresh = {}
	sets.MagicBurst = {hands="Amalric Gages",ring1="Mujin Band",ring2="Locus Ring"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 18)
end

--Job Specific Trust Overwrite
function check_trust()
	--if not moving then
	--	if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
	--		local party = windower.ffxi.get_party()
	--		if party.p5 == nil then
	--			local spell_recasts = windower.ffxi.get_spell_recasts()
--
	--			if spell_recasts[980] == 0 and not have_trust("Yoran-Oran") then
	--				windower.chat.input('/ma "Yoran-Oran (UC)" <me>')
	--				tickdelay = 250
	--				return true
	--			elseif spell_recasts[952] == 0 and not have_trust("Koru-Moru") then
	--				windower.chat.input('/ma "Koru-Moru" <me>')
	--				tickdelay = 250
	--				return true
	--			elseif spell_recasts[967] == 0 and not have_trust("Qultada") then
	--				windower.chat.input('/ma "Qultada" <me>')
	--				tickdelay = 250
	--				return true
	--			elseif spell_recasts[914] == 0 and not have_trust("Ulmia") then
	--				windower.chat.input('/ma "Ulmia" <me>')
	--				tickdelay = 250
	--				return true
	--			elseif spell_recasts[979] == 0 and not have_trust("Selh'teus") then
	--				windower.chat.input('/ma "Selh\'teus" <me>')
	--				tickdelay = 250
	--				return true
	--			else
	--				return false
	--			end
	--		end
	--	end
	--end
	return false
end
