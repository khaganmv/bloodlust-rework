@replaceMethod(BloodlustHealingEffector)
private final func ProcessAction(owner: ref<GameObject>) -> Void {
  let dismembermentInfo: DismembermentInstigatedInfo;
  let targetPuppet: ref<ScriptedPuppet>;
  let currentTime: Float = EngineTime.ToFloat(GameInstance.GetSimTime(owner.GetGame()));
  if currentTime - this.m_lastActivationTime < 0.50 {
    return;
  };
  dismembermentInfo = this.GetDismembermentInfo();
  if dismembermentInfo.wasTargetAlreadyDead && dismembermentInfo.timeSinceDeath > 0.50 {
    return;
  };
  if dismembermentInfo.wasTargetAlreadyDefeated && dismembermentInfo.timeSinceDefeat > 0.50 {
    return;
  };
  if dismembermentInfo.attackIsExplosion {
    if !dismembermentInfo.weaponRecord.TagsContains(n"RangedWeapon") {
      return;
    };
    if Vector4.DistanceSquared(dismembermentInfo.targetPosition, dismembermentInfo.attackPosition) > 1.00 {
      return;
    };
  };
  targetPuppet = dismembermentInfo.target as ScriptedPuppet;
  if !IsDefined(targetPuppet) || targetPuppet.IsCrowd() {
    return;
  };
  if this.m_poolSystem.GetStatPoolValue(Cast<StatsObjectID>(owner.GetEntityID()), gamedataStatPoolType.Overshield, false) <= 0.00 {
    return;
  };
  GameInstance.GetStatPoolsSystem(owner.GetGame()).RequestChangingStatPoolValue(Cast<StatsObjectID>(owner.GetEntityID()), gamedataStatPoolType.Overshield, this.m_healAmount, owner, false, this.m_usePercent);
  this.m_lastActivationTime = currentTime;
}
