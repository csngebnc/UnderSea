﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnderSea.Model.Constants;

namespace UnderSea.Model.Models
{
    public class Alchemy : Effect
    {
        public override void ApplyEffect(Country country)
        {
            country.Production.PearlProductionMultiplier *= (1+UpgradeConstants.Alchemy);
        }

        public override void RemoveEffect(Country country)
        {
            country.Production.PearlProductionMultiplier /= (1+UpgradeConstants.Alchemy);
        }
    }
}
