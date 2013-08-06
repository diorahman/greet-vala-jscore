namespace Hello{

    namespace JS{

        public class App : GLib.Object{

            public void * context { get; set; }
            public string name { get; set; }

            public App(void * ctx, Page p, string n){
                context = ctx;
                setup(n);
            }

            public static JSCore.Object class_constructor(JSCore.Context ctx, JSCore.Object constructor,  JSCore.Value[] arguments, out JSCore.Value exception) 
            {
                var c = new JSCore.Class (class_definition);
                var o = new JSCore.Object (ctx, c, null);

                /*
                    Do something with object
                */

                return o;
            }

            static const JSCore.StaticFunction[] class_functions = {
                { "hello", function_hello, JSCore.PropertyAttribute.ReadOnly },
                { null, null, 0 }
            };

            public static JSCore.Value function_hello (JSCore.Context ctx,
                JSCore.Object function,
                JSCore.Object thisObject,
                JSCore.Value[] arguments,
                out JSCore.Value exception) 
            {
                
                // args[0] -> { name : foo} -- options
                // args[1] -> function(err, retObj){} -- callback

                var name = Jalak.Util.string_property_from_value(ctx, arguments[0], "name");

                var callback = Jalak.Util.string_from_js_string(arguments[1].to_string_copy (ctx, null));

                var args = "null, {status : 'ok', name : '" + name + " creature!' }";

                Jalak.Util.evaluate_callback(ctx, callback, args);
                
                return new JSCore.Value.undefined (ctx);
            }

            private void setup(string class_name){
                name = class_name;
                var str = new JSCore.String.with_utf8_c_string (class_name);
                var class = new JSCore.Class (class_definition);
                var obj = new JSCore.Object ((JSCore.GlobalContext) context, class, (JSCore.GlobalContext) context);
                var global_ctx = ((JSCore.GlobalContext) context).get_global_object ();
                global_ctx.set_property ((JSCore.GlobalContext) context, str, obj, JSCore.PropertyAttribute.None, null);
            }

            static const JSCore.ClassDefinition class_definition = {
            0,
            JSCore.ClassAttribute.None,
            "App",
            null,

            null,
            class_functions,

            null,
            null,

            null,
            null,
            null,
            null,

            null,
            null,
            class_constructor,
            null,
            null
            };
        }
    }
}