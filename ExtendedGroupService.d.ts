type Parameter = string | number | Player;

declare namespace ExtendedGroupService {
  export function GetGroupsAsync(this: typeof ExtendedGroupService, user: Parameter): GetGroupsAsyncResult;
  export function GetGroupAlliesAsync(this: typeof ExtendedGroupService, groupId: number): GroupInfo[];
  export function GetGroupEnemiesAsync(this: typeof ExtendedGroupService, groupId: number): GroupInfo[];
  export function GetGroupInfoAsync(this: typeof ExtendedGroupService, groupId: number): GroupInfo;
  export function GetRankInGroupAsync(this: typeof ExtendedGroupService, user: Parameter, groupId: number): number;
  export function GetRoleInGroupAsync(this: typeof ExtendedGroupService, user: Parameter, groupId: number): string;
  export function GetPrimaryGroupAsync(this: typeof ExtendedGroupService, user: Parameter): GroupInfo | undefined;
  export function IsInGroupAsync(this: typeof ExtendedGroupService, user: Parameter, groupId: number): boolean;
  export function IsPrimaryGroupAsync(this: typeof ExtendedGroupService, user: Parameter, groupId: number): boolean;
  export function IsGroupAlly(this: typeof ExtendedGroupService, groupId: number, allyGroupId: number): boolean;
  export function IsGroupEnemy(this: typeof ExtendedGroupService, groupId: number, enemyGroupId: number): boolean;
}

export = ExtendedGroupService;
