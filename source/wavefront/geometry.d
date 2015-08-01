module wavefront.geometry;

import std.math;
import std.conv;


alias Vec2!float Vec2f;
alias Vec2!int   Vec2i;
alias Vec3!float Vec3f;
alias Vec3!int   Vec3i;

struct Vec2(T) {
	union {
		struct { T u, v;};
		struct { T x, y;};
		T[2] raw;
	}

	this (T _x, T _y)
	{
		x = _x;
		y = _y;
	}

	Vec2!T opBinary(string op)(Vec2!T V) if (op == "+")
	{
		return Vec2!T(x+V.x, y+V.y);
	}

	Vec2!T opBinary(string op)(Vec2!T V) if (op == "-")
	{
		return Vec2!T(x-V.x, y-V.y);
	}

	Vec2!T opBinary(string op)(float f) if (op == "*")
	{
		return Vec2!T(cast(T)x*f, cast(T)y*f);
	}

	string toString()
	{
		return "(" ~ to!string(x) ~ ", " ~ to!string(y) ~ ")";
	}
}

struct Vec3(T) {
	union {
		struct { T x, y, z;};
		struct { T ivert, iuv, inorm;}
		T[3] raw;
	}
	
	this (T _x, T _y, T _z)
	{
		x = _x;
		y = _y;
		z = _z;
	}

	auto opBinary(string op)(Vec3!T V) if (op == "^")
	{
		return Vec3(y*V.z-z*V.y, z*V.x-x*V.z, x*V.y-y*V.x);
	}

	auto opBinary(string op)(Vec3!T V) if (op == "+")
	{
		return Vec3(x+V.x, x+V.x, z+V.z);
	}
	
	auto opBinary(string op)(Vec3!T V) if (op == "-")
	{
		return Vec3(x-V.x, y-V.y, z-V.z);
	}

	auto opBinary(string op)(float f) if (op == "*")
	{
		return Vec3!T(cast(T)(x*f), cast(T)(y*f), cast(T)(z*f));
	}

	auto opBinary(string op)(Vec3!T V) if (op == "*")
	{
		return x*V.x + y*V.y + z*V.z;
	}

	auto norm ()
	{
		return sqrt(cast(float)x*x+y*y+z*z);
	}

	auto normalize (T l=1)
	{
		this = this * cast(T)(l/norm());
		return this;
	}

	string toString()
	{
		return "(" ~ to!string(x) ~ ", " ~ to!string(y) ~ ", " ~ to!string(z) ~ ")";
	}
}