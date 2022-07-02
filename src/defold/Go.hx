package defold;

import haxe.extern.EitherType;
import defold.types.*;

/**
    Functions, core hooks, messages and constants for manipulation of
    game objects. The "go" namespace is accessible from game object script
    files.

    See `GoProperties` for related properties.
    See `GoMessages` for related messages.
**/
@:native("_G.go")
extern class Go {
    /**
        Animates a named property of the specified game object or component.

        This is only supported for numerical properties. If the node property is already being
        animated, that animation will be canceled and replaced by the new one.

        If a `complete_function` (lua function) is specified, that function will be called when the animation has completed.
        By starting a new animation in that function, several animations can be sequenced together. See the examples for more information.

        *NOTE!* If you call `go.animate()` from a game object's `final()` function, any passed
        `complete_function` will be ignored and never called upon animation completion.

        See the <a href="/doc/properties">properties guide</a> for which properties can be animated and how.

        @param url url of the game object or component having the property
        @param property name of the property to animate
        @param playback playback mode of the animation
        @param to target property value
        @param easing easing to use during animation. Either specify a constant, see the <a href="/doc/properties">properties guide</a> for a complete list, or a vmath.vector with a curve.
        @param duration duration of the animation in seconds
        @param delay delay before the animation starts in seconds
        @param complete_function function with parameters (self, url, property) to call when the animation has completed
    **/
    // TODO: easing is actually not a Vector3 but any vector created by Vmath.vector and we don't have a type for it right now.
    static function animate<T>(url:HashOrStringOrUrl, property:HashOrString, playback:GoPlayback, to:GoAnimatedProperty, easing:EitherType<GoEasing,Vector3>, duration:Float, ?delay:Float, ?complete_function:T->Url->GoAnimatedProperty->Void):Void;

    /**
        Cancels all animations of the named property of the specified game object or component.

        By calling this function, all stored animations of the given property will be canceled.

        See the <a href="/doc/properties">properties guide</a> for which properties can be animated and how.

        @param url url of the game object or component having the property
        @param property name of the property to animate
    **/
    static function cancel_animations(url:HashOrStringOrUrl, property:HashOrString):Void;

    /**
        Delete one or more game objects identified by id. Deletion is asynchronous meaning that
        the game object(s) are scheduled for deletion which will happen at the end of the current
        frame. Note that game objects scheduled for deletion will be counted against
        `max_instances` in "game.project" until they are actually removed.

        @param id optional id or table of id's of the instance(s) to delete, the instance of the calling script is deleted by default
        @param recursive optional boolean, set to true to recursively delete child hiearchy in child to parent order
    **/
    @:overload(function(?id:lua.Table<Int,Hash>, ?recursive:Bool):Void {})
    static function delete(?id:HashOrStringOrUrl, ?recursive:Bool):Void;

    /**
        Gets a named property of the specified game object or component.

        @param url url of the game object or component having the property
        @param id id of the property to retrieve
        @param options (optional) options table - index integer index into array property (1 based) - key hash name of internal property
        @return the value of the specified property
    **/
    @:overload(function(url:HashOrStringOrUrl, id:HashOrString, ?options:lua.Table.AnyTable):GoProperty {})
    static function get<T>(url:HashOrStringOrUrl, id:Property<T>, ?options:lua.Table.AnyTable):T;

    /**
        Returns or constructs an instance identifier. The instance id is a hash
        of the absolute path to the instance.

        If `path` is specified, it can either be absolute or relative to the instance of the calling script.
        If `path` is not specified, the id of the game object instance the script is attached to will be returned.

        @param path path of the instance for which to return the id
        @return instance id
    **/
    static function get_id(?path:String):Hash;

    /**
        Gets the position of a game object instance.

        The position is relative the parent (if any).
        Use `Go.get_world_position` to retrieve the global world position.

        @param id optional id of the game object instance to get the position for, by default the instance of the calling script
        @return instance position
    **/
    static function get_position(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the rotation of the game object instance.

        The rotation is relative to the parent (if any).
        Use `Go.get_world_rotation` to retrieve the global world position.

        @param id optional id of the game object instance to get the rotation for, by default the instance of the calling script
        @return instance rotation
    **/
    static function get_rotation(?id:HashOrStringOrUrl):Quaternion;

    /**
        Gets the 3D scale factor of the game object instance.

        The scale is relative the parent (if any).
        Use `Go.get_world_scale` to retrieve the global world 3D scale factor.

        @param id optional id of the game object instance to get the scale for, by default the instance of the calling script
        @return instance scale factor
    **/
    static function get_scale(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the uniform scale factor of the game object instance.

        The uniform scale is relative the parent (if any).
        If the underlying scale vector is non-uniform the min element of the vector is returned as the uniform scale factor.

        @param id optional id of the game object instance to get the uniform scale for, by default the instance of the calling script
        @return uniform instance scale factor
    **/
    static function get_scale_uniform(?id:HashOrStringOrUrl):Float;

    /**
        Get the parent for a game object instance.

        @param id optional id of the game object instance to get parent for, defaults to the instance containing the calling script
        @param parent instance or nil
    **/
    static function get_parent(?id:HashOrStringOrUrl):Hash;

    /**
        Gets the game object instance world position.

        Use `Go.get_position` to retrieve the position relative to the parent.

        @param id optional id of the game object instance to get the world position for, by default the instance of the calling script
        @return instance world position
    **/
    static function get_world_position(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the game object instance world rotation.

        Use `Go.get_rotation` to retrieve the rotation relative to the parent.

        @param id optional id of the game object instance to get the world rotation for, by default the instance of the calling script
        @return instance world rotation
    **/
    static function get_world_rotation(?id:HashOrStringOrUrl):Quaternion;

    /**
        Gets the game object instance world 3D scale factor.

        Use `Go.get_scale` to retrieve the 3D scale factor relative to the parent.
        This vector is derived by decomposing the transformation matrix and should be used with care.
        For most cases it should be fine to use `Go.get_world_scale_uniform` instead.

        @param id optional id of the game object instance to get the world scale for, by default the instance of the calling script
        @return uniform instance world scale factor
    **/
    static function get_world_scale(?id:HashOrStringOrUrl):Vector3;

    /**
        Gets the uniform game object instance world scale factor.

        Use `go.get_scale_uniform` to retrieve the scale factor relative to the parent.

        @param id optional id of the game object instance to get the world scale for, by default the instance of the calling script
        @return instance world scale factor
    **/
    static function get_world_scale_uniform(?id:HashOrStringOrUrl):Float;

    /**
        Gets the world transform of a game object instance.

        @param id optional id of the game object instance to get the world transform for, by default the instance of the calling script
        @return instance world transform
    **/
    static function get_world_transform(?id:HashOrStringOrUrl):Matrix4;

    /**
        Sets a named property of the specified game object or component.

        @param url url of the game object or component having the property
        @param id id of the property to set
        @param options (optional) options table - index integer index into array property (1 based) - key hash name of internal property
        @param value the value to set
    **/
    @:overload(function(url:HashOrStringOrUrl, id:HashOrString, value:GoProperty, ?options:lua.Table.AnyTable):Void {})
    static function set<T>(url:HashOrStringOrUrl, id:Property<T>, value:T, ?options:lua.Table.AnyTable):Void;

    /**
        Sets the parent for a game object instance. This means that the instance will exist in the geometrical space of its parent,
        like a basic transformation hierarchy or scene graph. If no parent is specified, the instance will be detached from any parent and exist in world space.

        @param id optional id of the game object instance to set parent for, defaults to the instance containing the calling script
        @param parent_id optional id of the new parent game object, defaults to detaching game object from its parent
        @param keep_world_transform optional boolean, set to true to maintain the world transform when changing spaces. Defaults to false.
    **/
    static function set_parent(?id:HashOrStringOrUrl, ?parent_id:HashOrStringOrUrl, ?keep_world_transform:Bool):Void;

    /**
        Sets the position of the game object instance.

        The position is relative to the parent (if any).
        The global world position cannot be manually set.

        @param position position to set
        @param id optional id of the game object instance to set the position for, by default the instance of the calling script
    **/
    static function set_position(position:Vector3, ?id:HashOrStringOrUrl):Void;

    /**
        Sets the rotation of the game object instance.

        The rotation is relative to the parent (if any).
        The global world rotation cannot be manually set.

        @param rotation rotation to set
        @param id optional id of the game object instance to get the rotation for, by default the instance of the calling script
    **/
    static function set_rotation(rotation:Quaternion, ?id:HashOrStringOrUrl):Void;

    /**
        Sets the scale factor of the game object instance.

        The scale factor is relative to the parent (if any). The global world scale factor cannot be manually set.

        *NOTE!* Physics are currently not affected when setting scale from this function.

        @param scale vector or uniform scale factor, must be greater than 0
        @param id optional id of the game object instance to get the scale for, by default the instance of the calling script
    **/
    static function set_scale(scale:EitherType<Float,Vector3>, ?id:HashOrStringOrUrl):Void;
}

/**
    Properties related to the `Go` module.
**/
@:publicFields
class GoProperties {
    /**
        The rotation of the game object expressed in Euler angles.
        Euler angles are specified in degrees in the interval (-360, 360).
    **/
    static var euler(default, never) = new Property<Vector3>("euler");

    /**
        The position of the game object.
    **/
    static var position(default, never) = new Property<Vector3>("position");

    /**
        The rotation of the game object.
    **/
    static var rotation(default, never) = new Property<Quaternion>("rotation");

    /**
        The uniform scale of the game object.
    **/
    static var scale(default, never) = new Property<Float>("scale");
}

/**
    Messages related to the `Go` module.
**/
@:publicFields
class GoMessages {
    /**
        Acquires the user input focus.

        Post this message to a game object instance to make that instance acquire the user input focus.

        User input is distributed by the engine to every instance that has requested it. The last instance
        to request focus will receive it first. This means that the scripts in the instance will have
        first-hand-chance at reacting on user input, possibly consuming it so that no other instances
        can react on it. The most common case is for a script to send this message to itself when it needs to
        respond to user input.

        A script belonging to an instance which has the user input focus will receive the input actions
        in its `on_input` callback function. See `on_input` for more information on
        how user input can be handled.
    **/
    static var acquire_input_focus(default, never) = new Message<Void>("acquire_input_focus");

    /**
        Disables the receiving component.

        This message disables the receiving component. All components are enabled by default, which means they will receive input, updates
        and be a part of the simulation. A component is disabled when it receives the `disable` message.

        *Note!* Components that currently supports this message are:

           * Collection Proxy
           * Collision Object
           * Gui
           * Label
           * Spine Model
           * Sprite
           * Tile Grid
           * Model
    **/
    static var disable(default, never) = new Message<Void>("disable");

    /**
        Enables the receiving component.

        This message enables the receiving component. All components are enabled by default, which means they will receive input, updates
        and be a part of the simulation. A component is disabled when it receives the `disable` message.

        *Note!* Components that currently supports this message are:

           * Collection Proxy
           * Collision Object
           * Gui
           * Spine Model
           * Sprite
           * Tile Grid
           * Model
    **/
    static var enable(default, never) = new Message<Void>("enable");

    /**
        Releases the user input focus.

        Post this message to an instance to make that instance release the user input focus.
        See `acquire_input_focus` for more information on how the user input handling
        works.
    **/
    static var release_input_focus(default, never) = new Message<Void>("release_input_focus");

    /**
        Sets the parent of the receiving instance.

        When this message is sent to an instance, it sets the parent of that instance. This means that the instance will exist
        in the geometrical space of its parent, like a basic transformation hierarchy or scene graph. If no parent is specified,
        the instance will be detached from any parent and exist in world space. A script can send this message to itself to set
        the parent of its instance.
    **/
    static var set_parent(default, never) = new Message<GoMessageSetParent>("set_parent");
}

/**
    Data for the `GoMessages.set_parent` message.
**/
typedef GoMessageSetParent = {
    /**
        the id of the new parent
    **/
    @:optional var parent_id:Hash;

    /**
        if the world transform of the instance should be preserved when changing spaces, 0 for false and 1 for true. The default value is 1.
    **/
    @:optional var keep_world_transform:Int;
}

/**
    Possible types of a game object property.
**/
abstract GoProperty(Dynamic)
    from Float to Float
    from Hash to Hash
    from Url to Url
    from Vector3 to Vector3
    from Vector4 to Vector4
    from Quaternion to Quaternion
    from Bool to Bool
    from AtlasResourceReference to AtlasResourceReference
    from FontResourceReference to FontResourceReference
    from MaterialResourceReference to MaterialResourceReference
    from TextureResourceReference to TextureResourceReference
    from TileSourceResourceReference to TileSourceResourceReference
    from BufferResourceReference to BufferResourceReference
    {}

/**
    Possible types of game object property suitable for animation.
**/
abstract GoAnimatedProperty(Dynamic)
    from Vector3 to Vector3
    from Vector4 to Vector4
    from Quaternion to Quaternion
    from Float to Float
    {}

/**
    Game object easing constants.
**/
@:native("_G.go")
@:enum abstract GoEasing(Int) {
    /**
        Linear interpolation.
    **/
    var EASING_LINEAR = 0;

    /**
        In-quadratic.
    **/
    var EASING_INQUAD = 1;

    /**
        Out-quadratic.
    **/
    var EASING_OUTQUAD = 2;

    /**
        In-out-quadratic.
    **/
    var EASING_INOUTQUAD = 3;

    /**
        Out-in-quadratic.
    **/
    var EASING_OUTINQUAD = 4;

    /**
        In-cubic.
    **/
    var EASING_INCUBIC = 5;

    /**
        Out-cubic.
    **/
    var EASING_OUTCUBIC = 6;

    /**
        In-out-cubic.
    **/
    var EASING_INOUTCUBIC = 7;

    /**
        Out-in-cubic.
    **/
    var EASING_OUTINCUBIC = 8;

    /**
        In-quartic.
    **/
    var EASING_INQUART = 9;

    /**
        Out-quartic.
    **/
    var EASING_OUTQUART = 10;

    /**
        In-out-quartic.
    **/
    var EASING_INOUTQUART = 11;

    /**
        Out-in-quartic.
    **/
    var EASING_OUTINQUART = 12;

    /**
        In-quintic.
    **/
    var EASING_INQUINT = 13;

    /**
        Out-quintic.
    **/
    var EASING_OUTQUINT = 14;

    /**
        In-out-quintic.
    **/
    var EASING_INOUTQUINT = 15;

    /**
        Out-in-quintic.
    **/
    var EASING_OUTINQUINT = 16;

    /**
        In-sine.
    **/
    var EASING_INSINE = 17;

    /**
        Out-sine.
    **/
    var EASING_OUTSINE = 18;

    /**
        In-out-sine.
    **/
    var EASING_INOUTSINE = 19;

    /**
        Out-in-sine.
    **/
    var EASING_OUTINSINE = 20;

    /**
        In-exponential.
    **/
    var EASING_INEXPO = 21;

    /**
        Out-exponential.
    **/
    var EASING_OUTEXPO = 22;

    /**
        In-out-exponential.
    **/
    var EASING_INOUTEXPO = 23;

    /**
        Out-in-exponential.
    **/
    var EASING_OUTINEXPO = 24;

    /**
        In-circlic.
    **/
    var EASING_INCIRC = 25;

    /**
        Out-circlic.
    **/
    var EASING_OUTCIRC = 26;

    /**
        In-out-circlic.
    **/
    var EASING_INOUTCIRC = 27;

    /**
        Out-in-circlic.
    **/
    var EASING_OUTINCIRC = 28;

    /**
        In-elastic.
    **/
    var EASING_INELASTIC = 29;

    /**
        Out-elastic.
    **/
    var EASING_OUTELASTIC = 30;

    /**
        In-out-elastic.
    **/
    var EASING_INOUTELASTIC = 31;

    /**
        Out-in-elastic.
    **/
    var EASING_OUTINELASTIC = 32;

    /**
        In-back.
    **/
    var EASING_INBACK = 33;

    /**
        Out-back.
    **/
    var EASING_OUTBACK = 34;

    /**
        In-out-back.
    **/
    var EASING_INOUTBACK = 35;

    /**
        Out-in-back.
    **/
    var EASING_OUTINBACK = 36;

    /**
        In-bounce.
    **/
    var EASING_INBOUNCE = 37;

    /**
        Out-bounce.
    **/
    var EASING_OUTBOUNCE = 38;

    /**
        In-out-bounce.
    **/
    var EASING_INOUTBOUNCE = 39;

    /**
        Out-in-bounce.
    **/
    var EASING_OUTINBOUNCE = 40;
}

/**
    Game object playback constants.
**/
@:native("_G.go")
@:enum abstract GoPlayback(Int) {
    /**
        No playback.
    **/
    var PLAYBACK_NONE = 0;

    /**
        Once forward.
    **/
    var PLAYBACK_ONCE_FORWARD = 1;

    /**
        Once backward.
    **/
    var PLAYBACK_ONCE_BACKWARD = 2;

    /**
        Once ping pong.
    **/
    var PLAYBACK_ONCE_PINGPONG = 3;

    /**
        Loop forward.
    **/
    var PLAYBACK_LOOP_FORWARD = 4;

    /**
        Loop backward.
    **/
    var PLAYBACK_LOOP_BACKWARD = 5;

    /**
        Ping pong loop.
    **/
    var PLAYBACK_LOOP_PINGPONG = 6;
}
