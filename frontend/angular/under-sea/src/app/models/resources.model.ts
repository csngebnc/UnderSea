export type Resources = {
    units: Array<[string, number]>;
    buildings: Array<[string, number]>;
    buildingsUnderConstruction: Array<[string, number]>;
    shells: number;
    shellsPerRound:number;
    corals: number;
    coralsPerRound: number;
}