import { Effect } from './effect.model';

export type BuildingDetails = {
    id: string;
    name: string;
    effects: Array<Effect>;
    count: number;
    price: number;
}