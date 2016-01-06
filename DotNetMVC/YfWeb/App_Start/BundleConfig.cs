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

            bundles.Add(new StyleBundle("~/Content/css").Include(
                "~/Content/fonts/linecons/css/linecons.css",
                "~/Content/fonts/fontawesome/css/font-awesome.min.css",
                "~/Content/xenon-core.css",
                "~/Content/bootstrap.css",
                "~/Content/custom.css"));

        }
    }
}