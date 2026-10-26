class_name DamageData extends RefCounted

enum Strength{
    LIGHT,
    MEDIUM,
    STRONG
}

enum Reaction{
    NONE,
    KNOCK_BACK,
    KNOCK_DOWN,
    LAUNCH,
    GRAB,
}

## How much damage will be applied to the enemy
@export var amount: int = 1
## How the target should react to this damage
@export var reaction: Reaction = Reaction.KNOCK_BACK
## How many frames the enemy should be stunned for.
@export var hit_stun: int = 10
## The strength level of the attack
@export var strength: Strength = Strength.LIGHT

## What direction is the attack coming from
var direction: Vector3

func _init(_direction:=Vector3.ZERO, _amount:int=1, _reaction:Reaction=Reaction.KNOCK_BACK) -> void:
    amount = _amount
    reaction = _reaction
    direction = _direction
