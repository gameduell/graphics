package backends.graphics_stage3d.assembler;
import haxe.ds.StringMap;
 
class RegMap
{
	static public var map(get_map, never) : StringMap<Reg>;

	static public var _map : StringMap<Reg>;
	static public function get_map() : StringMap<Reg> {
		if(RegMap._map == null)  {
			RegMap._map = new StringMap<Reg>();
			RegMap._map.set("va", new Reg(0x00, "vertex attribute"));
			RegMap._map.set("fc", new Reg(0x01, "fragment constant"));
			RegMap._map.set("vc", new Reg(0x01, "vertex constant"));
			RegMap._map.set("ft", new Reg(0x02, "fragment temporary"));
			RegMap._map.set("vt", new Reg(0x02, "vertex temporary"));
			RegMap._map.set("vo", new Reg(0x03, "vertex output"));
			RegMap._map.set("op", new Reg(0x03, "vertex output"));
			RegMap._map.set("fd", new Reg(0x03, "fragment depth output"));
			RegMap._map.set("fo", new Reg(0x03, "fragment output"));
			RegMap._map.set("oc", new Reg(0x03, "fragment output"));
			RegMap._map.set("v", new Reg(0x04, "varying"));
			RegMap._map.set("vi", new Reg(0x04, "varying output"));
			RegMap._map.set("fi", new Reg(0x04, "varying input"));
			RegMap._map.set("fs", new Reg(0x05, "sampler"));
		}
		return RegMap._map;
	}

	public function new() {
	}

}

