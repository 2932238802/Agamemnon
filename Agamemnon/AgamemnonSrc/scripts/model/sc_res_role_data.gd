extends Resource

class_name  RoleData

# id 就是唯一标识符
# 然后 display_name 就是显示的名字 一般是中文
@export var id:String
@export var display_name:String

# 一段世界观的介绍
@export_multiline var description:String

# 被动名字
# 还有一个是 主动技能的冷却时间
@export var passive_skill_name:String
@export var passive_skill_desc:String
@export var active_skill_name:String
@export var active_skill_desc:String
@export var active_skill_cooldowntime:int = 2


