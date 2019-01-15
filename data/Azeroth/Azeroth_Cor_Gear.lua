
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'FullAcc','Crits')
    state.RangedMode:options('Normal', 'Acc','FullAcc','Crits')
    state.HybridMode:options('Normal','DTLite','PDT','MDT')
    state.WeaponskillMode:options('Match','Normal', 'Acc','FullAcc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'DWMax'}
    state.RHAutoWS = M{'','Leaden Salute', 'Last Stand','Wildfire'}
    state.Weapons:options('DWLeaden','DWLastStand', 'SavageBlade', 'ShieldLeaden','ShieldLastStand','OneShot','MeleeLeaden','None')
    state.QuickDrawMode = M{'StoreTP','Damage'}
    state.QuickDrawAug = false

    state.LastRoll = 'unknown'
    ammostock = 999
    --ammostock['Chrono Bullet'] = 100
    --ammostock['Living Bullet'] = 30

    gear.RAbullet = "Adlivun Bullet"
    gear.WSbullet = "Adlivun Bullet"
    gear.MAbullet = "Orichalcum bullet" --For MAB WS, do not put single-use bullets here.
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

	gear.tp_ranger_jse_back = {}
	gear.snapshot_jse_back = {name="Camulus's Mantle",augments={'"Snapshot"+10',}}
	gear.tp_jse_back = {name="Camulus's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.magic_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.str_wsd_jse_back = {name="Camulus's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    -- Additional local binds
	--send_command('bind !f11 gs c cycle ExtraMeleeMode')
	--send_command('bind ^` gs c cycle ElementalMode')
	--send_command('bind !` gs c elemental quickdraw')
	--
	--send_command('bind ^backspace input /ja "Double-up" <me>')
	--send_command('bind @backspace input /ja "Snake Eye" <me>')
	--send_command('bind !backspace input /ja "Fold" <me>')
	--send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	--
	--send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    --send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	--send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	--send_command('bind @f7 gs c toggle RngHelper')
--
	--send_command('bind !r gs c weapons SingleWeapon;gs c update')
	--send_command('bind @q gs c weapons MaccWeapons;gs c update')
	--send_command('bind ^q gs c weapons DualRangedWeapons;gs c update')
	--send_command('bind !q gs c weapons SavageWeapons;gs c update')
	--send_command('bind @pause roller roll')
--
    --send_command('gs rh set')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    include('augmented_gear.lua')
    augmented_gear.capes={
        stp={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
        str_wsd={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
        mab_wsd={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
    }
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.weapons = {}
    sets.weapons.SavageBlade = {main='Hepatizon sapara +1', sub="Blurred Knife +1", range="Anarchy +2"}
    sets.weapons.MeleeLeaden = {main='Hepatizon sapara +1', sub="Blurred Knife +1", range="Compensator"}

    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt"})
    sets.Capacity = {back="Aptitude Mantle"}
    
    -- Precast Sets

    -- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun trews"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
    
    sets.precast.CorsairRoll = {
        head="Lanun Tricorne",
        --neck="Regal necklace",
        hands="Chasseur's Gants +1",
        back="Camulus's Mantle",
        legs="Desultor Tassets",
        ring1="Barataria ring"}
		
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head=augmented_gear.Adhemar.Atk.head,
        body="Meghanada cuirie +2",
        hands=augmented_gear.Adhemar.Atk.hands,
        legs="Samnuha Tights",
        feet=augmented_gear.Herculean.TA.feet,
        neck="Agasaya's Collar",
        ring1="Petrov Ring",
        ring2="Epona's ring",
        ear1="Suppanomimi",
        ear2="Brutal Earring",
        waist="Kentarch belt +1",
        back=augmented_gear.capes.stp,
    } 
    sets.engaged.Acc = set_combine(sets.engaged, {
        head="Meghanada visor +1",
        legs="Meghanada chausses +2"
    })
    sets.engaged.FullAcc = set_combine(sets.engaged.Acc, {})
    sets.engaged.Crits = set_combine(sets.engaged.FullAcc, {})
    sets.engaged.DTLite = set_combine(sets.engaged,{})
    sets.engaged.Acc.DTLite = set_combine(sets.engaged.Acc, {})
    sets.engaged.FullAcc.DTLite = set_combine(sets.engaged.FullAcc, {})

    sets.engaged.DW = set_combine(sets.engaged, {})    
    sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {})    
    sets.engaged.DW.FullAcc = set_combine(sets.engaged.FullAcc, {})
    sets.engaged.DW.Hybrid = set_combine(sets.engaged.Hybrid, {})
    sets.engaged.DW.DTLite = set_combine(sets.engaged.DTLite, {})
    sets.engaged.DW.Acc.DTLite = set_combine(sets.engaged.Acc.DTLite, {})
    sets.engaged.DW.FullAcc.DTLite = set_combine(sets.engaged.FullAcc.DTLite, {})

    gear.CorsairShot = {}
    gear.CorsairShot.Augment = {feet="Chasseur's bottes +1",}
    sets.precast.CorsairShot = {ammo=gear.MAbullet,}
    sets.precast.CorsairShot.StoreTP = set_combine(sets.precast.CorsairShot,{ 
    -- 57 STP
    })
    sets.precast.CorsairShot.Proc = set_combine(sets.precast.CorsairShot, {})
    sets.precast.CorsairShot.Acc =  set_combine(sets.precast.CorsairShot['Light Shot'], {})
    sets.precast.CorsairShot['Light Shot'] = set_combine(sets.precast.CorsairShot.Acc, {})
    sets.precast.CorsairShot['Dark Shot'] = set_combine(sets.precast.CorsairShot.Acc, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = { }
		
	sets.Self_Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = set_combine(sets.engaged, {})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga beads"})	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.RA = {}		
	sets.precast.RA.Flurry = set_combine(sets.precast.RA, { })
	sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry, { })

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.Acc = {}
    sets.precast.WS.Proc = {}
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.engaged, {
        head=augmented_gear.Herculean.WSD.STR.head,
        body="Laksamana's Frac +3",
        hands="Meghanada gloves +2",
        legs=augmented_gear.Herculean.WSD.STR.legs,
        feet=augmented_gear.Herculean.WSD.STR.feet,
        neck="Fotia Gorget",
        waist="Fotia belt",
        ear1="Moonshade earring",
        ear2="Ishvara earring",
        ring2="Karieyh ring",
        back=augmented_gear.capes.str_wsd,
    })
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast['Savage Blade'], {})
    sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'].Acc, {})
	
    sets.precast.WS['Last Stand'] = {}
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'],{})
    sets.precast.WS['Last Stand'].FullAcc = set_combine(sets.precast.WS['Last Stand'].Acc,{})	

    sets.precast.WS['Detonator'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
    sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
    sets.precast.WS['Numbing Shot'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Numbing Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
    sets.precast.WS['Sniper Shot'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Sniper Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
    sets.precast.WS['Split Shot'] = set_combine(sets.precast.WS['Last Stand'], {})
    sets.precast.WS['Split Shot'].Acc = set_combine(sets.precast.WS['Last Stand'].Acc, {})
	
    sets.precast.WS['Leaden Salute'] = {   
        ammo=gear.MABullet,
        head="Pixie Hairpin +1",
        body="Laksamana's Frac +3",
        hands="Carmine Finger Gauntlets +1",
        legs=augmented_gear.Herculean.WSD.MAB.legs,
        feet=augmented_gear.Herculean.WSD.MAB.feet,
        neck="Stoicheion medal",
        ear1="Moonshade earring",
        ear2="Friomisi earring",   
        ring1="Dingir ring",  
        ring2="Karieyh ring",
        waist="Sveltesse gouriz",
        back=augmented_gear.capes.mab_wsd,
    }
    sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'],{})
    sets.precast.WS['Leaden Salute'].FullAcc = set_combine(sets.precast.WS['Leaden Salute'], {})

    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS["Leaden Salute"], {})
    sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {})	

    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS['Wildfire'], {})
    sets.precast.WS['Hot Shot'].Acc = set_combine(sets.precast.WS['Wildfire'].Acc, {})
		
		--Because omen skillchains.
    sets.precast.WS['Burning Blade'] = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear2="Ishvara Earring"}
	sets.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
        
    -- Specific spells

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
    sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {}
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{})
    sets.midcast.RA.Crits = set_combine(sets.midcast.RA,{})
    sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA.Acc,{})
		
	sets.buff['Triple Shot'] = {}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}    

    -- Idle sets

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.idle = set_combine(sets.engaged, {ring1="Defending Ring"})		
    sets.idle.Refresh = set_combine(sets.idle, {})
    sets.idle.Town = set_combine(sets.idle, sets.Kiting, {})
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {})
    sets.idle.PDT = set_combine(sets.defense.PDT, {})
    sets.defense.MDT = set_combine(sets.idle, {})		
    sets.defense.MEVA = set_combine(sets.idle, {})	
    sets.TreasureHunter = set_combine(sets.TreasureHunter, {head="White Rarab Cap +1", waist = "Chaac belt"})	
	sets.DWMax = {}
end

function user_job_self_command(commandArgs, eventArgs)
    if commandArgs[1]:lower() == 'corsairshotaug' then
        state.QuickDrawAug = true
        job_self_command({'elemental','quickdraw'}, eventArgs)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 8)
    
    windower.chat.input:schedule(1,'/lockstyleset 7')
end

function user_job_pretarget(spell, spellMap, eventArgs)
    if spell.type == "CorsairRoll" and 
        buffactive[spell.english] and 
        buffactive["Double-Up Chance"] and 
        (state.LastRoll == spell.english or state.LastRoll == 'unknown') then 

        cancel_spell()
        send_command('input /ja "Double-Up" <me>')
    end 
end

function user_job_post_precast(spell, spellMap, eventArgs)

    --if spell.type == 'WeaponSkill' then
    --    -- Replace Moonshade Earring if we're at cap TP
    --    if (player.tp >= 2950 and moonshade_ws:contains(spell.english)) or
    --       (player.tp >= 2450 and moonshade_ws:contains(spell.english)) and ) then
    --        if check_ws_acc():contains('Acc') then
    --            if sets.AccMaxTP then
    --                equip(sets.AccMaxTP)
    --            end
    --        elseif sets.MaxTP then
    --                equip(sets.MaxTP)
    --        end
    --    end
    -- end   
    if spell.type == "CorsairRoll" and not buffactive[spell.english] then
        state.LastRoll = spell.english
    end
    if spell.type == 'CorsairShot' then
        if state.QuickDrawMode.value == 'StoreTP' then
            equip(sets.precast.CorsairShot.StoreTP)
        end
        if state.QuickDrawAug then
            equip(gear.CorsairShot.Augment)
            state.QuickDrawAug = false
        end
    end
end

function user_job_buff_change(buff, gain)
    if gain and buff == "Bust" and state.LastRoll ~= nil then
        lastRoll = state.LastRoll
        state.LastRoll = nil
    elseif not gain and state.LastRoll == buff then
        state.LastRoll = nil
    end
    if gain and buff == "Aurorastorm" then
        send_command('cancel 184')
        send_command('cancel 595')
        add_to_chat(123,'Auto-canceled Aurorastorm')
    end
end

windower.register_event('zone change', function()
    state.LastRoll = nil
end)