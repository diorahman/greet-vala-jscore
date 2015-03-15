using Gtk;
using WebKit;

namespace Hello{
  public class Page : WebKit.WebView{
    public Page(){
      var settings = get_settings();
      settings.enable_file_access_from_file_uris = true;
      settings.enable_universal_access_from_file_uris = true;
      
      // if debug
      settings.enable_developer_extras = true;
      web_inspector.inspect_web_view.connect(getInspectorView);
      
      window_object_cleared.connect(this.on_window_object_cleared);
    }

    private void on_window_object_cleared(WebKit.WebFrame frame, void * context){
      App.init(context, this);
    }

    private unowned WebView getInspectorView(WebView inspectedView) {
      Window window = new Window();
      WebView webview = new WebView();

      ScrolledWindow scrolled_window = new ScrolledWindow(null, null);
      scrolled_window.set_policy(PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
      
      scrolled_window.add(webview);
      window.add(scrolled_window);

      window.title = "Inpector";
      window.set_default_size(640, 480);

      window.show_all();
      window.delete_event.connect(() => {
        webview.web_inspector.close();
	return false;
      });

      unowned WebView handle = webview;
      return handle;
    }

    public void load(){
      load_uri("file://" + Environment.get_current_dir() + "/public/index.html");
    }
  }
}
