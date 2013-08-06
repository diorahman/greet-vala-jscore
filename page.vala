namespace Hello{
  public class Page : WebKit.WebView{
    public Page(){
      var settings = new WebKit.WebSettings();
      settings.enable_file_access_from_file_uris = true;
      settings.enable_universal_access_from_file_uris = true;
      window_object_cleared.connect(this.on_window_object_cleared);
    }

    private void on_window_object_cleared(WebKit.WebFrame frame, void * context){
      App.init(context, this);
    }

    public void load(){
      load_uri("file://" + Environment.get_current_dir() + "/public/index.html");
    }
  }
}