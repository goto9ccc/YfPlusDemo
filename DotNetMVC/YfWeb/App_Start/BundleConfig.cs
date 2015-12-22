using System.Web;
using System.Web.Optimization;

namespace YfWeb
{
    public class BundleConfig
    {

        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));
            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
            "~/Scripts/bootstrap.min.js"));
            bundles.Add(new ScriptBundle("~/bundles/xenon").Include(
            "~/Scripts/bootstrap.min.js",
            "~/Scripts/TweenMax.min.js",
            "~/Scripts/resizeable.js",
            "~/Scripts/joinable.j",
            "~/Scripts/xenon-api.js",
            "~/Scripts/xenon-toggles.js",
            "~/Scripts/xenon-widgets.js",
            "~/Scripts/globalize.min.js",
            "~/Scripts/dx.chartjs.js",
            "~/Scripts/toastr.min.js",
            "~/Scripts/xenon-custom.js"
            ));

            bundles.Add(new StyleBundle("~/Content/css").Include("~/Content/bootstrap.css",
                "~/Content/fonts/linecons/css/linecons.css",
                "~/Content/fonts/fontawesome/css/font-awesome.min.css",
                "~/Content/xenon-core.css",
                "~/Content/xenon-forms.css",
                "~/Content/xenon-components.css",
                "~/Content/xenon-skins.css",
                "~/Content/custom.css"));

        }
    }
}