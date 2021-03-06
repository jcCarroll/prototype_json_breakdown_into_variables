require 'json'

class DropdownCreator

    attr_accessor :exposures, :subMenu, :subMenu2,:subMenu3, :noHazard, :interventions

    def initialize(exposures)
        @exposures = exposures
        @subMenu = subMenu
        @subMenu2 = subMenu2
        @subMenu3 = subMenu3
        @noHazard = noHazard
        @interventions = interventions

    end
    
    def get_subMenu_list
        subMenu = exposures.keys
        get_subMenu2_list(subMenu)
    end

    def get_subMenu2_list(subMenu)
        subMenu2 = {}
        subMenu.each do |area|
            subMenu2[area] = exposures[area]["Hazard Lists"].keys
        end
        get_subMenu3_list(subMenu, subMenu2)
    end

    def get_subMenu3_list(subMenu, subMenu2)
        subMenu3 = {}
        subMenu2.each do |area, list|
            list.each do |item|
                subMenu3[item] = exposures[area]["Hazard Lists"][item]["Hazards"].keys
            end
        end
        get_interventions(subMenu, subMenu2, subMenu3)
    end

    def get_interventions(subMenu, subMenu2, subMenu3)
        interventions = {}
        noHazard = {}
        exposures.keys.each do |area|
            exposures[area]["Hazard Lists"].keys.each do |list|
                exposures[area]["Hazard Lists"][list]["Hazards"].keys.each do |hazard|
                    if hazard == ""
                        interventions[list] = exposures[area]["Hazard Lists"][list]["Hazards"][hazard]["Interventions"]
                    else
                        interventions[hazard] = exposures[area]["Hazard Lists"][list]["Hazards"][hazard]["Interventions"]
                    end
                end
            end
        end
        return subMenu, subMenu2, subMenu3, interventions
    end
end