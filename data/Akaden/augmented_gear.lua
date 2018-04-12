augmented_gear = {}

-------------------
---- Merlinic -----
-------------------

augmented_gear.Merlinic = {}
augmented_gear.Merlinic.Damage = {
    head = { name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+8','Mag. Acc.+12','"Mag.Atk.Bns."+15',}},
    body = { name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
    --hands= ,
    legs = { name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Conserve MP"+6','INT+1','"Mag.Atk.Bns."+13',}},
    feet = { name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst mdg.+4%','Mag. Acc.+10','"Mag.Atk.Bns."+12',}},
}

augmented_gear.Merlinic.Burst = { 
    head= { name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst mdg.+4%','Mag. Acc.+8',}},
    body= augmented_gear.Merlinic.Damage.Body,
    --hands= ,
    legs= { name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst mdg.+4%','Mag. Acc.+10','"Mag.Atk.Bns."+5',}},
    feet= augmented_gear.Merlinic.Damage.Feet,
}

augmented_gear.Merlinic.Accuracy = { 
    head= augmented_gear.Merlinic.Damage.head,
    body= augmented_gear.Merlinic.Damage.Body,
    --hands= ,
    legs= augmented_gear.Merlinic.Damage.Legs,
    feet= augmented_gear.Merlinic.Damage.Feet,
}
augmented_gear.Herculean = {}
augmented_gear.Herculean.Refresh = {
    hands={ name="Herculean Gloves", augments={'Mag. Acc.+3','Damage taken-1%','"Refresh"+1','Accuracy+9 Attack+9','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
}

augmented_gear.Herculean.WSD = {}
augmented_gear.Herculean.WSD.MAB = {
    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +1%','MND+2','Mag. Acc.+3','"Mag.Atk.Bns."+10',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +2%','STR+2','"Mag.Atk.Bns."+13',}},
    feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +3%','MND+14',}},
}

augmented_gear.Herculean.WSD.STR = {
    head={ name="Herculean Helm", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','DEX+5',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+23 Attack+23','Weapon skill damage +2%','Accuracy+11','Attack+14',}},
    feet={ name="Herculean Boots", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','STR+9','Accuracy+9','Attack+12',}},
}

augmented_gear.Herculean.WSD.AGI = {
    body={ name="Herculean Vest", augments={'Weapon skill damage +4%','STR+6','Rng.Acc.+13','Rng.Atk.+12',}},
    legs={ name="Herculean Trousers", augments={'Rng.Acc.+24 Rng.Atk.+24','Weapon skill damage +2%','AGI+7','Rng.Atk.+8',}},
    feet=augmented_gear.Herculean.WSD.STR.feet,
}

augmented_gear.Herculean.CritDMG = {}
augmented_gear.Herculean.CritDMG.DEX = {
    legs={ name="Herculean Trousers", augments={'Accuracy+9','Crit. hit damage +3%','DEX+15','Attack+13',}},
}

augmented_gear.Herculean.TA = {
    feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+4','STR+3',}},
}