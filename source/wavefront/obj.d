module wavefront.obj;

import utga;
import std.conv;
import std.stdio;
import std.array;
import std.algorithm;

public import wavefront.geometry;


class Model
{
private:

	Vec3f[] verts_;
	int[][] faces_;


public:

	this(string filename)
	{
		auto f = File(filename, "r");
		foreach (line; f.byLine) {
			if (line.startsWith("v ")) {
				Vec3f v;
				v.raw = line[2..$].splitter.map!(to!float).array;
				verts_ ~= v;
			}
			else if (line.startsWith("f ")) {
				int[] face;
				int tmp;
				foreach (pol; line[2..$].splitter) {
					tmp = to!int(pol.splitter("/").array[0]) - 1;
					face ~= tmp;
				}
				faces_ ~= face;
			}
		}
		stderr.writefln("# v# %d f# %d", verts_.length, faces_.length);
	}

	@property
	auto nverts()
	{
		return verts_.length;
	}

	@property
	auto nfaces()
	{
		return faces_.length;
	}

	auto face(int idx)
	{
		return faces_[idx];
	}

	auto vert(int idx)
	{
		return verts_[idx];
	}

	@property
	auto faces()
	{
		return faces_;
	}
}